Subject: Re: inode_doinit_with_dentry messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: James Morris <jmorris@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <200504130353.42587.russell@coker.com.au>
References: 
	 <Xine.LNX.4.44.0504121252030.17231-100000@thoron.boston.redhat.com>
	 <200504130353.42587.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 13:55:22 -0400
Message-Id: <1113328522.25217.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-13 at 03:53 +1000, Russell Coker wrote:
> Everyone who wants to use strict policy, which is probably everyone for whom 
> SE Linux is a major factor in choosing a distribution.

Sorry, doesn't strict policy define a superset of the file types in the
targeted policy?  Thus, there shouldn't be inode_doinit errors upon
targeted -> strict conversion, only the reverse (which should be rare).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
