Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FNVIHa020797
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 19:31:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6FNVGH5009996
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 23:31:16 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6FNVERX009987 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 23:31:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: [patch] a few small new macros for global_macros.te
Date: Wed, 16 Jul 2003 09:31:01 +1000
References: <1058301863.14211.3.camel@columbia>
In-Reply-To: <1058301863.14211.3.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307160931.01645.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Jul 2003 06:44, Colin Walters wrote:
> I noticed a lot of .te files were repeatedly specifying access to etc_t
> and etc_runtime_t.  So I created
> a macro normal_config_file_access for that.  Also while the domain_trans
> macro is useful, it doesn't allow for #! scripts, since the file has to
> be read.  So there's a new macro domain_trans_read.

In my tree domain_trans() does what your domain_trans_read() does.

Does it make sense to have a rule involveing ld_so_cache_t apart from 
uses_shlib()?  When would you want to grant access to ld_so_cache_t but not 
use uses_shlib()?

What do you need extended_config_file_read_access() for?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
