Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0VDem53007257
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2005 08:40:48 -0500 (EST)
Subject: Re: Updated version of open_init_pty
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <873bwil68n.fsf@glaurung.internal.golden-gryphon.com>
References: <873bwil68n.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1107178461.24654.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 31 Jan 2005 08:34:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-01-30 at 20:47, Manoj Srivastava wrote:
> Hi,
> 
>         This patch removes the unused functions tty_cbreak() and
>  tty_raw(). I have also nailed down the cause of the error that caused
>  truncated out put (I was able to reproduce the problem by running
>  "open_init_pty ls" in  a small directory -- the problem was faulty
>  handling of the SIG_CHLD signal, where I was not draining the last
>  bits stuck in the pipe.
> 
> 	Also fixed are partial writes (which could happen if the write
>  was interrupted), now we resume the write from where we left off
>  until all the bits are written. This could have resulted in lost
>  characters as well.
> 
> 	This is not perfect, since it does not work very well for
>  interactive scripts that do not take full control f the screen -- but
>  it works for init scripts, it works with dselect, aptitude, and the
>  lot, so this is good enough for this iteration.
> 
> 	I have also increased the time the program sits in select, as
>  opposed to running around the loop; but even setting the last
>  argument of select to NULL (and waiting forever) shows 
>   "open_init_pty top" taking up a large chunk of CPU. I have made
>  open_init_pty nice the parent process after executing the child
>  process, but before moving any data around, to help with this
>  situation.
> 
> 	Ideally, open_init_pty should track the child process setting
>  of the pseudo pty settings (like local echo settings, and so on) and
>  transferring that to the controlling tty, so that local echo is only
>  turned off when the child process wants it that way. More testing is
>  needed for that.
> 
> 	Anyway, a patch from the last version I sent in is
>  attached. Please let me know if I should send in the current version
>  of the file.

Thanks, merged into sourceforge CVS as of policycoreutils 1.21.10.
> 
> ______________________________________________________________________
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
