Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2VDMLRb020206
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 08:22:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2VDKQlU020065
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 13:20:26 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i2VDKPkh020061
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 13:20:25 GMT
Subject: Re: Problems to compile the src.rpm packages on Red Hat Linux 9.0
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "lcvleo@ig.com.br" <lcvleo@ig.com.br>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1080685248.6780.5.camel@linux.linuxista.eti.br>
References: <1080685248.6780.5.camel@linux.linuxista.eti.br>
Content-Type: text/plain
Message-Id: <1080739324.22514.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 31 Mar 2004 08:22:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-03-30 at 17:20, lcvleo@ig.com.br wrote:
>        Dear friends,
>        I have problems when trying compile the packages coreutils,
> openssh, pam, vixie-cron, shadow-utils. Only this packages. This message
> error is present:

The SRPMS on the NSA web site are for Fedora Core 1, not RH9.  In any
event, at this point, you are better off installing Fedora Core 2 test2
if you want to experiment with Fedora and SELinux.  It already includes
a SELinux-enabled kernel and applications.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
