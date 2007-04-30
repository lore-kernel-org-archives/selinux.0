Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UESTGc030014
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 10:28:29 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UESSid025672
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 14:28:28 GMT
Subject: Re: bluetooth reads inotifyfs_t:dir
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200704201853.l3KIrEGf027126@redsox.boston.devel.redhat.com>
References: <200704201853.l3KIrEGf027126@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 10:28:08 -0400
Message-Id: <1177943288.3570.82.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 14:53 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/bluetooth.te	2007-03-20 23:38:04.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/services/bluetooth.te	2007-04-11 17:07:34.000000000 -0400
> @@ -98,7 +98,7 @@
>  
>  fs_getattr_all_fs(bluetooth_t)
>  fs_search_auto_mountpoints(bluetooth_t)
> -fs_search_inotifyfs(bluetooth_t)
> +fs_list_inotifyfs(bluetooth_t)
>  
>  #Handle bluetooth serial devices
>  term_use_unallocated_ttys(bluetooth_t)

Merged

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
