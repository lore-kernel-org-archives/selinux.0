Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBUMdXqx015450
 for <selinux@tycho.nsa.gov>; Tue, 30 Dec 2014 17:39:33 -0500
Message-ID: <54A3298C.8040509@m4x.org>
Date: Tue, 30 Dec 2014 23:39:08 +0100
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
To: Jason Zaman <jason@perfinion.com>
Subject: Re: [PATCH] run_init: Use a ring buffer in open_init_pty
References: <1419081017-20565-1-git-send-email-jason@perfinion.com>
 <54958580.9090708@m4x.org> <20141220195711.GA30413@meriadoc.Home>
In-Reply-To: <20141220195711.GA30413@meriadoc.Home>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2014-12-20 20:57 GMT+01:00 Jason Zaman:
> On Sat, Dec 20, 2014 at 03:19:44PM +0100, Nicolas Iooss wrote:
>> 2014-12-20 14:10 GMT+01:00 Jason Zaman:
>>> diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
>>> index 4f04e72..fb428a3 100644
>>> [SNIP]
>>> +static void setfd_nonblock(int fd)
>>> +{
>>> +	int fsflags = fcntl(fd, F_GETFL);
>>> +
>>> +	if (fsflags < 0) {
>>> +		fprintf(stderr, "fcntl(%d, F_GETFL): %s\n", fd, strerror(errno));
>>> +		exit(EX_IOERR);
>>> +	}
>>> +
>>> +	if (fcntl(STDIN_FILENO, F_SETFL, fsflags | O_NONBLOCK) < 0) {
>>> +		fprintf(stderr, "fcntl(%d, F_SETFL, ... | O_NONBLOCK): %s\n", fd, strerror(errno));
>>> +		exit(EX_IOERR);
>>> +	}
>>> +}
>>
>> Why does the second fcntl use STDIN_FILENO instead of fd?
> 
> This indeed looks wrong, good catch. I did not touch this part so it
> must have worked in debian for quite a while.
> 
You did not change this in the v2.  Actually the v2 is exactly the same
as the v1 except the git version at the bottom of your mail.  Did you
resubmit the same patch on purpose?

> 
>> Otherwise the patch looks good to me.  I have not tested it as I'm using
>> systemd on my systems running SELinux and I believe it does not use
>> open_init_pty.
> 
> you can test this by building and copying it to /usr/sbin/open_init_pty.
> run_init has that path hard coded so you would have to copy it there.
> You can then test it with "run_init /bin/echo hello" or "run_init id -Z"

That's unfortunately not so simple.  "strace run_init /usr/bin/id -Z"
tells me:

  access("/usr/sbin/open_init_pty", X_OK) = 0
  execve("/usr/bin/id", ["id", "-Z"], [/* 32 vars */]) = 0

... so /usr/sbin/open_init_pty is not run.
If I "chmod -x /usr/sbin/open_init_pty":

  access("/usr/sbin/open_init_pty", X_OK) = -1 EACCES (Permission denied)
  execve("/usr/sbin/open_init_pty", ["./run_init", "/usr/bin/id", "-Z"],
[/* 32 vars */]) = -1 EACCES (Permission denied)
  write(2, "execvp: Permission denied\n", 26) = 26
  exit_group(-1)                          = ?
  +++ exited with 255 +++

The code which performs the access() is at
https://github.com/SELinuxProject/selinux/blob/policycoreutils-2.4-rc7/policycoreutils/run_init/run_init.c#L409
. In this line, there is a bang before
"access("/usr/sbin/open_init_pty", X_OK)" so that open_init_pty is *not*
run when it exists and is executable.  I don't understand how this part
of the code work.  More precisely, if the "!" is removed, the codes
makes sense, but this seems weird as the original commit is quite short:
https://github.com/SELinuxProject/selinux/commit/d46e88abb6e1f7b0228c30c98ba4fb739e63cda3
.  Does "run_init id -Z" works as expected on your system?

A relevant test may consist in that "readlink /proc/self/fd/1" and
"run_init readlink /proc/self/fd/1" give different results.

Cheers,

Nicolas
