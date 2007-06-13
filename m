Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5DDDXjR029427
	for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2007 09:13:33 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5DDDSbZ020051
	for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2007 13:13:28 GMT
Subject: Re: kernel_mls changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301517.l4UFHLjj010415@localhost.localdomain>
References: <200705301517.l4UFHLjj010415@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 09:11:39 -0400
Message-Id: <1181740299.9511.0.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:17 -0400, dwalsh@redhat.com wrote:
> Policy used in lspp configurations
> 

> --- nsaserefpolicy/policy/modules/kernel/mls.te	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/mls.te	2007-05-30 09:25:53.000000000 -0400
> @@ -18,6 +18,7 @@
>  attribute mlsnetreadtoclr;
>  attribute mlsnetwrite;
>  attribute mlsnetwritetoclr;
> +attribute mlsnetwriteranged;
>  attribute mlsnetupgrade;
>  attribute mlsnetdowngrade;
>  attribute mlsnetrecvall;
> @@ -43,6 +44,8 @@
>  attribute mlsxwinwritecolormap;
>  attribute mlsxwinwritexinput;
>  
> +# Object attributes that allow MLS overrides for access by all subjects
> +attribute mlsrangedobject;
>  attribute mlstrustedobject;
>  
>  attribute privrangetrans;

What about the constraints change related to these attributes?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
