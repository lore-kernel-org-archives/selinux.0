Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2EDpix6017065
	for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2003 08:51:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2EDphPC018401
	for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2003 13:51:43 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h2EDpg5x018398 for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2003 13:51:43 GMT
Message-Id: <200303141359.IAA24430@moss-shockers.ncsc.mil>
Date: Fri, 14 Mar 2003 08:59:10 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Which module is "best"?
To: selinux@tycho.nsa.gov, russell@coker.com.au
Cc: dcarrera@math.umd.edu
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Russell Coker wrote:
> > > DTE has similar concepts and aims to SE Linux (I don't want to say more
> > > on this list).
> >
> > I'd love to hear anything more you can tell me.
> 
> I think that's already been addressed on the LSM list in a better way than I
> could.

DTE is actually quite different from SELinux, both abstractly and in
terms of the specific DTE implementation for LSM.  The published papers
about SELinux (see http://www.nsa.gov/selinux/docs.html) briefly
mention some high level differences between SELinux and DTE in their
related work sections.  I wrote up a detailed comparison of the
original SELinux architecture and implementation and the TIS/NAI Labs
DTE architecture and implementation a long time ago, which I can
provide upon request (caveat:  certain aspects of it are out-of-date
with respect to the current SELinux, and a number of aspects of the
TIS/NAI Labs DTE implementation are not implemented in the independent
DTE implementation for LSM).  A quick look at the DTE implementation
for LSM suggests that it is not complete, as many of the hook functions
have only stub implementations.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
