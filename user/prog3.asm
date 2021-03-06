
user/_prog3:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h" 
#include "kernel/stat.h" 
#include "user/user.h" 
int main(int argc, char *argv[]) 
{ 
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    //FUNCTION_SETS_NUMBER_OF_TICKETS(30);    // write your own function here
		set_tickets(10);
   8:	4529                	li	a0,10
   a:	00000097          	auipc	ra,0x0
   e:	34a080e7          	jalr	842(ra) # 354 <set_tickets>
  12:	06400713          	li	a4,100
    int i,k; 
    const int loop=100; // adjust this parameter depending on your system speed 
    for(i=0;i<loop;i++) 
    { 
        asm("nop");  // to prevent the compiler from optimizing the for-loop 
  16:	06400693          	li	a3,100
  1a:	a019                	j	20 <main+0x20>
    for(i=0;i<loop;i++) 
  1c:	377d                	addiw	a4,a4,-1
  1e:	c719                	beqz	a4,2c <main+0x2c>
        asm("nop");  // to prevent the compiler from optimizing the for-loop 
  20:	0001                	nop
  22:	87b6                	mv	a5,a3
        for(k=0;k<loop;k++) 
        { 
           asm("nop"); 
  24:	0001                	nop
        for(k=0;k<loop;k++) 
  26:	37fd                	addiw	a5,a5,-1
  28:	fff5                	bnez	a5,24 <main+0x24>
  2a:	bfcd                	j	1c <main+0x1c>
        } 
    } 
    sched_statistics();  // syscall 
  2c:	00000097          	auipc	ra,0x0
  30:	330080e7          	jalr	816(ra) # 35c <sched_statistics>
	 exit(0);
  34:	4501                	li	a0,0
  36:	00000097          	auipc	ra,0x0
  3a:	27e080e7          	jalr	638(ra) # 2b4 <exit>

000000000000003e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  3e:	1141                	addi	sp,sp,-16
  40:	e422                	sd	s0,8(sp)
  42:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  44:	87aa                	mv	a5,a0
  46:	0585                	addi	a1,a1,1
  48:	0785                	addi	a5,a5,1
  4a:	fff5c703          	lbu	a4,-1(a1)
  4e:	fee78fa3          	sb	a4,-1(a5)
  52:	fb75                	bnez	a4,46 <strcpy+0x8>
    ;
  return os;
}
  54:	6422                	ld	s0,8(sp)
  56:	0141                	addi	sp,sp,16
  58:	8082                	ret

000000000000005a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  5a:	1141                	addi	sp,sp,-16
  5c:	e422                	sd	s0,8(sp)
  5e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  60:	00054783          	lbu	a5,0(a0)
  64:	cb91                	beqz	a5,78 <strcmp+0x1e>
  66:	0005c703          	lbu	a4,0(a1)
  6a:	00f71763          	bne	a4,a5,78 <strcmp+0x1e>
    p++, q++;
  6e:	0505                	addi	a0,a0,1
  70:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  72:	00054783          	lbu	a5,0(a0)
  76:	fbe5                	bnez	a5,66 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  78:	0005c503          	lbu	a0,0(a1)
}
  7c:	40a7853b          	subw	a0,a5,a0
  80:	6422                	ld	s0,8(sp)
  82:	0141                	addi	sp,sp,16
  84:	8082                	ret

0000000000000086 <strlen>:

uint
strlen(const char *s)
{
  86:	1141                	addi	sp,sp,-16
  88:	e422                	sd	s0,8(sp)
  8a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  8c:	00054783          	lbu	a5,0(a0)
  90:	cf91                	beqz	a5,ac <strlen+0x26>
  92:	0505                	addi	a0,a0,1
  94:	87aa                	mv	a5,a0
  96:	4685                	li	a3,1
  98:	9e89                	subw	a3,a3,a0
  9a:	00f6853b          	addw	a0,a3,a5
  9e:	0785                	addi	a5,a5,1
  a0:	fff7c703          	lbu	a4,-1(a5)
  a4:	fb7d                	bnez	a4,9a <strlen+0x14>
    ;
  return n;
}
  a6:	6422                	ld	s0,8(sp)
  a8:	0141                	addi	sp,sp,16
  aa:	8082                	ret
  for(n = 0; s[n]; n++)
  ac:	4501                	li	a0,0
  ae:	bfe5                	j	a6 <strlen+0x20>

00000000000000b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b0:	1141                	addi	sp,sp,-16
  b2:	e422                	sd	s0,8(sp)
  b4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  b6:	ce09                	beqz	a2,d0 <memset+0x20>
  b8:	87aa                	mv	a5,a0
  ba:	fff6071b          	addiw	a4,a2,-1
  be:	1702                	slli	a4,a4,0x20
  c0:	9301                	srli	a4,a4,0x20
  c2:	0705                	addi	a4,a4,1
  c4:	972a                	add	a4,a4,a0
    cdst[i] = c;
  c6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ca:	0785                	addi	a5,a5,1
  cc:	fee79de3          	bne	a5,a4,c6 <memset+0x16>
  }
  return dst;
}
  d0:	6422                	ld	s0,8(sp)
  d2:	0141                	addi	sp,sp,16
  d4:	8082                	ret

