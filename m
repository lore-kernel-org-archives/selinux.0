Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9A6fOWt001138
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 02:41:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9A6fMUd024241
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 06:41:23 GMT
Date: Fri, 10 Oct 2003 06:32:00 +0000
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Thorsten Kukuk <kukuk@suse.de>, selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: autoconf/libtool for libselinux
Message-ID: <20031010063200.GB29213@bunuel.tii.matav.hu>
References: <20031006201735.GA28880@suse.de> <1065720375.8181.311.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1065720375.8181.311.camel@moss-spartans.epoch.ncsc.mil>
From: mag@bunuel.tii.matav.hu (Magosányi Árpád)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A levelezõm azt hiszi, hogy Stephen Smalley a következõeket írta:
> than <attr/xattr.h>.  autoconf/libtool seems a bit overkill for
> libselinux.  It seems reasonable to require people to use a modern glibc

I don't think so. Adhering to standards should not be overkill for any
project. It is doubly so for open source software; you can attract more
developers if the build process looks like the usual.

I wanted to reply to the mail with the patch to tell you
that I consider it as a seemingly marginal, but very important thing,
but I thought it would be like telling you that the grass is green.

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
