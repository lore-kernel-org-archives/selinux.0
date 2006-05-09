Subject: Re: pam_namespace
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Russell Coker <russell@coker.com.au>, Valdis.Kletnieks@vt.edu,
        SE-Linux <selinux@tycho.nsa.gov>, viro@zeniv.linux.org.uk
In-Reply-To: <20060508223859.GA7479@thorium.jmh.mhn.de>
References: <200605051623.25533.russell@coker.com.au>
	 <200605051006.k45A6vNK024699@turing-police.cc.vt.edu>
	 <200605071928.22799.russell@coker.com.au>
	 <200605081137.42066.russell@coker.com.au>
	 <20060508223859.GA7479@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Tue, 09 May 2006 08:07:52 -0400
Message-Id: <1147176472.32651.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-09 at 00:39 +0200, Thomas Bleher wrote:
> [CC'ing Al Viro because he surely knows this...]
> 
> * Russell Coker <russell@coker.com.au> [2006-05-08 05:23]:
> > One problem we have with separate name spaces is that when the administrator 
> > mounts a file system the users won't see it.
> 
> I thought shared subtrees were invented to solve this problem?
> I've read the documentation but never actually played with it, so I'd be
> interested to hear if it doesn't work.

Yes, they should address that particular problem.  Patch for mount(8)
program to support setting up shared subtrees was just posted to
redhat-lspp list yesterday.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
