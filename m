Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OBqVrT025453
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 07:52:31 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OBpkMZ028667
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:51:46 GMT
Subject: Re: Fedora and udev
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Joshua Brindle <jbrindle@tresys.com>, Greg KH <greg@kroah.com>,
   Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com
In-Reply-To: <20040824092853.GD25356@lkcl.net>
References: <200408222125.38169.russell@coker.com.au>
	 <4128B637.8040900@tresys.com> <20040822173457.GD13842@lkcl.net>
	 <20040823224444.GI4694@kroah.com> <412A74A6.9070206@tresys.com>
	 <20040824092853.GD25356@lkcl.net>
Content-Type: text/plain
Message-Id: <1093348251.1800.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 07:50:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-24 at 05:28, Luke Kenneth Casson Leighton wrote:
>  if the file_contexts stuff was somehow pre-munged and
>  transferred into kernel, and the regexp matching code (or
>  something similar) was _also_ transferred into the kernel,
>  then this problem would go away.

Bad idea.  The kernel only deals with file contexts via attributes on
inodes that are set by some userspace entity; it does not deal with the
file contexts configuration, nor should it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
