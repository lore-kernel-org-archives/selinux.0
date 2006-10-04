Subject: Re: xdm leaks file descriptors on purpose, but this is causing
	random avc messages.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45241C2B.6070504@redhat.com>
References: <45241C2B.6070504@redhat.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 17:07:56 -0400
Message-Id: <1159996076.14831.110.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 16:40 -0400, Daniel J Walsh wrote:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=206709
> 
> Basically by design xdm/gdm opens a file descriptor to xsession-errors 
> and then passes this to the session as stdout/stderr.  If at some time 
> later a user opens up a gnome terminal and restarts a confined domain.  
> AVC's are generated on this fd.
> 
> Not sure of a way to handle this other then "
> dontaudit domain xdm_t:fd use;

There's something here that doesn't compute for me.  When you open up a
gnome-terminal, the shell's fd 0, 1, and 2 should be set to the user's
own pty, replacing the fd 0, 1, and 2 that gnome-terminal itself
inherits from xdm.  So I don't see how a daemon would get it.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
