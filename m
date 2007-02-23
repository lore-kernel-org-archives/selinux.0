Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NJIx4a026854
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 14:18:59 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NJKI0Z000101
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 19:20:18 GMT
Subject: Re: clamd wants to read kernerl sysctls.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB2EC4.7080507@redhat.com>
References: <45DB2EC4.7080507@redhat.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 19:20:34 +0000
Message-Id: <1172258434.15371.87.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 12:24 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/clamav.te    2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.4/policy/modules/services/clamav.te 2007-02-19 16:01:52.000000000 -0500
> @@ -86,6 +86,8 @@
>  kernel_dontaudit_list_proc(clamd_t)
>  kernel_read_sysctl(clamd_t)
>  
> +kernel_read_sysctl(clamd_t)
> +
>  corenet_non_ipsec_sendrecv(clamd_t)
>  corenet_tcp_sendrecv_all_if(clamd_t)
>  corenet_tcp_sendrecv_all_nodes(clamd_t) 

Its there already.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