00000000000000d6 <strchr>:

char*
strchr(const char *s, char c)
{
  d6:	1141                	addi	sp,sp,-16
  d8:	e422                	sd	s0,8(sp)
  da:	0800                	addi	s0,sp,16
  for(; *s; s++)
  dc:	00054783          	lbu	a5,0(a0)
  e0:	cb99                	beqz	a5,f6 <strchr+0x20>
    if(*s == c)
  e2:	00f58763          	beq	a1,a5,f0 <strchr+0x1a>
  for(; *s; s++)
  e6:	0505                	addi	a0,a0,1
  e8:	00054783          	lbu	a5,0(a0)
  ec:	fbfd                	bnez	a5,e2 <strchr+0xc>
      return (char*)s;
  return 0;
  ee:	4501                	li	a0,0
}
  f0:	6422                	ld	s0,8(sp)
  f2:	0141                	addi	sp,sp,16
  f4:	8082                	ret
  return 0;
  f6:	4501                	li	a0,0
  f8:	bfe5                	j	f0 <strchr+0x1a>

00000000000000fa <gets>:

char*
gets(char *buf, int max)
{
  fa:	711d                	addi	sp,sp,-96
  fc:	ec86                	sd	ra,88(sp)
  fe:	e8a2                	sd	s0,80(sp)
 100:	e4a6                	sd	s1,72(sp)
 102:	e0ca                	sd	s2,64(sp)
 104:	fc4e                	sd	s3,56(sp)
 106:	f852                	sd	s4,48(sp)
 108:	f456                	sd	s5,40(sp)
 10a:	f05a                	sd	s6,32(sp)
 10c:	ec5e                	sd	s7,24(sp)
 10e:	1080                	addi	s0,sp,96
 110:	8baa                	mv	s7,a0
 112:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 114:	892a                	mv	s2,a0
 116:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 118:	4aa9                	li	s5,10
 11a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 11c:	89a6                	mv	s3,s1
 11e:	2485                	addiw	s1,s1,1
 120:	0344d863          	bge	s1,s4,150 <gets+0x56>
    cc = read(0, &c, 1);
 124:	4605                	li	a2,1
 126:	faf40593          	addi	a1,s0,-81
 12a:	4501                	li	a0,0
 12c:	00000097          	auipc	ra,0x0
 130:	1a0080e7          	jalr	416(ra) # 2cc <read>
    if(cc < 1)
 134:	00a05e63          	blez	a0,150 <gets+0x56>
    buf[i++] = c;
 138:	faf44783          	lbu	a5,-81(s0)
 13c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 140:	01578763          	beq	a5,s5,14e <gets+0x54>
 144:	0905                	addi	s2,s2,1
 146:	fd679be3          	bne	a5,s6,11c <gets+0x22>
  for(i=0; i+1 < max; ){
 14a:	89a6                	mv	s3,s1
 14c:	a011                	j	150 <gets+0x56>
 14e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 150:	99de                	add	s3,s3,s7
 152:	00098023          	sb	zero,0(s3)
  return buf;
}
 156:	855e                	mv	a0,s7
 158:	60e6                	ld	ra,88(sp)
 15a:	6446                	ld	s0,80(sp)
 15c:	64a6                	ld	s1,72(sp)
 15e:	6906                	ld	s2,64(sp)
 160:	79e2                	ld	s3,56(sp)
 162:	7a42                	ld	s4,48(sp)
 164:	7aa2                	ld	s5,40(sp)
 166:	7b02                	ld	s6,32(sp)
 168:	6be2                	ld	s7,24(sp)
 16a:	6125                	addi	sp,sp,96
 16c:	8082                	ret

000000000000016e <stat>:

int
stat(const char *n, struct stat *st)
{
 16e:	1101                	addi	sp,sp,-32
 170:	ec06                	sd	ra,24(sp)
 172:	e822                	sd	s0,16(sp)
 174:	e426                	sd	s1,8(sp)
 176:	e04a                	sd	s2,0(sp)
 178:	1000                	addi	s0,sp,32
 17a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 17c:	4581                	li	a1,0
 17e:	00000097          	auipc	ra,0x0
 182:	176080e7          	jalr	374(ra) # 2f4 <open>
  if(fd < 0)
 186:	02054563          	bltz	a0,1b0 <stat+0x42>
 18a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 18c:	85ca                	mv	a1,s2
 18e:	00000097          	auipc	ra,0x0
 192:	17e080e7          	jalr	382(ra) # 30c <fstat>
 196:	892a                	mv	s2,a0
  close(fd);
 198:	8526                	mv	a0,s1
 19a:	00000097          	auipc	ra,0x0
 19e:	142080e7          	jalr	322(ra) # 2dc <close>
  return r;
}
 1a2:	854a                	mv	a0,s2
 1a4:	60e2                	ld	ra,24(sp)
 1a6:	6442                	ld	s0,16(sp)
 1a8:	64a2                	ld	s1,8(sp)
 1aa:	6902                	ld	s2,0(sp)
 1ac:	6105                	addi	sp,sp,32
 1ae:	8082                	ret
    return -1;
 1b0:	597d                	li	s2,-1
 1b2:	bfc5                	j	1a2 <stat+0x34>

00000000000001b4 <atoi>:

int
atoi(const char *s)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ba:	00054603          	lbu	a2,0(a0)
 1be:	fd06079b          	addiw	a5,a2,-48
 1c2:	0ff7f793          	andi	a5,a5,255
 1c6:	4725                	li	a4,9
 1c8:	02f76963          	bltu	a4,a5,1fa <atoi+0x46>
 1cc:	86aa                	mv	a3,a0
  n = 0;
 1ce:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1d0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1d2:	0685                	addi	a3,a3,1
 1d4:	0025179b          	slliw	a5,a0,0x2
 1d8:	9fa9                	addw	a5,a5,a0
 1da:	0017979b          	slliw	a5,a5,0x1
 1de:	9fb1                	addw	a5,a5,a2
 1e0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1e4:	0006c603          	lbu	a2,0(a3)
 1e8:	fd06071b          	addiw	a4,a2,-48
 1ec:	0ff77713          	andi	a4,a4,255
 1f0:	fee5f1e3          	bgeu	a1,a4,1d2 <atoi+0x1e>
  return n;
}
 1f4:	6422                	ld	s0,8(sp)
 1f6:	0141                	addi	sp,sp,16
 1f8:	8082                	ret
  n = 0;
 1fa:	4501                	li	a0,0
 1fc:	bfe5                	j	1f4 <atoi+0x40>

