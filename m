Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7EGE4Ha029432
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 12:14:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7EGE3j6006967
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 16:14:03 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h7EGE3NN006964 for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 16:14:03 GMT
Subject: Re: Updated Release
From: Chris PeBenito <pebenito@gentoo.org>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1060861583.11825.2537.camel@moss-sooners.epoch.ncsc.mil>
References: <1060861583.11825.2537.camel@moss-sooners.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1060877641.1909.11.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Thu, 14 Aug 2003 11:14:01 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is this backported 2.6 api non arch-specific, like it is in 2.6?  Or is
it still limited to x86?

On Thu, 2003-08-14 at 06:46, Howard Holm wrote:
> The SELinux web site <http://www.nsa.gov/selinux/> including the
> maillist archive has been updated.  The SELinux module has been merged
> into the mainline kernel as of 2.6.0-test3.  This release includes new
> kernel patches based on the 2.6.0-test3 kernel and a backport of the 2.6
> SELinux module to the 2.4.21 kernel.  The new API is consistent between
> 2.4 and 2.6.  The old 2.4 API and user-space utilities are no longer
> actively maintained.  There have been a number of bug fixes and cleanups
> to the library and utilities as well as new contributions to the example
> policy.
-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
