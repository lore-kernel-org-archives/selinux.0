Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UFOLDo015334
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 10:24:21 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UFKWph019182
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 15:20:32 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050330150525.90469.qmail@web31603.mail.mud.yahoo.com>
References: <20050330150525.90469.qmail@web31603.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 10:29:06 -0500
Message-Id: <1112196547.8475.0.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-30 at 07:05 -0800, Casey Schaufler wrote:
> --- Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > How about
> > 
> > New Directory Structure (added to /skel, or
> > whatever)
> > ~/content - ROLE_content_t
> > ...
> > ~/content/export_p2p - ROLE_p2p_share_t
> > 
> > Desktop apps will be restricted to only access the
> > appropriate one.
> > "Downloading" apps will be restricted to download to
> > untrusted_content_t. 
> 
> Am I the only one wary of a slippery slope here?

What's the problem?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
