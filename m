Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JHVsSH003409
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 13:31:54 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JHVr2o006265
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 17:31:53 GMT
Subject: Re: using the xdm_t:fifo_file sometimes requires ioctl
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F0229E.6090100@redhat.com>
References: <45F0229E.6090100@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 13:32:24 -0400
Message-Id: <1174325544.16707.1.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:50 -0500, Daniel J Walsh wrote:
> Also needs to communicate with consolekit via dbus.

Merged.  Moved the TE change up in the file.

> --- nsaserefpolicy/policy/modules/services/xserver.if   2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/services/xserver.if        2007-03-08 08:42:37.000000000 -0500
> @@ -826,7 +826,7 @@
>                 type xdm_t;
>         ')
>  
> -       dontaudit $1 xdm_t:fifo_file { getattr read write }; 
> +       dontaudit $1 xdm_t:fifo_file rw_fifo_file_perms; 
>  ')
>  
>  ########################################
> --- nsaserefpolicy/policy/modules/services/xserver.te   2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/services/xserver.te        2007-03-08 08:42:37.000000000 -0500
> @@ -345,6 +345,10 @@
>  ')
>  
>  optional_policy(`
> +       consolekit_dbus_chat(xdm_t)
> +')
> +
> +optional_policy(`
>         userhelper_dontaudit_search_config(xdm_t)
>  ')
>  

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
