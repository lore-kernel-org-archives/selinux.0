Message-ID: <430B260F.1070007@ak.jp.nec.com>
Date: Tue, 23 Aug 2005 22:35:11 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] XATTR issues on JFFS2
References: <430AF95F.1050704@ak.jp.nec.com>	 <430B0FED.9070307@ak.jp.nec.com> <1124800206.7874.17.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124800206.7874.17.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Thanks for your comments.

The original reason not to use generic XATTR methods is that {get|set|list}_xattr
methods are called with XATTR-name which prefix is omitted.
e.g, sys_getxattr("security.selinux", ...)
      -> generic_getxattr("security.selinux", ...)
        -> jffs2_security_getxattr("selinux", ...)
                                    ~~~~~~~<- "security." was omitted.
In my implementation, the full-name is used to identify XATTR-entry.

But I noticed that we can use a combination of integer index number
(such as EXT2_XATTR_INDEX_SECURITY) and omitted XATTR-name for
the replacement of full-XATTR-name, and can use generic_xxxx().

I'll modify it in "take-2" patch.
(Why didn't I notice before posting...)

> Thanks for working on this functionality.  From a very brief look at the
> patch, one question I had was whether you could be using the generic
> xattr methods introduced by James Morris' earlier xattr code
> consolidation patches that are now in the mainline kernel.  See the
> generic_* functions in fs/xattr.c and how they are used by the fs code
> (e.g. look at the ext3 xattr implementation).  Per recent discussions on
> linux-fsdevel, using those helpers is the preferred approach for the
> future.  You can then just set sb->s_xattr for the specific handlers in
> jffs2, e.g. see the ext3 code for an example.

Thanks for this information. I'll contact to him before ACL implementation.

> Might be worth mentioning this work on acl-devel as well, although you
> don't yet support ACLs or other xattrs.  But I'm sure Andreas
> Gruenbacher would be interested, as he did the original xattr and ACL
> development work for ext[23], and he may be able to give feedback on
> your approach to various aspects like the attribute caching.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
