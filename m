Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i823sKrT026406
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 23:54:20 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i823rRY2011993
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 03:53:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: udev policy
Date: Thu, 2 Sep 2004 13:54:07 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200409011753.01483.russell@coker.com.au> <1094057500.13328.86.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1094057500.13328.86.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409021354.07034.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Sep 2004 02:51, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Wed, 2004-09-01 at 03:53, Russell Coker wrote:
> > The attached patch allows udev in rawhide to work properly with no audit
> > messages.
>
> --- /usr/src/se/policy/domains/program/unused/udev.te 2004-09-01
> 10:52:36.000000000 +1000 +++ domains/program/unused/udev.te 2004-09-01
> 17:51:52.000000000 +1000 @@ -43,7 +43,8 @@
>  allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom
> relabelto create_file_perms };
>
>  # to read the file_contexts file
> -r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
> +allow udev_t { selinux_config_t default_context_t file_context_t }:dir
> search; +allow udev_t { selinux_config_t file_context_t }:file { getattr
> read };
>
>  allow udev_t policy_config_t:dir { search };
>  allow udev_t proc_t:file { read };
>
> What's wrong with using r_dir_file here?

Sure, we could do that just as easily:

r_dir_file(udev_t, { selinux_config_t file_context_t })
allow udev_t default_context_t:dir search;

We don't seem to need access to default_context_t:file or lnk_file access to 
any of those types.  But I guess that adding the lnk_file access is not a bad 
idea to avoid unexpected breakage if the sys-admin does something unexpected.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
