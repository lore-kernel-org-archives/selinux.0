Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2SIkDrc026322
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 14:46:14 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2SIkCLB006711
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 18:46:13 GMT
Subject: Re: netutils reads dev_sysfs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4604342C.2020507@redhat.com>
References: <4604342C.2020507@redhat.com>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 14:46:49 -0400
Message-Id: <1175107610.29300.111.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 16:10 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/admin/netutils.te     2007-01-02 12:57:51.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/admin/netutils.te 2007-03-22 15:06:58.000000000 -0400
> @@ -41,6 +42,8 @@
>  manage_files_pattern(netutils_t,netutils_tmp_t,netutils_tmp_t)
>  files_tmp_filetrans(netutils_t, netutils_tmp_t, { file dir })
>  
> +dev_read_sysfs(netutils_t)
> +
>  kernel_search_proc(netutils_t)
>  
>  corenet_non_ipsec_sendrecv(netutils_t)

Another dupe, its in there already.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
