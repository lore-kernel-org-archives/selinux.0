Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9FIC42O001523
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 14:12:04 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l9FIC4c6012860
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 18:12:04 GMT
Subject: Re: [PATCH] refpolicy:useradd_t needs process transition to nscd_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: shintaro_fujiwara <shin216@xf7.so-net.ne.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1192338511.3126.11.camel@notepc.intrajp-yokosuka.co.jp>
References: <1192338511.3126.11.camel@notepc.intrajp-yokosuka.co.jp>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 14:09:09 -0400
Message-Id: <1192471749.13098.132.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-10-14 at 14:08 +0900, shintaro_fujiwara wrote:
> Index: policy/modules/admin/usermanage.te
> ===================================================================
> --- policy/modules/admin/usermanage.te  (revision 2454)
> +++ policy/modules/admin/usermanage.te  (working copy)
> @@ -502,6 +502,8 @@
>  
>  miscfiles_read_localization(useradd_t)
>  
> +nscd_domtrans(useradd_t)
> +
>  seutil_read_config(useradd_t)
>  seutil_read_file_contexts(useradd_t)
>  seutil_read_default_contexts(useradd_t)

Theres already an optional nscd_domtrans(useradd_t).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
