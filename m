Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JHYXoX003595
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 13:34:33 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JHYW2o006742
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 17:34:32 GMT
Subject: Re: systat needs to read sysfs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F02323.5060503@redhat.com>
References: <45F02323.5060503@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 17:35:03 +0000
Message-Id: <1174325704.16707.3.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:52 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/sysstat.te   2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/services/sysstat.te        2007-03-08 08:42:37.000000000 -0500
> @@ -39,6 +39,7 @@
>  corecmd_exec_bin(sysstat_t)
>  
>  dev_read_urand(sysstat_t)
> +dev_read_sysfs(sysstat_t)
>  
>  files_search_var(sysstat_t)
>  # for mtab

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
