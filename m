Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m84G97mr011790
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 12:09:07 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m84G977d021170
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 16:09:07 GMT
Subject: Re: [PATCH][gnome.if]: bad gen_require type
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40809040809v43b12641n4a3556f1a53c384e@mail.gmail.com>
References: <cadfc0e40809040809v43b12641n4a3556f1a53c384e@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 04 Sep 2008 12:07:53 -0400
Message-Id: <1220544473.28287.43.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-09-04 at 10:09 -0500, Xavier Toth wrote:
> When I attempted to use this interface I got the follow error:
> /usr/bin/checkmodule:  loading policy configuration from tmp/ml-launch.tmp
> ml-launch.te":72:ERROR 'unknown type user_gconf_tmp_t' at token ';' on
> line 5970:
> 	allow ml_launch_t user_gconf_tmp_t:dir { getattr search };

I couldn't find a revision in refpolicy that has this bug.  Also, this
would have been better posted to the refpolicy mail list.

> --- serefpolicy-3.5.4/policy/modules/apps/gnome.if	2008-08-28
> 17:36:53.000000000 -0500
> +++ serefpolicy-3.5.4.new/policy/modules/apps/gnome.if	2008-08-28
> 17:35:59.000000000 -0500
> @@ -125,7 +125,7 @@
>  #
>  template(`gnome_stream_connect_gconf_template',`
>  	gen_require(`
> -		type $1_gconfd_t, gconf_tmp_t;
> +		type $1_gconfd_t, $1_gconf_tmp_t;
>  	')
> 
>  	read_files_pattern($2, $1_gconf_tmp_t, $1_gconf_tmp_t)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
