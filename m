Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6G4U5Ha021394
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 00:30:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6G4T4nJ007198
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 04:29:04 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h6G4T3hr007195
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 04:29:03 GMT
Subject: Re: [patch] a few small new macros for global_macros.te
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200307160931.01645.russell@coker.com.au>
References: <1058301863.14211.3.camel@columbia>
	 <200307160931.01645.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058329641.1389.240.camel@columbia>
Mime-Version: 1.0
Date: 16 Jul 2003 00:27:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-15 at 19:31, Russell Coker wrote:
> On Wed, 16 Jul 2003 06:44, Colin Walters wrote:
> > I noticed a lot of .te files were repeatedly specifying access to etc_t
> > and etc_runtime_t.  So I created
> > a macro normal_config_file_access for that.  Also while the domain_trans
> > macro is useful, it doesn't allow for #! scripts, since the file has to
> > be read.  So there's a new macro domain_trans_read.
> 
> In my tree domain_trans() does what your domain_trans_read() does.

Ok.  That seems more sensible actually.  I just merged it back in as
well.

> Does it make sense to have a rule involveing ld_so_cache_t apart from 
> uses_shlib()?  When would you want to grant access to ld_so_cache_t but not 
> use uses_shlib()?

You're right, it's probably not useful.  I've deleted it.

> What do you need extended_config_file_read_access() for?

That just came because I broke it out of general_file_read_access, which
I see you've deleted in your tree.  I just did that as well, and since
extended_config_file_read_access isn't used either, I've deleted it too.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
