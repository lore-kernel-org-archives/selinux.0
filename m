Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAJTZIi022766
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 14:29:35 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAJRvwg018577
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 19:27:57 GMT
Subject: Re: [PATCH] packages specs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Miguel Bolanos <mike@hsol.net>
Cc: SE Linux list <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1102706031.3886.38.camel@selene.hsol.net>
References: <1102706031.3886.38.camel@selene.hsol.net>
Content-Type: text/plain
Message-Id: <1102706674.1628.187.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 14:24:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-10 at 14:14, Miguel Bolanos wrote:
> This patch just removes the hardcoded names on the source definitions
> for the packages specs.

Thanks.  Just FYI, there is also a CVS tree at the sourceforge selinux
project that tracks changes between official releases on nsa.gov, so
when submitting patches, you may want to generate them against it.  We
can always merge, of course, but it lets you work against the latest
sources.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
