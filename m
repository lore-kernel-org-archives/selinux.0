Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IBw6rT019577
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 07:58:07 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IBw6Rq016186
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 11:58:06 GMT
Subject: Re: mozilla 0.9.3-2 crashing with tunables read and write homedir
	OFF
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Erich Schubert <erich@debian.org>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1092780620.6531.3.camel@wintermute.xmldesign.de>
References: <20040817193823.GU18321@lkcl.net>
	 <1092780620.6531.3.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Message-Id: <1092830205.26566.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 18 Aug 2004 07:56:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-17 at 18:10, Erich Schubert wrote:
> Waste of time. I guess that any mozilla developer will tell you they do
> need write access to their profile directory.
<snip>
> And don't expect applications to behave differently than what they were designed for.
> Mozilla was designed to have a writeable profile directory for its cache, configuration data etc.
> I bet the developers will just drop your bug report and tell you to write your own browser using the gecko engine...

The mozilla policy gives mozilla the ability to create and write its own
files.  The tunables just control whether it can read and/or write other
files in the user's home directory.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
