Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TCbGrT018042
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 08:37:16 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TCbFCb002933
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 12:37:15 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040728232043.GF18711@lkcl.net>
References: <20040728232043.GF18711@lkcl.net>
Content-Type: text/plain
Message-Id: <1091104600.21971.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 08:36:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-07-28 at 19:20, Luke Kenneth Casson Leighton wrote:
> fighting with it for a day, and after seeing some clues in the
> file contexts (/(u)dev/....) i decided to try editing
> /etc/udev/udev.conf to set it to use /udev instead of /dev.

I don't know which policy version you are using, but in the current
policy, the regexes are of the form "/u?dev", so it works with either a
/dev or /udev.  Requires using a xattr-supporting filesystem for udev,
naturally.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
