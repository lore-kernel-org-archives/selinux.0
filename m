Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: ivg2@cornell.edu, SELinux@tycho.nsa.gov
In-Reply-To: <20050113164827.GI17414@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
	 <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112233241.GF11846@lkcl.net>
	 <1105632966.24406.34.camel@moss-spartans.epoch.ncsc.mil>
	 <20050113164827.GI17414@lkcl.net>
Content-Type: text/plain
Message-Id: <1105634238.24406.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 11:37:18 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-13 at 11:48, Luke Kenneth Casson Leighton wrote:
>   i believed that it would be acceptable to have as part of the
>   intermediate stage a full filesystem traversal, but as i mentioned
>   in the reply to james, i woke up with an insight into a flaw of
>   what i am advocating and cannot now remember what it is!

Having to analyze the complete filesystem state:
1) doesn't scale.  Think of a site with millions of files.
2) isn't stable.  Think of runtime changes occuring all the time as
files are created, destroyed, relabeled, etc.

In any event, I consider the topic (of multiple contexts per object)
closed.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
