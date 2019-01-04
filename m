Return-Path: <SRS0=zFQt=PM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1725DC43387
	for <selinux@archiver.kernel.org>; Fri,  4 Jan 2019 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA02021871
	for <selinux@archiver.kernel.org>; Fri,  4 Jan 2019 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="B39pZPEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfADQHs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:07:48 -0500
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:57544 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfADQHs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Jan 2019 11:07:48 -0500
X-EEMSG-check-017: 664702584|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="664702584"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Jan 2019 16:07:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1546618063; x=1578154063;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=zMeSCxWKBXwAyvILH9rHM6kfZh2wG7R2lGI7WdrwuiM=;
  b=B39pZPEPXiX3MGRre+BentT9OPb2VKdnn+RTczCeN/DOzBFa2kl44IQO
   D9anMQeOQKAgux67SItTu8dNEom1fA3kvVKm2hrn/ILy6+NUqwBukmF7M
   Cj9N2+dblJcn/rC4Sqz2OyqfuqlYQwUnLpcJUpeqJPK8AJuS4fp3S/0iS
   dR+UH+Ac72Qux4APKoFnciB0JOWXk5jK5gxG01F8w9q6k7wo8b7HNqHFm
   ciAV7+DmQofr2ekI9r3Q9+HtLy4dqmAoRkwMnmzbdsnYv8QUBzPELthif
   tbZBIW+64OcN6YloOVZ4U0csKwEoZlbrEEdWEFtPVycPD6AxzEpwUcRDF
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,439,1539648000"; 
   d="scan'208";a="19220563"
IronPort-PHdr: =?us-ascii?q?9a23=3AoarbmhJb4PU95CkrvdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfKvXxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5YTA+YEO+tTsovzqEYUrRamBgeiGePhxCFGiHD00601z+?=
 =?us-ascii?q?ouHg7J0gE7A9IDs27ZoMnpOKoIU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb9CjEJtVrS6aNo12T9stQ2FppCY6yqAGto?=
 =?us-ascii?q?WhcCcWz5QnwhjSYOGEfYiQ+h/vSemcLDhiiH9lZb6znQi+/Ee+xuHmS8W51k?=
 =?us-ascii?q?tBoDBfndnWrH8N0gTe6s2ASvRg4EiswS2P1wXP6uFcJkA0iLbbJ4YhwrEukp?=
 =?us-ascii?q?oTtlzOHjPsl0Xsja+Wa14k9vK06+XnfrrmppicO5Vyig7iKaQhhtazAeE5Mg?=
 =?us-ascii?q?gKR2Sb+OK826P//UDhXblHgfI7nrPZvZzHP8gXuKG0DxFP3oo+8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDyO17TO/D1Fuu/glSwnzdrwPDKJLvhAo7XIXTZn7fheq?=
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLfLoREDxsN3YDhkkMw272OvnFtp92Z0EWW6VAa?=
 =?us-ascii?q?+WLrnSsVmW6eIrOeWMY5UVuDnlIfg/+/HulWM5mUMafaSxxpQXaX+4HvNgI0?=
 =?us-ascii?q?iCfHXjnMwOEWYQsQo4VuDqj0eCUTEAL0q1CoY1+ys2Dp7uJ4bMQYazgbiF0W?=
 =?us-ascii?q?/vFJxZYWZuBl2GEH7uMYKeVKFIIDmfJs5njywsS7esUcki2AuouQu8zKBofc?=
 =?us-ascii?q?TO/ShNjo7uzNh44aXokBg28TFlR5CG33qlU3B/nmROQSQ/mq94vxoumR+4za?=
 =?us-ascii?q?FkjqkARpRo7PRTX1J/bMeEwg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AWAADBgy9c/wHyM5BjGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYFaKWZPMyeDf5QBTAEBAQEBAQaBNXyILI4/gXswCAGDekYCggAiNQgNA?=
 =?us-ascii?q?QMBAQEBAQECAWwcDII6KQGCZgEBAQEDIwQLAVYLDgcDAgImAgJXBgESgmNAg?=
 =?us-ascii?q?XQND6ZcfDOELQGBFIRiBYELizQXeIEHgRGCXQcugVSBSgKEaYJXApBmkHEJh?=
 =?us-ascii?q?xOKWRiRaolghQONGgMzgVYrCAIYCCEPO4JshgiKcSEDMIEFAQGJYgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Jan 2019 16:07:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x04G7WPu019805;
        Fri, 4 Jan 2019 11:07:37 -0500
