Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9FIC6Je001526
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 14:12:06 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l9FIC4c8012860
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 18:12:04 GMT
Subject: Re: [PATCH] refpolicy:groupadd_t needs transition to nscd_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: shintaro_fujiwara <shin216@xf7.so-net.ne.jp>
Cc: selinux@tycho.nsa.gov, pebenito@tresys.com
In-Reply-To: <1192354943.3074.1.camel@notepc.intrajp-yokosuka.co.jp>
References: <1192354943.3074.1.camel@notepc.intrajp-yokosuka.co.jp>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 14:09:30 -0400
Message-Id: <1192471770.13098.134.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-10-14 at 18:42 +0900, shintaro_fujiwara wrote:
> --- policy/modules/admin/usermanage.te  (revision 2454)
> +++ policy/modules/admin/usermanage.te  (working copy)
> @@ -227,6 +227,8 @@
>  
>  miscfiles_read_localization(groupadd_t)
>  
> +nscd_domtrans(groupadd_t)
> +
>  auth_manage_shadow(groupadd_t)
>  auth_relabel_shadow(groupadd_t)
>  auth_etc_filetrans_shadow(groupadd_t)

Theres already an optional nscd_domtrans(groupadd_t).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