00000000000001fe <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1fe:	1141                	addi	sp,sp,-16
 200:	e422                	sd	s0,8(sp)
 202:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 204:	02b57663          	bgeu	a0,a1,230 <memmove+0x32>
    while(n-- > 0)
 208:	02c05163          	blez	a2,22a <memmove+0x2c>
 20c:	fff6079b          	addiw	a5,a2,-1
 210:	1782                	slli	a5,a5,0x20
 212:	9381                	srli	a5,a5,0x20
 214:	0785                	addi	a5,a5,1
 216:	97aa                	add	a5,a5,a0
  dst = vdst;
 218:	872a                	mv	a4,a0
      *dst++ = *src++;
 21a:	0585                	addi	a1,a1,1
 21c:	0705                	addi	a4,a4,1
 21e:	fff5c683          	lbu	a3,-1(a1)
 222:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 226:	fee79ae3          	bne	a5,a4,21a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret
    dst += n;
 230:	00c50733          	add	a4,a0,a2
    src += n;
 234:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 236:	fec05ae3          	blez	a2,22a <memmove+0x2c>
 23a:	fff6079b          	addiw	a5,a2,-1
 23e:	1782                	slli	a5,a5,0x20
 240:	9381                	srli	a5,a5,0x20
 242:	fff7c793          	not	a5,a5
 246:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 248:	15fd                	addi	a1,a1,-1
 24a:	177d                	addi	a4,a4,-1
 24c:	0005c683          	lbu	a3,0(a1)
 250:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 254:	fee79ae3          	bne	a5,a4,248 <memmove+0x4a>
 258:	bfc9                	j	22a <memmove+0x2c>

000000000000025a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 260:	ca05                	beqz	a2,290 <memcmp+0x36>
 262:	fff6069b          	addiw	a3,a2,-1
 266:	1682                	slli	a3,a3,0x20
 268:	9281                	srli	a3,a3,0x20
 26a:	0685                	addi	a3,a3,1
 26c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 26e:	00054783          	lbu	a5,0(a0)
 272:	0005c703          	lbu	a4,0(a1)
 276:	00e79863          	bne	a5,a4,286 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 27a:	0505                	addi	a0,a0,1
    p2++;
 27c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 27e:	fed518e3          	bne	a0,a3,26e <memcmp+0x14>
  }
  return 0;
 282:	4501                	li	a0,0
 284:	a019                	j	28a <memcmp+0x30>
      return *p1 - *p2;
 286:	40e7853b          	subw	a0,a5,a4
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret
  return 0;
 290:	4501                	li	a0,0
 292:	bfe5                	j	28a <memcmp+0x30>

