Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74HAWMw003149
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 13:10:32 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74HAV7T025009
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 17:10:31 GMT
Message-ID: <489737DD.6080103@redhat.com>
Date: Mon, 04 Aug 2008 13:09:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
CC: selinux@tycho.nsa.gov
Subject: Re: Some questions regarding RedHat refpolicy patches
References: <20080803224448.GA22709@hardeman.nu>
In-Reply-To: <20080803224448.GA22709@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Härdeman wrote:
> Going through the RedHat patches trying to find more stuff to send
> upstream for merge, I've come across a few things that I don't quite
> understand and I'd appreciate if someone could explain them to me :)
> 
> a)
> 
> There are quite a lot of changes like this:
> 
> --- ./upstream/refpolicy/policy/modules/apps/uml.fc     2008-08-03
> 12:31:17.000000000 +0200
> +++ ./fedora/refpolicy/policy/modules/apps/uml.fc       2008-08-03
> 12:29:42.000000000 +0200
> @@ -1,7 +1,7 @@
>  #
>  # HOME_DIR/
>  #
> -HOME_DIR/\.uml(/.*)?          
> gen_context(system_u:object_r:ROLE_uml_rw_t,s0)
> +HOME_DIR/\.uml(/.*)?          
> gen_context(system_u:object_r:user_uml_rw_t,s0)
>
These are the elimination of role separation on types in the homedir.
Upstream is experimenting with this and hopefully at some point we can
merge these changes together.  I would figure in the final version user_
would be eliminated and it would just be uml_rw_t.

> What is the purpose of these changes and is it something that makes
> sense upstream? The upstream SVN version seems to contain quite a lot of
> "ROLE" contexts already...then again, other parts of the patch do the
> reverse:
> 
> --- ./upstream/refpolicy/policy/modules/apps/mplayer.fc 2008-08-03
> 12:31:17.000000000 +0200
> +++ ./fedora/refpolicy/policy/modules/apps/mplayer.fc   2008-08-03
> 12:29:42.000000000 +0200
> @@ -10,4 +10,4 @@
>  /usr/bin/mencoder      --     
> gen_context(system_u:object_r:mencoder_exec_t,s0)
>  /usr/bin/xine          --     
> gen_context(system_u:object_r:mplayer_exec_t,s0)
>  
> -HOME_DIR/\.mplayer(/.*)?       
> gen_context(system_u:object_r:ROLE_mplayer_home_t,s0)
> +HOME_DIR/\.mplayer(/.*)?       
> gen_context(system_u:object_r:user_mplayer_home_t,s0)
> 
> 
> b)
> 
> There are also quite a lot of changes like this:
> 
> --- ./upstream/refpolicy/policy/modules/apps/awstats.if 2008-08-03
> 12:31:17.000000000 +0200
> +++ ./fedora/refpolicy/policy/modules/apps/awstats.if   2008-05-15
> 15:10:34.000000000 +0200
> @@ -33,7 +33,8 @@
>  #
>  interface(`awstats_cgi_exec',`
>         gen_require(`
> -               type httpd_awstats_script_exec_t, httpd_awstats_content_t;
> +               type httpd_awstats_script_exec_t;
> +               type httpd_awstats_content_t;
> 
> Are these only noise (and in that case, would you (Dan) like a patch to
> remove that noise) or something which is actually wanted upstream?
> 
> 
These are reforting by Chris that I missed.  Chris wants these on the
same line, which I am fine with.
> c)
> 
> A lot of changes only alter whitespace, would it be possible to avoid
> these by generating the fedora diff with the appropriate options to diff?
> 
> 
> d)
> 
> Why does postgrey_t need to be able to restart apache? (and the same
> goes for many many other service module changes in the patch, such as
> canna, ldap, etc, etc)
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiXN90ACgkQrlYvE4MpobMcAwCgrIUpI2GqFeuvl4Oeko9Tt1b2
jsQAoNjI2+X5cj0mrHHXapjp2O0XYnFI
=lcbF
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
