Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA26540
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 09:23:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA19869
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 13:22:41 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA19865
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 13:22:41 GMT
Date: Mon, 23 Jul 2001 09:22:59 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Steve Eckmann <eckmann@computer.org>
cc: selinux@tycho.nsa.gov
Subject: Re: running programs
In-Reply-To: <4.3.2.7.2.20010721085700.00ad08a0@mail1.abac.com>
Message-ID: <Pine.SOL.3.95.1010723091125.3466E-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 21 Jul 2001, Steve Eckmann wrote:

> When I enable MAC with avc_toggle I can no longer run "ping"
> either as root or as a regular user. Can anyone explain how
> to fix this? There's no avc "denied" message, but there is
> a message about not being able to open a socket (don't have
> an se-linux system at hand and can't remember the exact msg).

You need to put ping into a domain that has permissions to
rawip_socket.  There should be avc denied messages - check
dmesg and /var/log/messages to be sure.

> Also, the tara (aka tiger) security scanner won't run with MAC
> enabled. I'm guessing that I just have to change the SID on the
> tiger executable, but I'm not sure what it should be so sysadm
> users can run it but regular users cannot. Suggestions?

What avc denied messages are you seeing when you try to run
the security scanner?  Why do you want to prevent ordinary
users from executing it - can't they just download their own
copy and run it if they want to do so?  If you really want to
prevent them from running it, you can either define a new
type for that purpose or you can use sbin_t, remove
sbin_t from can_exec_any in macros.te, and add sbin_t
explicitly to the domains that require execute access
to sbin programs.  If you just want it to run unprivileged
when executed by ordinary users, then you don't have to
do anything - when it is run by ordinary users, it will
run in the unprivileged user_t domain by default, whereas
when it is run by administrators, it will run in the
sysadm_t domain by default.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