0000000000000294 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 294:	1141                	addi	sp,sp,-16
 296:	e406                	sd	ra,8(sp)
 298:	e022                	sd	s0,0(sp)
 29a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 29c:	00000097          	auipc	ra,0x0
 2a0:	f62080e7          	jalr	-158(ra) # 1fe <memmove>
}
 2a4:	60a2                	ld	ra,8(sp)
 2a6:	6402                	ld	s0,0(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret

00000000000002ac <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2ac:	4885                	li	a7,1
 ecall
 2ae:	00000073          	ecall
 ret
 2b2:	8082                	ret

00000000000002b4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2b4:	4889                	li	a7,2
 ecall
 2b6:	00000073          	ecall
 ret
 2ba:	8082                	ret

00000000000002bc <wait>:
.global wait
wait:
 li a7, SYS_wait
 2bc:	488d                	li	a7,3
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2c4:	4891                	li	a7,4
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <read>:
.global read
read:
 li a7, SYS_read
 2cc:	4895                	li	a7,5
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <write>:
.global write
write:
 li a7, SYS_write
 2d4:	48c1                	li	a7,16
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <close>:
.global close
close:
 li a7, SYS_close
 2dc:	48d5                	li	a7,21
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2e4:	4899                	li	a7,6
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <exec>:
.global exec
exec:
 li a7, SYS_exec
 2ec:	489d                	li	a7,7
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <open>:
.global open
open:
 li a7, SYS_open
 2f4:	48bd                	li	a7,15
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2fc:	48c5                	li	a7,17
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 304:	48c9                	li	a7,18
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 30c:	48a1                	li	a7,8
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <link>:
.global link
link:
 li a7, SYS_link
 314:	48cd                	li	a7,19
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 31c:	48d1                	li	a7,20
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 324:	48a5                	li	a7,9
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <dup>:
.global dup
dup:
 li a7, SYS_dup
 32c:	48a9                	li	a7,10
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 334:	48ad                	li	a7,11
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 33c:	48b1                	li	a7,12
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 344:	48b5                	li	a7,13
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 34c:	48b9                	li	a7,14
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <set_tickets>:
.global set_tickets
set_tickets:
 li a7, SYS_set_tickets
 354:	48dd                	li	a7,23
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <sched_statistics>:
.global sched_statistics
sched_statistics:
 li a7, SYS_sched_statistics
 35c:	48e1                	li	a7,24
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <hello>:
.global hello
hello:
 li a7, SYS_hello
 364:	48e5                	li	a7,25
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <info>:
.global info
info:
 li a7, SYS_info
 36c:	48d9                	li	a7,22
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 374:	1101                	addi	sp,sp,-32
 376:	ec06                	sd	ra,24(sp)
 378:	e822                	sd	s0,16(sp)
 37a:	1000                	addi	s0,sp,32
 37c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 380:	4605                	li	a2,1
 382:	fef40593          	addi	a1,s0,-17
 386:	00000097          	auipc	ra,0x0
 38a:	f4e080e7          	jalr	-178(ra) # 2d4 <write>
}
 38e:	60e2                	ld	ra,24(sp)
 390:	6442                	ld	s0,16(sp)
 392:	6105                	addi	sp,sp,32
 394:	8082                	ret

0000000000000396 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 396:	7139                	addi	sp,sp,-64
 398:	fc06                	sd	ra,56(sp)
 39a:	f822                	sd	s0,48(sp)
 39c:	f426                	sd	s1,40(sp)
 39e:	f04a                	sd	s2,32(sp)
 3a0:	ec4e                	sd	s3,24(sp)
 3a2:	0080                	addi	s0,sp,64
 3a4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3a6:	c299                	beqz	a3,3ac <printint+0x16>
 3a8:	0805c863          	bltz	a1,438 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3ac:	2581                	sext.w	a1,a1
  neg = 0;
 3ae:	4881                	li	a7,0
 3b0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3b4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3b6:	2601                	sext.w	a2,a2
 3b8:	00000517          	auipc	a0,0x0
 3bc:	44050513          	addi	a0,a0,1088 # 7f8 <digits>
 3c0:	883a                	mv	a6,a4
 3c2:	2705                	addiw	a4,a4,1
 3c4:	02c5f7bb          	remuw	a5,a1,a2
 3c8:	1782                	slli	a5,a5,0x20
 3ca:	9381                	srli	a5,a5,0x20
 3cc:	97aa                	add	a5,a5,a0
 3ce:	0007c783          	lbu	a5,0(a5)
 3d2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3d6:	0005879b          	sext.w	a5,a1
 3da:	02c5d5bb          	divuw	a1,a1,a2
 3de:	0685                	addi	a3,a3,1
 3e0:	fec7f0e3          	bgeu	a5,a2,3c0 <printint+0x2a>
  if(neg)
 3e4:	00088b63          	beqz	a7,3fa <printint+0x64>
    buf[i++] = '-';
 3e8:	fd040793          	addi	a5,s0,-48
 3ec:	973e                	add	a4,a4,a5
 3ee:	02d00793          	li	a5,45
 3f2:	fef70823          	sb	a5,-16(a4)
 3f6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3fa:	02e05863          	blez	a4,42a <printint+0x94>
 3fe:	fc040793          	addi	a5,s0,-64
 402:	00e78933          	add	s2,a5,a4
 406:	fff78993          	addi	s3,a5,-1
 40a:	99ba                	add	s3,s3,a4
 40c:	377d                	addiw	a4,a4,-1
 40e:	1702                	slli	a4,a4,0x20
 410:	9301                	srli	a4,a4,0x20
 412:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 416:	fff94583          	lbu	a1,-1(s2)
 41a:	8526                	mv	a0,s1
 41c:	00000097          	auipc	ra,0x0
 420:	f58080e7          	jalr	-168(ra) # 374 <putc>
  while(--i >= 0)
 424:	197d                	addi	s2,s2,-1
 426:	ff3918e3          	bne	s2,s3,416 <printint+0x80>
}
 42a:	70e2                	ld	ra,56(sp)
 42c:	7442                	ld	s0,48(sp)
 42e:	74a2                	ld	s1,40(sp)
 430:	7902                	ld	s2,32(sp)
 432:	69e2                	ld	s3,24(sp)
 434:	6121                	addi	sp,sp,64
 436:	8082                	ret
    x = -xx;
 438:	40b005bb          	negw	a1,a1
    neg = 1;
 43c:	4885                	li	a7,1
    x = -xx;
 43e:	bf8d                	j	3b0 <printint+0x1a>

