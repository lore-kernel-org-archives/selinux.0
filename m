Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4RBjb9N006705
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 07:45:38 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4RBjbw7005363
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 11:45:37 GMT
Message-ID: <483BF410.5030309@redhat.com>
Date: Tue, 27 May 2008 07:44:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New domain for nsplugin
References: <4831B4E7.6010000@comcast.net> <1211816762.11188.181.camel@gorn.columbia.tresys.com>
In-Reply-To: <1211816762.11188.181.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
| On Mon, 2008-05-19 at 13:12 -0400, Daniel J Walsh wrote:
|> --- nsaserefpolicy/policy/modules/apps/nsplugin.fc	1969-12-31
19:00:00.000000000 -0500
|> +++ serefpolicy-3.4.1/policy/modules/apps/nsplugin.fc	2008-05-19
11:36:24.749177000 -0400
|> @@ -0,0 +1,9 @@
|> +
|> +/usr/lib(64)?/nspluginwrapper/npviewer.bin	--
gen_context(system_u:object_r:nsplugin_exec_t,s0)
|> +/usr/lib(64)?/nspluginwrapper/plugin-config	--
gen_context(system_u:object_r:nsplugin_config_exec_t,s0)
|> +/usr/lib(64)?/mozilla/plugins-wrapped(/.*)?		
gen_context(system_u:object_r:nsplugin_rw_t,s0)
|> +
|> +HOME_DIR/\.adobe(/.*)?		
gen_context(system_u:object_r:user_nsplugin_home_t,s0)
|> +HOME_DIR/\.macromedia(/.*)?	
gen_context(system_u:object_r:user_nsplugin_home_t,s0)
|> +HOME_DIR/\.gstreamer-.*		
gen_context(system_u:object_r:user_nsplugin_home_t,s0)
|> +HOME_DIR/\.local.*		
gen_context(system_u:object_r:user_nsplugin_home_t,s0)
|
| I'm having trouble buying this one.  It seems pretty broad, especially
| since acrobat isn't only a browser plugin, and I'm not sure what
| gstreamer is doing here.
|
These are basically directories that nsplugin needs to write in.  So we
can define a new context for each, without a controlling domain.  But we
need to set a new precedence for this.

gstramer_home_t, adobe_home_t?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkg764wACgkQrlYvE4MpobMMLwCeP75ccyLjysfBHjdPlMhXeIEN
mgkAnjgWcsVHV2B+zIdJmH3xsW9o8Crl
=LsdV
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
