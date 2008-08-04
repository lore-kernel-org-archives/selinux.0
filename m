Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74DHO53020920
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 09:17:24 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m74DHO7E021636
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 13:17:24 GMT
Subject: Re: Some questions regarding RedHat refpolicy patches
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <20080803224448.GA22709@hardeman.nu>
References: <20080803224448.GA22709@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 04 Aug 2008 09:16:59 -0400
Message-Id: <1217855819.4114.79.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 00:44 +0200, David Härdeman wrote:
> Going through the RedHat patches trying to find more stuff to send 
> upstream for merge, I've come across a few things that I don't quite 
> understand and I'd appreciate if someone could explain them to me :)
> 
> a)
> 
> There are quite a lot of changes like this:
> 
> --- ./upstream/refpolicy/policy/modules/apps/uml.fc     2008-08-03 12:31:17.000000000 +0200
> +++ ./fedora/refpolicy/policy/modules/apps/uml.fc       2008-08-03 12:29:42.000000000 +0200
> @@ -1,7 +1,7 @@
>   #
>   # HOME_DIR/
>   #
> -HOME_DIR/\.uml(/.*)?           gen_context(system_u:object_r:ROLE_uml_rw_t,s0)
> +HOME_DIR/\.uml(/.*)?           gen_context(system_u:object_r:user_uml_rw_t,s0)
> 
> What is the purpose of these changes and is it something that makes 
> sense upstream? The upstream SVN version seems to contain quite a lot of 
> "ROLE" contexts already

No, it removes role separations on these uml files.  It is a
Fedora-specific change that isn't upstreamable.

> ...then again, other parts of the patch do the 
> reverse:
> 
> --- ./upstream/refpolicy/policy/modules/apps/mplayer.fc 2008-08-03 12:31:17.000000000 +0200
> +++ ./fedora/refpolicy/policy/modules/apps/mplayer.fc   2008-08-03 12:29:42.000000000 +0200
> @@ -10,4 +10,4 @@
>   /usr/bin/mencoder      --      gen_context(system_u:object_r:mencoder_exec_t,s0)
>   /usr/bin/xine          --      gen_context(system_u:object_r:mplayer_exec_t,s0)
>   
> -HOME_DIR/\.mplayer(/.*)?        gen_context(system_u:object_r:ROLE_mplayer_home_t,s0)
> +HOME_DIR/\.mplayer(/.*)?        gen_context(system_u:object_r:user_mplayer_home_t,s0)

This isn't the reverse of the previous example, its also removing the
separation.

> b)
> 
> There are also quite a lot of changes like this:
> 
> --- ./upstream/refpolicy/policy/modules/apps/awstats.if 2008-08-03 12:31:17.000000000 +0200
> +++ ./fedora/refpolicy/policy/modules/apps/awstats.if   2008-05-15 15:10:34.000000000 +0200
> @@ -33,7 +33,8 @@
>   #
>   interface(`awstats_cgi_exec',`
>          gen_require(`
> -               type httpd_awstats_script_exec_t, httpd_awstats_content_t;
> +               type httpd_awstats_script_exec_t;
> +               type httpd_awstats_content_t;
> 
> Are these only noise (and in that case, would you (Dan) like a patch to 
> remove that noise) or something which is actually wanted upstream?

The types being required should match the types being used in the body
of the interface.  If the change doesn't make them match up, then its
wrong.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