0000000000000440 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 440:	7119                	addi	sp,sp,-128
 442:	fc86                	sd	ra,120(sp)
 444:	f8a2                	sd	s0,112(sp)
 446:	f4a6                	sd	s1,104(sp)
 448:	f0ca                	sd	s2,96(sp)
 44a:	ecce                	sd	s3,88(sp)
 44c:	e8d2                	sd	s4,80(sp)
 44e:	e4d6                	sd	s5,72(sp)
 450:	e0da                	sd	s6,64(sp)
 452:	fc5e                	sd	s7,56(sp)
 454:	f862                	sd	s8,48(sp)
 456:	f466                	sd	s9,40(sp)
 458:	f06a                	sd	s10,32(sp)
 45a:	ec6e                	sd	s11,24(sp)
 45c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 45e:	0005c903          	lbu	s2,0(a1)
 462:	18090f63          	beqz	s2,600 <vprintf+0x1c0>
 466:	8aaa                	mv	s5,a0
 468:	8b32                	mv	s6,a2
 46a:	00158493          	addi	s1,a1,1
  state = 0;
 46e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 470:	02500a13          	li	s4,37
      if(c == 'd'){
 474:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 478:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 47c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 480:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 484:	00000b97          	auipc	s7,0x0
 488:	374b8b93          	addi	s7,s7,884 # 7f8 <digits>
 48c:	a839                	j	4aa <vprintf+0x6a>
        putc(fd, c);
 48e:	85ca                	mv	a1,s2
 490:	8556                	mv	a0,s5
 492:	00000097          	auipc	ra,0x0
 496:	ee2080e7          	jalr	-286(ra) # 374 <putc>
 49a:	a019                	j	4a0 <vprintf+0x60>
    } else if(state == '%'){
 49c:	01498f63          	beq	s3,s4,4ba <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4a0:	0485                	addi	s1,s1,1
 4a2:	fff4c903          	lbu	s2,-1(s1)
 4a6:	14090d63          	beqz	s2,600 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 4aa:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4ae:	fe0997e3          	bnez	s3,49c <vprintf+0x5c>
      if(c == '%'){
 4b2:	fd479ee3          	bne	a5,s4,48e <vprintf+0x4e>
        state = '%';
 4b6:	89be                	mv	s3,a5
 4b8:	b7e5                	j	4a0 <vprintf+0x60>
      if(c == 'd'){
 4ba:	05878063          	beq	a5,s8,4fa <vprintf+0xba>
      } else if(c == 'l') {
 4be:	05978c63          	beq	a5,s9,516 <vprintf+0xd6>
      } else if(c == 'x') {
 4c2:	07a78863          	beq	a5,s10,532 <vprintf+0xf2>
      } else if(c == 'p') {
 4c6:	09b78463          	beq	a5,s11,54e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 4ca:	07300713          	li	a4,115
 4ce:	0ce78663          	beq	a5,a4,59a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4d2:	06300713          	li	a4,99
 4d6:	0ee78e63          	beq	a5,a4,5d2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 4da:	11478863          	beq	a5,s4,5ea <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4de:	85d2                	mv	a1,s4
 4e0:	8556                	mv	a0,s5
 4e2:	00000097          	auipc	ra,0x0
 4e6:	e92080e7          	jalr	-366(ra) # 374 <putc>
        putc(fd, c);
 4ea:	85ca                	mv	a1,s2
 4ec:	8556                	mv	a0,s5
 4ee:	00000097          	auipc	ra,0x0
 4f2:	e86080e7          	jalr	-378(ra) # 374 <putc>
      }
      state = 0;
 4f6:	4981                	li	s3,0
 4f8:	b765                	j	4a0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 4fa:	008b0913          	addi	s2,s6,8
 4fe:	4685                	li	a3,1
 500:	4629                	li	a2,10
 502:	000b2583          	lw	a1,0(s6)
 506:	8556                	mv	a0,s5
 508:	00000097          	auipc	ra,0x0
 50c:	e8e080e7          	jalr	-370(ra) # 396 <printint>
 510:	8b4a                	mv	s6,s2
      state = 0;
 512:	4981                	li	s3,0
 514:	b771                	j	4a0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 516:	008b0913          	addi	s2,s6,8
 51a:	4681                	li	a3,0
 51c:	4629                	li	a2,10
 51e:	000b2583          	lw	a1,0(s6)
 522:	8556                	mv	a0,s5
 524:	00000097          	auipc	ra,0x0
 528:	e72080e7          	jalr	-398(ra) # 396 <printint>
 52c:	8b4a                	mv	s6,s2
      state = 0;
 52e:	4981                	li	s3,0
 530:	bf85                	j	4a0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 532:	008b0913          	addi	s2,s6,8
 536:	4681                	li	a3,0
 538:	4641                	li	a2,16
 53a:	000b2583          	lw	a1,0(s6)
 53e:	8556                	mv	a0,s5
 540:	00000097          	auipc	ra,0x0
 544:	e56080e7          	jalr	-426(ra) # 396 <printint>
 548:	8b4a                	mv	s6,s2
      state = 0;
 54a:	4981                	li	s3,0
 54c:	bf91                	j	4a0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 54e:	008b0793          	addi	a5,s6,8
 552:	f8f43423          	sd	a5,-120(s0)
 556:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 55a:	03000593          	li	a1,48
 55e:	8556                	mv	a0,s5
 560:	00000097          	auipc	ra,0x0
 564:	e14080e7          	jalr	-492(ra) # 374 <putc>
  putc(fd, 'x');
 568:	85ea                	mv	a1,s10
 56a:	8556                	mv	a0,s5
 56c:	00000097          	auipc	ra,0x0
 570:	e08080e7          	jalr	-504(ra) # 374 <putc>
 574:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 576:	03c9d793          	srli	a5,s3,0x3c
 57a:	97de                	add	a5,a5,s7
 57c:	0007c583          	lbu	a1,0(a5)
 580:	8556                	mv	a0,s5
 582:	00000097          	auipc	ra,0x0
 586:	df2080e7          	jalr	-526(ra) # 374 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 58a:	0992                	slli	s3,s3,0x4
 58c:	397d                	addiw	s2,s2,-1
 58e:	fe0914e3          	bnez	s2,576 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 592:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 596:	4981                	li	s3,0
 598:	b721                	j	4a0 <vprintf+0x60>
        s = va_arg(ap, char*);
 59a:	008b0993          	addi	s3,s6,8
 59e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 5a2:	02090163          	beqz	s2,5c4 <vprintf+0x184>
        while(*s != 0){
 5a6:	00094583          	lbu	a1,0(s2)
 5aa:	c9a1                	beqz	a1,5fa <vprintf+0x1ba>
          putc(fd, *s);
 5ac:	8556                	mv	a0,s5
 5ae:	00000097          	auipc	ra,0x0
 5b2:	dc6080e7          	jalr	-570(ra) # 374 <putc>
          s++;
 5b6:	0905                	addi	s2,s2,1
        while(*s != 0){
 5b8:	00094583          	lbu	a1,0(s2)
 5bc:	f9e5                	bnez	a1,5ac <vprintf+0x16c>
        s = va_arg(ap, char*);
 5be:	8b4e                	mv	s6,s3
      state = 0;
 5c0:	4981                	li	s3,0
 5c2:	bdf9                	j	4a0 <vprintf+0x60>
          s = "(null)";
 5c4:	00000917          	auipc	s2,0x0
 5c8:	22c90913          	addi	s2,s2,556 # 7f0 <malloc+0xe6>
        while(*s != 0){
 5cc:	02800593          	li	a1,40
 5d0:	bff1                	j	5ac <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 5d2:	008b0913          	addi	s2,s6,8
 5d6:	000b4583          	lbu	a1,0(s6)
 5da:	8556                	mv	a0,s5
 5dc:	00000097          	auipc	ra,0x0
 5e0:	d98080e7          	jalr	-616(ra) # 374 <putc>
 5e4:	8b4a                	mv	s6,s2
      state = 0;
 5e6:	4981                	li	s3,0
 5e8:	bd65                	j	4a0 <vprintf+0x60>
        putc(fd, c);
 5ea:	85d2                	mv	a1,s4
 5ec:	8556                	mv	a0,s5
 5ee:	00000097          	auipc	ra,0x0
 5f2:	d86080e7          	jalr	-634(ra) # 374 <putc>
      state = 0;
 5f6:	4981                	li	s3,0
 5f8:	b565                	j	4a0 <vprintf+0x60>
        s = va_arg(ap, char*);
 5fa:	8b4e                	mv	s6,s3
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	b54d                	j	4a0 <vprintf+0x60>
    }
  }
}
 600:	70e6                	ld	ra,120(sp)
 602:	7446                	ld	s0,112(sp)
 604:	74a6                	ld	s1,104(sp)
 606:	7906                	ld	s2,96(sp)
 608:	69e6                	ld	s3,88(sp)
 60a:	6a46                	ld	s4,80(sp)
 60c:	6aa6                	ld	s5,72(sp)
 60e:	6b06                	ld	s6,64(sp)
 610:	7be2                	ld	s7,56(sp)
 612:	7c42                	ld	s8,48(sp)
 614:	7ca2                	ld	s9,40(sp)
 616:	7d02                	ld	s10,32(sp)
 618:	6de2                	ld	s11,24(sp)
 61a:	6109                	addi	sp,sp,128
 61c:	8082                	ret

000000000000061e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 61e:	715d                	addi	sp,sp,-80
 620:	ec06                	sd	ra,24(sp)
 622:	e822                	sd	s0,16(sp)
 624:	1000                	addi	s0,sp,32
 626:	e010                	sd	a2,0(s0)
 628:	e414                	sd	a3,8(s0)
 62a:	e818                	sd	a4,16(s0)
 62c:	ec1c                	sd	a5,24(s0)
 62e:	03043023          	sd	a6,32(s0)
 632:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 636:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 63a:	8622                	mv	a2,s0
 63c:	00000097          	auipc	ra,0x0
 640:	e04080e7          	jalr	-508(ra) # 440 <vprintf>
}
 644:	60e2                	ld	ra,24(sp)
 646:	6442                	ld	s0,16(sp)
 648:	6161                	addi	sp,sp,80
 64a:	8082                	ret

000000000000064c <printf>:

void
printf(const char *fmt, ...)
{
 64c:	711d                	addi	sp,sp,-96
 64e:	ec06                	sd	ra,24(sp)
 650:	e822                	sd	s0,16(sp)
 652:	1000                	addi	s0,sp,32
 654:	e40c                	sd	a1,8(s0)
 656:	e810                	sd	a2,16(s0)
 658:	ec14                	sd	a3,24(s0)
 65a:	f018                	sd	a4,32(s0)
 65c:	f41c                	sd	a5,40(s0)
 65e:	03043823          	sd	a6,48(s0)
 662:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 666:	00840613          	addi	a2,s0,8
 66a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 66e:	85aa                	mv	a1,a0
 670:	4505                	li	a0,1
 672:	00000097          	auipc	ra,0x0
 676:	dce080e7          	jalr	-562(ra) # 440 <vprintf>
}
 67a:	60e2                	ld	ra,24(sp)
 67c:	6442                	ld	s0,16(sp)
 67e:	6125                	addi	sp,sp,96
 680:	8082                	ret

0000000000000682 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 682:	1141                	addi	sp,sp,-16
 684:	e422                	sd	s0,8(sp)
 686:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 688:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68c:	00000797          	auipc	a5,0x0
 690:	1847b783          	ld	a5,388(a5) # 810 <freep>
 694:	a805                	j	6c4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 696:	4618                	lw	a4,8(a2)
 698:	9db9                	addw	a1,a1,a4
 69a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 69e:	6398                	ld	a4,0(a5)
 6a0:	6318                	ld	a4,0(a4)
 6a2:	fee53823          	sd	a4,-16(a0)
 6a6:	a091                	j	6ea <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6a8:	ff852703          	lw	a4,-8(a0)
 6ac:	9e39                	addw	a2,a2,a4
 6ae:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6b0:	ff053703          	ld	a4,-16(a0)
 6b4:	e398                	sd	a4,0(a5)
 6b6:	a099                	j	6fc <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b8:	6398                	ld	a4,0(a5)
 6ba:	00e7e463          	bltu	a5,a4,6c2 <free+0x40>
 6be:	00e6ea63          	bltu	a3,a4,6d2 <free+0x50>
{
 6c2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c4:	fed7fae3          	bgeu	a5,a3,6b8 <free+0x36>
 6c8:	6398                	ld	a4,0(a5)
 6ca:	00e6e463          	bltu	a3,a4,6d2 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ce:	fee7eae3          	bltu	a5,a4,6c2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 6d2:	ff852583          	lw	a1,-8(a0)
 6d6:	6390                	ld	a2,0(a5)
 6d8:	02059713          	slli	a4,a1,0x20
 6dc:	9301                	srli	a4,a4,0x20
 6de:	0712                	slli	a4,a4,0x4
 6e0:	9736                	add	a4,a4,a3
 6e2:	fae60ae3          	beq	a2,a4,696 <free+0x14>
    bp->s.ptr = p->s.ptr;
 6e6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6ea:	4790                	lw	a2,8(a5)
 6ec:	02061713          	slli	a4,a2,0x20
 6f0:	9301                	srli	a4,a4,0x20
 6f2:	0712                	slli	a4,a4,0x4
 6f4:	973e                	add	a4,a4,a5
 6f6:	fae689e3          	beq	a3,a4,6a8 <free+0x26>
  } else
    p->s.ptr = bp;
 6fa:	e394                	sd	a3,0(a5)
  freep = p;
 6fc:	00000717          	auipc	a4,0x0
 700:	10f73a23          	sd	a5,276(a4) # 810 <freep>
}
 704:	6422                	ld	s0,8(sp)
 706:	0141                	addi	sp,sp,16
 708:	8082                	ret

