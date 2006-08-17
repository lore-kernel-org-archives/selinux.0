Subject: Re: Controlling term: unknown (Operation not supported)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20060817201316.112230@gmx.net>
References: <20060817201316.112230@gmx.net>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 16:31:47 -0400
Message-Id: <1155846707.21070.201.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-17 at 22:13 +0200, selinux770@tortenboxer.de wrote:
> Hi once again, sorry for not putting a subject into my last email. Bad start on this list. So let's start over:
> 
> I'm trying to enable SELinux on my Nokia 770 Internet Tablet which is running a modified Debian Linux for ARM processors. Until now I have replaced and installed several files and packages, but now I need further guidance. It seems like SELinux is working in some kind of way. But one main problem/question that persists is that i get a
> Controlling term:               unknown (Operation not supported)
> when doing a sestatus -v.

Means that there is no tty/pty or it doesn't support getxattr for some
reason.  Normal output would be something like:
Controlling term:               root:object_r:secadm_devpts_t:SystemLow

What does 'tty' show?  What does 'ls -Z `tty`' show?

> The "Current context" for user root is system_u:system_r:sshd_t when i log in via ssh.
> (uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:kernel_t)

sshd_t or kernel_t (you have two different results above)?
sshd_t means that sshd never transitioned out of its context into the
user's context.  Does your sshd include the SELinux changes?

> Within the device (when opening a console or whatever) the "Current context" is system_u:system_r:kernel_t.
> (uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:kernel_t)
> Just as many other (nearly all) processes, too.

Initial task starts life in kernel_t, then transitions to init_t upon
executing /sbin/init (if labeled init_exec_t).  Then everything
transitions from there.  Possibly /sbin/init wasn't labeled when you
booted?

> So my questions:
> 1. What is the controlling term in sestatus for? What does it mean if it's unknown and how bad is this problem?
> 2. Are the wrong contexts of users a policy based problem or are they derived by the problem with the controlling term (or even orthers)? I need to know this since I changed much on the device for SELinux and now I'm not sure if I should continue searching missing functionalities within the system or searching for errors in the policy or file labelling.

I don't think they are related.

> Process contexts:
> Current context:                system_u:system_r:sshd_t
> Init context:                   system_u:system_r:init_t

This one is surprising; if init made it into init_t, nothing should be
in kernel_t other than kernel threads.  Unless you told it to re-exec
via telinit after setting its file label.  Which would only fix it and
not all of its descendants, so reboot required.

> /var/lib/install/sbin/sshd      system_u:object_r:sshd_exec_t

That's a strange location.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
