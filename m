Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28247
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 10:03:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA29676
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:02:25 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA29672 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:02:24 GMT
Date: Tue, 9 Jul 2002 10:03:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: <selinux@tycho.nsa.gov>
Subject: RE: lsm3 notes
In-Reply-To: <005401c2274d$33387be0$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207090934310.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 9 Jul 2002, Ed Street wrote:

> No I normally ssh in as a user and su to root.  I also noted that the
> path is not being set correctly either.

If you ssh in as a user, run newrole -r sysadm_r, and then su, you should
be fine.

The errors when directly logging in as root are a consequence of removing
direct transitions from sshd_t to sysadm_t and changing the default login
context for root to user_r.  sshd_t no longer has search access to
sysadm_home_t, so you'll see that denial, and the root shell will start
in user_r:user_t, so accesses to any of the /root files by the shell will
also be denied (including reading the root dotfiles, but these audit
messages are suppressed via dontaudit rules).  If you then use newrole -r
sysadm_r, you can work normally as root.  Hence, it is possible to
directly login as root if necessary, but you'll run through some nonfatal
denials.

> Yes klogd and syslogd is running correctly.  Seems that Selinux is
> denying access to both on a restart.  I am in agreement they may not
> have the correct label (same issue as raid devices )

If you mean restarting them from an administrator shell, you need to use
run_init to do that.  Otherwise, they'll end up with the wrong contexts.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
