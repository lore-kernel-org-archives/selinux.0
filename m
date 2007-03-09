Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l29DA6EJ018040
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 08:10:06 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l29DA6ms026217
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 13:10:06 GMT
Subject: Re: modutils needs to talk to terminal
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200703081438.l28EcJTr008890@localhost.localdomain>
References: <200703081438.l28EcJTr008890@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 13:10:30 +0000
Message-Id: <1173445831.23674.10.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:38 -0500, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/system/modutils.te	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/system/modutils.te	2007-03-08 09:34:35.000000000 -0500
> @@ -118,7 +118,8 @@
>  }
>  
>  ifdef(`targeted_policy',`
> +	term_use_unallocated_ttys(insmod_t)
>  	unconfined_domain(insmod_t)
>  ')

With the recent fixes to the terminal module, making ttys and ptys
device nodes, this shouldn't be needed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
