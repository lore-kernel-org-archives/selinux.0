Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KFUMWt020443
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 11:30:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KFULmR011921
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 15:30:22 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9KFULjp011918 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 15:30:21 GMT
Subject: Re: checkpolicy patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian+selinux=tycho.nsa.gov@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031018090524.GA17313@wavehammer.waldi.eu.org>
References: <20031018090524.GA17313@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1066663819.22196.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 11:30:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-10-18 at 05:05, Bastian Blank wrote:
> hi folks
> 
> this patch fixes the following issues in checkpolicy (files: symtab.c,
> policydb.{c,h}:
> - size_t vs. int, unsigned int, __u32
> - use struct policy_file instead of opaque void pointer
> - mark some attributes as unused
> 
> it applies and builds cleanly with current sf cvs version

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
