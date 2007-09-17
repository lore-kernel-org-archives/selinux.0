Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8HHxvA2023881
	for <selinux@tycho.nsa.gov>; Mon, 17 Sep 2007 13:59:57 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8HHxurK026587
	for <selinux@tycho.nsa.gov>; Mon, 17 Sep 2007 17:59:56 GMT
Subject: Re: [PATCH]some interfaces in userdomain.if lacking
	user_home_dir_t .
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820709152026u5ecc4326gd93925b6f996921@mail.gmail.com>
References: <f71a82820709152026u5ecc4326gd93925b6f996921@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 17 Sep 2007 17:57:44 +0000
Message-Id: <1190051864.17544.11.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-09-16 at 12:26 +0900, Shintaro Fujiwara wrote:
> Hi, I've checked
> 
> http://oss.tresys.com/repos/refpolicy/trunk/policy/modules/system/userdomain.if
> 
> and found that
> some interfaces in userdomain.if lacking user_home_dir_t .

Merged.  In the future, please submit patches relative to the root of
the policy source tree.

> --- userdomain.if       2007-09-16 11:22:26.000000000 +0900
> +++ userdomain_new.if   2007-09-16 11:31:14.000000000 +0900
> @@ -5076,7 +5076,7 @@
>  #
>  interface(`userdom_manage_generic_user_home_content_dirs',`
>        gen_require(`
> -               type user_home_t;
> +               type user_home_dir_t, user_home_t;
>        ')
> 
>        files_search_home($1)
> @@ -5194,7 +5194,7 @@
>  #
>  interface(`userdom_manage_generic_user_home_content_symlinks',`
>        gen_require(`
> -               type user_home_t;
> +               type user_home_dir_t, user_home_t;
>        ')
> 
>        files_search_home($1)
> @@ -5214,7 +5214,7 @@
>  #
>  interface(`userdom_manage_generic_user_home_content_pipes',`
>        gen_require(`
> -               type user_home_t;
> +               type user_home_dir_t, user_home_t;
>        ')
> 
>        files_search_home($1)
> @@ -5234,7 +5234,7 @@
>  #
>  interface(`userdom_manage_generic_user_home_content_sockets',`
>        gen_require(`
> -               type user_home_t;
> +               type user_home_dir_t, user_home_t;
>        ')
> 
>        files_search_home($1)
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
