Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8II71Hx020479
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 14:07:01 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8II709X002858
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 18:07:00 GMT
Subject: Re: [PATCH] fstools.te needs corecmd_exec_bin
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820709181039s6aeac4eaq404542de3148c411@mail.gmail.com>
References: <f71a82820709181039s6aeac4eaq404542de3148c411@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 14:05:20 -0400
Message-Id: <1190138720.17544.13.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-19 at 02:39 +0900, Shintaro Fujiwara wrote:
> I have attached usb hdd on my strict machine and typed
> mkfs -c /dev/sdb
> and error saying cannot execute /sbin/badblocks.
> I always use -c with mkfs command so I added
> this line to fstools.te.

I think instead badblocks should be labeled fsadm_exec_t.

> Index: policy/modules/system/fstools.te
> ===================================================================
> --- policy/modules/system/fstools.te    (revision 2422)
> +++ policy/modules/system/fstools.te    (working copy)
> @@ -119,6 +119,9 @@
>  corecmd_read_bin_pipes(fsadm_t)
>  corecmd_read_bin_sockets(fsadm_t)
> 
> +# for mkfs -c
> +corecmd_exec_bin(fsadm_t)
> +
>  domain_use_interactive_fds(fsadm_t)
> 
>  files_list_home(fsadm_t)
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
