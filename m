Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QJgpjh023249
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 15:42:51 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2QJgmRM022437
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 19:42:49 GMT
Subject: Re: netutils needs to read sysfs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F029DE.2060103@redhat.com>
References: <45F029DE.2060103@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 15:43:25 -0400
Message-Id: <1174938205.28830.73.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 10:21 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/admin/netutils.te     2007-01-02 12:57:51.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/admin/netutils.te  2007-03-08 08:42:36.000000000 -0500
> @@ -41,6 +42,8 @@
>  manage_files_pattern(netutils_t,netutils_tmp_t,netutils_tmp_t)
>  files_tmp_filetrans(netutils_t, netutils_tmp_t, { file dir })
>  
> +dev_read_sysfs(netutils_t)
> +
>  kernel_search_proc(netutils_t)
>  
>  corenet_non_ipsec_sendrecv(netutils_t)

Merged; moved it down in the file.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
