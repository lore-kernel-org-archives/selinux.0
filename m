Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA27899
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 08:37:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA11620
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 12:35:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA11616 for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 12:35:30 GMT
Date: Mon, 26 Aug 2002 08:36:21 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Howard Holm <hdholm@epoch.ncsc.mil>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Updated Release
In-Reply-To: <200208241745.NAA22298@coalpipe.epoch.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0208260831230.10972-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The updated release (2002082308) has been imported and merged into the
sourceforge selinux CVS tree, under the 'nsa' module.  As usual, you can
access it via:

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com

On Sat, 24 Aug 2002, Howard Holm wrote:

> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated. The site includes a new release of the
> LSM-based SELinux prototype.  The base kernel versions were updated to
> 2.4.19 and 2.5.31.  The SELinux peer SID functionality was
> re-implemented with new sock hooks; the accept_secure call should now
> be reliable.  The sysctl hook and /proc/sys labeling were made
> configurable.  Other minor enhancements were made including checkpolicy
> and the example policy.  Bugs were fixed in auditing logic, PSID
> mapping code, and ipc permission hook.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
