Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAC4oXe1027007
	for <selinux@tycho.nsa.gov>; Sun, 11 Nov 2012 23:50:33 -0500
Message-ID: <20121111235001.a3gqhaijmec0gk0g-cebfxv@webmail.spamcop.net>
Date: Sun, 11 Nov 2012 23:50:01 -0500
From: Pavel Roskin <proski@gnu.org>
To: Pavel Roskin <proski@gnu.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: Bisected regression: iterate_fd() selinux change affects flash
	plugin
References: <20121025101416.v1wilj95q8wkk0os-cebfxv@webmail.spamcop.net>
In-Reply-To: <20121025101416.v1wilj95q8wkk0os-cebfxv@webmail.spamcop.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Pavel Roskin <proski@gnu.org>:

> Hello, Al!
>
> I have noticed that Mozilla Firefox gets stuck for seconds or minutes
> on some sites, in particular on Facebook with Linux 3.7-rc1 and newer
> mainline kernels.  Disabling flash plugin fixes the delays.
>
> This is a Fedora 17 system with SELinux enabled, on x86_64
> architecture, with all updates, with LXDE desktop.  It's not the Fedora
> 16 system I mentioned before, it has never had LXDE login problems due
> to replace_fd().
>
> Bisecting lead me to the patch that introduced iterate_fd():
>
> commit c3c073f808b22dfae15ef8412b6f7b998644139a
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Tue Aug 21 22:32:06 2012 -0400
>
>     new helper: iterate_fd()
>
>     iterates through the opened files in given descriptor table,
>     calling a supplied function; we stop once non-zero is returned.
>     Callback gets struct file *, descriptor number and const void *
>     argument passed to iterator.  It is called with files->file_lock
>     held, so it is not allowed to block.
>
>     tty_io, netprio_cgroup and selinux flush_unauthorized_files()
>     converted to its use.
>
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> I have found that reverting the changes to security/selinux/hooks.c is
> sufficient to restore the correct behavior.
>
> -- 
> Regards,
> Pavel Roskin

I've made a bugzilla entry for the bug and put a preliminary patch there.
https://bugzilla.kernel.org/show_bug.cgi?id=50401

-- 
Regards,
Pavel Roskin


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
