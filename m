Subject: Re: [PATCH] XATTR issues on JFFS2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <430B260F.1070007@ak.jp.nec.com>
References: <430AF95F.1050704@ak.jp.nec.com>
	 <430B0FED.9070307@ak.jp.nec.com>
	 <1124800206.7874.17.camel@moss-spartans.epoch.ncsc.mil>
	 <430B260F.1070007@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 09:44:49 -0400
Message-Id: <1124804689.7874.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-23 at 22:35 +0900, KaiGai Kohei wrote:
> The original reason not to use generic XATTR methods is that {get|set|list}_xattr
> methods are called with XATTR-name which prefix is omitted.
> e.g, sys_getxattr("security.selinux", ...)
>       -> generic_getxattr("security.selinux", ...)
>         -> jffs2_security_getxattr("selinux", ...)
>                                     ~~~~~~~<- "security." was omitted.
> In my implementation, the full-name is used to identify XATTR-entry.

reiserfs has the same issue, so they are proposing changing the generic
functions to pass the entire name down to the fs code.  See
http://marc.theaimsgroup.com/?l=linux-fsdevel&m=112448411323801&w=2

> But I noticed that we can use a combination of integer index number
> (such as EXT2_XATTR_INDEX_SECURITY) and omitted XATTR-name for
> the replacement of full-XATTR-name, and can use generic_xxxx().

Yes, that is an option as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
