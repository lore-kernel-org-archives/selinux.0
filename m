Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4TMaPrT015854
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 18:36:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4TMaOo9001877
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 22:36:24 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
        by jazzband.ncsc.mil  with SMTP id i4TMaNIn001874 for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 22:36:23 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 29 May 2004 22:36:22 -0000
Date: Sat, 29 May 2004 22:33:50 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: debian-devel@lists.debian.org, SE-Linux <selinux@tycho.nsa.gov>
Subject: Debian / SE-Linux - status report 29may2004
Message-ID: <20040529223350.GL2851@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Status report of bugs and stuff to do with Debian / SELinux
upstream integration.


NSA/SELinux kernel 2.6:

	http://www.nsa.gov/selinux/code/download5.cfm
	http://sf.net/projects/selinux/ (see cvs).

	status: most of the selinux enhancements are available
	        upstream in 2.6, however the very latest patches
			are only available from the above sites.

debian kernel 2.6 images:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=249510
	http://open.hands.com/~lkcl/selinux

	status: raised only 12 days ago.  requested that se/linux
		    security config options be enabled in stock
		    Debian kernels but require selinux=1 and enforcing=1
			to switch it on.

coreutils:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193328

	status: 1 year old, requested information, information now
	        provided, upstream and maintainer prodded for
			acknowledgement.

logrotate:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=224880

	status: russell alerted maintainer that upstream inclusion
	        is done (157 days ago) but debian package 3.7-1
			disables it by default due to libselinux1 not being
			"base/required" or "important".  change made to
			libselinux1 to reflect that.

cron:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644

	i think this one's my favourite.

	status: 1 year old. bit of a wing-ding and misunderstanding
	        over a field name, fortunately the maintainer stood
			his ground until the non-cron-code-experts understood
			the issues.  updated patch sent.

pam:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=249499

	status: amazingly, only 19 days old.  unless there's an
	        earlier one and it's already been integrated
			upstream.  changes are only to pam_unix, apparently.
	        information sought from upstream and from the
			maintainer.

dpkg:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=249496

	status: mr russell coker's postinst.d patch is apparently
	        well-known and the bugreport has been merged with
			other bugs, one of which (#17243) dates back to
			1998! kuudosss.

init:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=242900

	status: raised 50 days ago.  seeking information from
	        debian maintainer.

openssh:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193664

	status: raised 1 year ago, it was discussed, and the maintainer
	        specifically asked for russell to push for its
			inclusion upstream.  message sent to openssh-dev
			upstream, alerting them to the patch.

star, procps, util-linux, shadow, vixie-cron:

	status: although patches are available from
	http://www.nsa.gov/selinux/code/download5.cfm, 
	no bug-report or integration into debian/selinux have
	been initiated for these packages.

	colin walters does have debian packages available
	(mirrored at http://selinux.lemuria.org/walters)

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
