Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h76I3iHa027674
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 14:03:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h76I2TFB004840
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 18:02:29 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h76I2SGD004837
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 18:02:28 GMT
Subject: Re: oops on policy load (PPC)
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1060145894.1903.2.camel@chris.pebenito.net>
References: <1060029193.2997.206.camel@chris.pebenito.net>
	 <1060086871.3770.34.camel@moss-spartans.epoch.ncsc.mil>
	 <1060145894.1903.2.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1060189759.1903.20.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 06 Aug 2003 12:09:20 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok, sorry I take it back.  I finally got it to load w/o oopsing in the
initrd.  Perhaps it was lack of sleep.  :\  While its not useful to do
the initial policy load after the machine is already started up, it
still shouldn't have oopsed, however.

On Tue, 2003-08-05 at 23:58, Chris PeBenito wrote:
> I get the oops the first time policy is loaded any way its loaded, from
> the initrd, or otherwise.
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
