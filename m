Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98I6MrT024081
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 14:06:22 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98I6LZ2014480
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 18:06:21 GMT
Subject: Re: fuse + setfilecon - need some userspace / libselinux1
	assistance
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040928140351.GA12119@lkcl.net>
References: <20040928140351.GA12119@lkcl.net>
Content-Type: text/plain
Message-Id: <1097258612.16641.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 08 Oct 2004 14:03:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-09-28 at 10:03, Luke Kenneth Casson Leighton wrote:
> why?  well, because a setxattr("security.selinux", <somegarbage>)
> operation is performed!
> 
> as i found out, that is banned, esp. as the userspace program is run as
> getfsuid() to the user.

Sorry, do you mean that you ran into DAC denials due to lack of search
permission to the necessary directories?  setxattr itself doesn't impose
any uid-based restrictions on security.selinux; that is all controlled
based on security contexts.

> consequently, i looked around and found the util "setfilecon" which uses
> setfilecon().

setfilecon(path, context) just calls setxattr(path, security.selinux,
context, len, 0).  Nothing magic there.
> 
> to my surprise, i found that the argv[] arguments were simply ...
> typecast from a char* to a security_context_t.
> 
> surely... that's rather unexpected behaviour that could, in the
> future, break applications?

The fact that security contexts are strings is fairly established.  We
do need to introduce a level of indirection in translation for human
consumption for proper MLS support, unfortunately.

> will the setfilecon operation occur _as_ the user specified under the
> setfsuid() uid?
> 
> or will the setfilecon operation be actioned as root?
> 
> i believe it to be really important that the answer is
> "the setfilecon() is done as the setfsuid() uid"!

As far as the path lookup is concerned, the usual DAC restrictions are
applied, and are based on fsuid as usual.  But the setting of the
security context is not uid-based at all.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
