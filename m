Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j365F8Do014958
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 01:15:08 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j365A7Cb012404
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 05:10:07 GMT
Subject: Re: [ PATCH ] X clients cleanup Patch #3
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112741764.24363.5.camel@cobra.ivg2.net>
References: <1112308113.17917.9.camel@cobra.ivg2.net>
	 <1112416291.7982.7.camel@cobra.ivg2.net> <424E8A49.2090408@redhat.com>
	 <200504022227.40688.russell@coker.com.au>
	 <1112456589.12762.6.camel@cobra.ivg2.net>  <425154AB.8080206@redhat.com>
	 <1112741764.24363.5.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 00:18:44 -0400
Message-Id: <1112761124.12597.1.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-05 at 18:56 -0400, Ivan Gyurdiev wrote:
> > ifdef(`has_$1_tmpfs_t', `',
> > type ...
> > define(`has_$1_tmpfs_t', `')
> > ')
> 
> So, if this is the only objection to this patch,
> maybe it should be merged - I can submit a followup patch 
> to deal with the tmpfs issue - seems like the right thing to do
> is to protect all the type-declaring macros in global-macros.te 
> against double inclusion?
> 
> I don't see problems being caused by moving the X functionality..
> 
> Attached is a resync against Fedora: selinux-policy-strict-1.23.6-3,
> and a table update for the securitylevel tool that fixes a typo, 
> and describes the allow_write_xshm boolean.


Ok, there's one problem with it - the allow_write_xshm rules should say:
rw_shm_perms and rw_file_perms and not write... 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
