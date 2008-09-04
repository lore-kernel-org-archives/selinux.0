Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m84HRQZW027742
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 13:27:27 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m84HQnmp025715
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 17:26:49 GMT
Message-ID: <48C01A74.3070204@redhat.com>
Date: Thu, 04 Sep 2008 13:27:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][gnome.if]: bad gen_require type
References: <cadfc0e40809040809v43b12641n4a3556f1a53c384e@mail.gmail.com>
In-Reply-To: <cadfc0e40809040809v43b12641n4a3556f1a53c384e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> When I attempted to use this interface I got the follow error:
> /usr/bin/checkmodule:  loading policy configuration from tmp/ml-launch.tmp
> ml-launch.te":72:ERROR 'unknown type user_gconf_tmp_t' at token ';' on
> line 5970:
> 	allow ml_launch_t user_gconf_tmp_t:dir { getattr search };
> 
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
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

In Rawhide it should be, since we don't types based on role.

 #
 template(`gnome_stream_connect_gconf_template',`
 	gen_require(`
		type $1_gconfd_t, gconf_tmp_t;
 	')
>
 	read_files_pattern($2, gconf_tmp_t, gconf_tmp_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