000000000000070a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 70a:	7139                	addi	sp,sp,-64
 70c:	fc06                	sd	ra,56(sp)
 70e:	f822                	sd	s0,48(sp)
 710:	f426                	sd	s1,40(sp)
 712:	f04a                	sd	s2,32(sp)
 714:	ec4e                	sd	s3,24(sp)
 716:	e852                	sd	s4,16(sp)
 718:	e456                	sd	s5,8(sp)
 71a:	e05a                	sd	s6,0(sp)
 71c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 71e:	02051493          	slli	s1,a0,0x20
 722:	9081                	srli	s1,s1,0x20
 724:	04bd                	addi	s1,s1,15
 726:	8091                	srli	s1,s1,0x4
 728:	0014899b          	addiw	s3,s1,1
 72c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 72e:	00000517          	auipc	a0,0x0
 732:	0e253503          	ld	a0,226(a0) # 810 <freep>
 736:	c515                	beqz	a0,762 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 738:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 73a:	4798                	lw	a4,8(a5)
 73c:	02977f63          	bgeu	a4,s1,77a <malloc+0x70>
 740:	8a4e                	mv	s4,s3
 742:	0009871b          	sext.w	a4,s3
 746:	6685                	lui	a3,0x1
 748:	00d77363          	bgeu	a4,a3,74e <malloc+0x44>
 74c:	6a05                	lui	s4,0x1
 74e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 752:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 756:	00000917          	auipc	s2,0x0
 75a:	0ba90913          	addi	s2,s2,186 # 810 <freep>
  if(p == (char*)-1)
 75e:	5afd                	li	s5,-1
 760:	a88d                	j	7d2 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 762:	00000797          	auipc	a5,0x0
 766:	0b678793          	addi	a5,a5,182 # 818 <base>
 76a:	00000717          	auipc	a4,0x0
 76e:	0af73323          	sd	a5,166(a4) # 810 <freep>
 772:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 774:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 778:	b7e1                	j	740 <malloc+0x36>
      if(p->s.size == nunits)
 77a:	02e48b63          	beq	s1,a4,7b0 <malloc+0xa6>
        p->s.size -= nunits;
 77e:	4137073b          	subw	a4,a4,s3
 782:	c798                	sw	a4,8(a5)
        p += p->s.size;
 784:	1702                	slli	a4,a4,0x20
 786:	9301                	srli	a4,a4,0x20
 788:	0712                	slli	a4,a4,0x4
 78a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 78c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 790:	00000717          	auipc	a4,0x0
 794:	08a73023          	sd	a0,128(a4) # 810 <freep>
      return (void*)(p + 1);
 798:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 79c:	70e2                	ld	ra,56(sp)
 79e:	7442                	ld	s0,48(sp)
 7a0:	74a2                	ld	s1,40(sp)
 7a2:	7902                	ld	s2,32(sp)
 7a4:	69e2                	ld	s3,24(sp)
 7a6:	6a42                	ld	s4,16(sp)
 7a8:	6aa2                	ld	s5,8(sp)
 7aa:	6b02                	ld	s6,0(sp)
 7ac:	6121                	addi	sp,sp,64
 7ae:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7b0:	6398                	ld	a4,0(a5)
 7b2:	e118                	sd	a4,0(a0)
 7b4:	bff1                	j	790 <malloc+0x86>
  hp->s.size = nu;
 7b6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7ba:	0541                	addi	a0,a0,16
 7bc:	00000097          	auipc	ra,0x0
 7c0:	ec6080e7          	jalr	-314(ra) # 682 <free>
  return freep;
 7c4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7c8:	d971                	beqz	a0,79c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7cc:	4798                	lw	a4,8(a5)
 7ce:	fa9776e3          	bgeu	a4,s1,77a <malloc+0x70>
    if(p == freep)
 7d2:	00093703          	ld	a4,0(s2)
 7d6:	853e                	mv	a0,a5
 7d8:	fef719e3          	bne	a4,a5,7ca <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 7dc:	8552                	mv	a0,s4
 7de:	00000097          	auipc	ra,0x0
 7e2:	b5e080e7          	jalr	-1186(ra) # 33c <sbrk>
  if(p == (char*)-1)
 7e6:	fd5518e3          	bne	a0,s5,7b6 <malloc+0xac>
        return 0;
 7ea:	4501                	li	a0,0
 7ec:	bf45                	j	79c <malloc+0x92>
