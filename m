Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8JTtIi007743
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 14:29:55 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8JTvu3000726
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 19:29:57 GMT
Subject: Re: patch: add can_create() macro, allow
	file_type_auto_trans(a,b,c, { file dir })
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041207000805.GH3678@jmh.mhn.de>
References: <20041207000805.GH3678@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 08 Dec 2004 14:32:29 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nice.  Merged.

On Mon, 2004-12-06 at 19:08, Thomas Bleher wrote:
> After the boring cleanup stuff, now for something a little bit more
> interesting :-)
> 
> The goal of the following patch is to allow one to write
> file_type_auto_trans(foo_t, var_run_t, foo_var_run_t, { dir file sock_file }) 
> 
> This makes it much easier to eg lock down /tmp (this will follow later
> as a separate patch)
> 
> How does it work? The m4 magic inside can_create() parses its last 
> parameter via a regex into separate tokens which it passes to 
> can_create_internal() one by one and recurses over the rest.
> 
> The interface to file_type_{,auto_}trans() is unchanged, except that the
> fourth parameter can now contain multiple object classes.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
