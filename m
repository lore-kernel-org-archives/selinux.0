Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB6ICIIi022927
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 13:12:18 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB6IAgHW014093
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 18:10:42 GMT
Subject: Re: SELinux port for 2.4.28 (and incoming backport from 2.6)
	released.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: lorenzo@gnu.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1102346428.11450.2.camel@localhost>
References: <1102192723.19001.19.camel@localhost>
	 <1102342918.23475.70.camel@moss-spartans.epoch.ncsc.mil>
	 <1102346428.11450.2.camel@localhost>
Content-Type: text/plain
Message-Id: <1102356458.23475.231.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 06 Dec 2004 13:07:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-12-06 at 10:20, Lorenzo Hernandez Garcia-Hierro wrote:
> Yes, the conditional policy (v16) could be ported to it, as i have the
> diff of the first release (2.6) that came with it, anyway, other stuff
> could be hard to backport.
> 
> It would be great to have somewhere a SCM to see real diffs and the
> evolution of the 2.6 brand, and the old 2.4 one, to compare what things
> need to be backported and how to do it.

Hmm...well, there is Linus' BitKeeper tree, and there is the CVS tree
under the sourceforge selinux project.

I'd expect that you could easily back port the latest security server
code (security/selinux/ss/*), as it is not tightly coupled to the core
kernel.  That would let you use the latest policy version even if the
hook function code isn't making full use of it (although the
fine-grained netlink classes might cause you some pain until you get
that support back ported into the hook functions, which shouldn't be
difficult).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