Message-ID: <dca2a6edf3d24aa897afc37dbd1b7b0421343a72.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: Always set errno to 0 before calling
 getpwent()
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Laurent Bigonville <bigon@debian.org>, selinux@vger.kernel.org
Date:   Fri, 04 Jan 2019 11:09:45 -0500
In-Reply-To: <3a568434-6d6a-172c-6337-d43ddfb910e1@debian.org>
References: <20190102134639.30515-1-bigon@debian.org>
         <e2da0c12-9e7d-089f-d45a-fba523e6e04f@debian.org>
         <91136ae0462be76415705cb8a014d2a49e59aa85.camel@tycho.nsa.gov>
         <3a568434-6d6a-172c-6337-d43ddfb910e1@debian.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2019-01-04 at 16:57 +0100, Laurent Bigonville wrote:
> Le 4/01/19 à 16:11, Stephen Smalley a écrit :
> > On Wed, 2019-01-02 at 15:30 +0100, Laurent Bigonville wrote:
> > > Le 2/01/19 à 14:46, Laurent Bigonville a écrit :
> > > > From: Laurent Bigonville <bigon@bigon.be>
> > > > 
> > > > The manpage explicitly states that:
> > > > 
> > > >     The  getpwent()  function  returns a pointer to a passwd
> > > > structure, or
> > > >     NULL if there are no more entries or an error occurred.  If
> > > > an
> > > > error
> > > >     occurs, errno is set appropriately.  If one wants to check
> > > > errno
> > > > after
> > > >     the call, it should be set to zero before the call.
> > > > 
> > > > Without this, genhomedircon can wrongly return the following:
> > > >     libsemanage.get_home_dirs: Error while fetching
> > > > users.  Returning list so far.
> > > > 
> > > > https://github.com/SELinuxProject/selinux/issues/121
> > > > 
> > > > Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> > > > ---
> > > >    libsemanage/src/genhomedircon.c | 13 ++++++++++---
> > > >    1 file changed, 10 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/libsemanage/src/genhomedircon.c
> > > > b/libsemanage/src/genhomedircon.c
> > > > index 3e61b510..591941fb 100644
> > > > --- a/libsemanage/src/genhomedircon.c
> > > > +++ b/libsemanage/src/genhomedircon.c
> > > > @@ -361,7 +361,11 @@ static semanage_list_t
> > > > *get_home_dirs(genhomedircon_settings_t * s)
> > > >    
> > > >    	errno = 0;
> > > >    	setpwent();
> > > > -	while ((pwbuf = getpwent()) != NULL) {
> > > > +	while (1) {
> > > > +		errno = 0;
> > > > +		pwbuf = getpwent();
> > > > +		if (pwbuf == NULL)
> > > > +			break;
> > > >    		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid >
> > > > maxuid)
> > > >    			continue;
> > > >    		if (!semanage_list_find(shells, pwbuf-
> > > > >pw_shell))
> > > > @@ -403,7 +407,6 @@ static semanage_list_t
> > > > *get_home_dirs(genhomedircon_settings_t * s)
> > > >    		}
> > > >    		free(path);
> > > >    		path = NULL;
> > > > -		errno = 0;
> > > Actually I'm wondering if this shouldn't stay there
> > Why?
> 
> According to strdup() manpage, it can also change errno, isn't there
> a 
> risk that errno is changed to an non-zero value and then causing the 
> warning below to be printed?

On strdup(pwbuf->pw_dir) failure, we'll break out of the loop with non-
zero errno and then correctly report that there was an error that
truncated the list.  That's correct behavior.  The errno = 0; were are
removing is within the loop and is obsoleted by your setting of it at
the beginning of the loop.  So I think your patch is fine as is,
although I have not tested it.

> 
> 
> > > >    	}
> > > >    
> > > >    	if (errno) {
> > > > @@ -1101,7 +1104,11 @@ static int
> > > > get_group_users(genhomedircon_settings_t * s,
> > > >    	}
> > > >    
> > > >    	setpwent();
> > > > -	while ((pw = getpwent()) != NULL) {
> > > > +	while (1) {
> > > > +		errno = 0;
> > > > +		pw = getpwent();
> > > > +		if (pw == NULL)
> > > > +			break;
> > > >    		// skip users who also have this group as their
> > > >    		// primary group
> > > >    		if (lfind(pw->pw_name, group->gr_mem,
> > > > &nmembers,

