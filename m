Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72E14rT012368
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:01:04 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72E12KV011327
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 14:01:03 GMT
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040801172751.GD20103@lkcl.net>
References: <20040801172751.GD20103@lkcl.net>
Content-Type: text/plain
Message-Id: <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 10:00:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-08-01 at 13:27, Luke Kenneth Casson Leighton wrote:
> hi,
> 
> does anyone know: the matchfilecon program reads
> /etc/selinux/.../file_contexts/file_contexts.
> 
> does the matchfilecon libselinux1 api does the same?
> 
> or does it read a binary policy from somewhere?
> 
> the reason i ask is because if i were to code up stuff into
> udev, it might solve the problem of having to move
> /usr/share/selinux/stuff off of /usr and onto /etc.

Do you mean matchpathcon?  No matchfilecon here.  matchpathcon(1) is
just a trivial test program that invokes the matchpathcon(3) library
function on its arguments and reports the result.  matchpathcon(3) reads
the installed file_contexts configuration
(/etc/selinux/$SELINUXTYPE/contexts/files/file_contexts), not the one
from the policy source tree, as policy sources are optional.  Binary
policy isn't relevant here, as it doesn't contain file contexts.  BTW,
policy does live in /etc/selinux in Fedora Core 3 (or
/etc/security/selinux in Fedora Core 2), and sounds like Russell has
likewise moved it there in Debian.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
