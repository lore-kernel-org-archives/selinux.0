Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1RI00Rb001272
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 13:00:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1RHwNlK023557
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 17:58:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1RHwMOX023554
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 17:58:22 GMT
Subject: Re: SELinux and NFS --- a bit of a fight!
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <1077903498.30334.12.camel@sisko.scot.redhat.com>
References: <1077903498.30334.12.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Message-Id: <1077904791.26543.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 27 Feb 2004 12:59:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-27 at 12:38, Stephen C. Tweedie wrote:
> I'm not convinced that this is the absolute best solution, but I can't
> see any cleaner methods off-hand.

The policy already has a rule in can_network() to allow domains to share
a socket created by mount:
allow $1 mount_t:udp_socket rw_socket_perms;

I'm not clear as to when the sockets you are referencing are being
created; if they are created while in the context of the mount program
(which should be running in the mount_t domain, unless we need
additional domain transitions somewhere), then they should inherit that
domain.

Of course, if possible, it would be preferable to have the
kernel-created sockets use the kernel SID; this is already the case for
things like the ICMP and TCP reset sockets.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
