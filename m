Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3IGWWcX019785
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 12:32:32 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m3IGWTSe029417
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 16:32:31 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [refpolicy] trivial HAL doc patch
Date: Fri, 18 Apr 2008 11:45:21 -0400
Message-ID: <1208533521.7113.2.camel@gorn>
In-Reply-To: <1208212411.31069.65.camel@rxm-581b.stl.gtri.gatech.edu>
References: <1208212411.31069.65.camel@rxm-581b.stl.gtri.gatech.edu>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "rob myers" <rob.myers@gtri.gatech.edu>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-04-14 at 18:33 -0400, rob myers wrote:
> Correct summary for hal_write_log interface.
> 
> Index: policy/modules/services/hal.if
> ===================================================================
> --- policy/modules/services/hal.if	(revision 2659)
> +++ policy/modules/services/hal.if	(working copy)
> @@ -195,7 +195,7 @@
>  ## </summary>
>  ## <param name="domain">
>  ##	<summary>
> -##	Domain to not audit
> +##	Domain to allow to write log files
>  ##	</summary>
>  ## </param>
>  #

I ended up putting "Domain allowed access." for consistency with other
interfaces.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
