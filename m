Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8IJoIA8029589
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 15:50:18 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8IJoHFf011070
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 19:50:17 GMT
Subject: Re: [PATCH]dpkg.if lacking dpkg_var_lib_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820709180750v3163b06eyee88eeecb28f7504@mail.gmail.com>
References: <f71a82820709180750v3163b06eyee88eeecb28f7504@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 15:48:25 -0400
Message-Id: <1190144905.17544.15.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-18 at 23:50 +0900, Shintaro Fujiwara wrote:
> Hi, I was checking another interface and found dpkg_var_lib_t is lacking
> in dpkg.if.
> 
> Is it OK with this patch?

Its from the right location, but the tabs were replaced with 8 spaces,
so it doesn't apply.  I merged it manually.

> Index: policy/modules/admin/dpkg.if
> ===================================================================
> --- policy/modules/admin/dpkg.if        (revision 2422)
> +++ policy/modules/admin/dpkg.if        (working copy)
> @@ -223,7 +223,7 @@
>  #
>  interface(`dpkg_lock_db',`
>         gen_require(`
> -               type dpkg_lock_t;
> +               type dpkg_lock_t, dpkg_var_lib_t;
>         ')
> 
>         files_search_var_lib($1)
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
