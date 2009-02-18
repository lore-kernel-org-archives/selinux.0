Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1ILS683013520
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 16:28:06 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1ILS49O003586
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 21:28:05 GMT
Message-ID: <499C7D62.3090906@redhat.com>
Date: Wed, 18 Feb 2009 16:28:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Several fixes to restorecond
References: <499AE896.8000709@redhat.com> <499C7AAF.4070007@manicmethod.com>
In-Reply-To: <499C7AAF.4070007@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Daniel J Walsh wrote:
> Init script should be 755
> 
> libflashplayer.so has moved in the homedir and is now correct so no
> longer needs to have labeling checked.
> 
> restorecond supports glob matching and should not complain on multiple
> hard links if they match a glob.
> 
> So if a file has > 1 link and is an exact match complain, otherwise do
> not.
> 
> Also fix a couple of error messages.
>>

> Merged in policycoreutils 2.0.62

> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

This is what the F10 homedir_template looks like

HOME_DIR/.+	system_u:object_r:user_home_t:s0
HOME_DIR/.pulse(/.*)?	system_u:object_r:gnome_home_t:s0
HOME_DIR/.gnome2(/.*)?	system_u:object_r:gnome_home_t:s0
HOME_DIR/.*/plugins/nppdf\.so	--	system_u:object_r:textrel_shlib_t:s0
HOME_DIR/.*/plugins/nppdf\.so.*	--	system_u:object_r:textrel_shlib_t:s0
HOME_DIR/.*/plugins/nprhapengine\.so.*	--	system_u:object_r:textrel_shlib_
t:s0
HOME_DIR/((www)|(web)|(public_html)|(public_git))(/.+)?
system_u:object_r:httpd_
user_content_t:s0
HOME_ROOT/a?quota\.(user|group)	--	system_u:object_r:quota_db_t:s0
HOME_DIR/\.ssh(/.*)?	system_u:object_r:ssh_home_t:s0
HOME_DIR/\.uml(/.*)?	system_u:object_r:user_uml_rw_t:s0
HOME_DIR/\.java(/.*)?	system_u:object_r:mozilla_home_t:s0
HOME_DIR/\.local.*	system_u:object_r:gconf_home_t:s0
HOME_DIR/\.xauth.*	--	system_u:object_r:xauth_home_t:s0
HOME_DIR/\.fonts(/.*)?	system_u:object_r:fonts_home_t:s0
HOME_DIR/\.gnupg(/.+)?	system_u:object_r:gpg_secret_t:s0
HOME_DIR/\.adobe(/.*)?	system_u:object_r:nsplugin_home_t:s0
HOME_DIR/\.pyzor(/.*)?	system_u:object_r:pyzor_home_t:s0
HOME_DIR/\.spamd(/.*)?	system_u:object_r:pyzor_home_t:s0
HOME_DIR/\.razor(/.*)?	system_u:object_r:razor_home_t:s0
HOME_DIR/vmware(/.*)?	system_u:object_r:vmware_home_t:s0
HOME_DIR/\.gconf(d)?(/.*)?	system_u:object_r:gconf_home_t:s0
HOME_DIR/\.galeon(/.*)?	system_u:object_r:mozilla_home_t:s0
HOME_DIR/\.vmware(/.*)?	system_u:object_r:vmware_home_t:s0
HOME_DIR/\.vmware[^/]*/.*\.cfg	--	system_u:object_r:vmware_home_t:s0
HOME_DIR/\.mozilla(/.*)?	system_u:object_r:mozilla_home_t:s0
HOME_DIR/\.phoenix(/.*)?	system_u:object_r:mozilla_home_t:s0
HOME_DIR/\.mplayer(/.*)?	system_u:object_r:mplayer_home_t:s0
HOME_DIR/\.mozilla(/.*)?/plugins/libflashplayer\.so.*	--	system_u:object_
r:textrel_shlib_t:s0
HOME_DIR/\.ethereal(/.*)?	system_u:object_r:ethereal_home_t:s0
HOME_DIR/\.netscape(/.*)?	system_u:object_r:mozilla_home_t:s0
HOME_DIR/\.gstreamer-.*	system_u:object_r:nsplugin_home_t:s0
HOME_DIR/\.Xauthority.*	--	system_u:object_r:xauth_home_t:s0
HOME_DIR/\.fontconfig(/.*)?	system_u:object_r:fonts_config_home_t:s0
HOME_DIR/\.fonts/auto(/.*)?	system_u:object_r:fonts_cache_home_t:s0
HOME_DIR/\.macromedia(/.*)?	system_u:object_r:nsplugin_home_t:s0
HOME_DIR/\.gstreamer-.*/plugins/.*\.so.*	--	system_u:object_r:textre
l_shlib_t:s0
HOME_ROOT/lost\+found/.*	<<none>>
HOME_DIR/\.config/gtk-.*	system_u:object_r:gnome_home_t:s0
HOME_DIR/\.fonts\.cache-.*	--	system_u:object_r:fonts_cache_home_t:s0
HOME_DIR/\.ICEauthority.*	--	system_u:object_r:iceauth_home_t:s0
HOME_DIR/\.config/totem(/.*)?	system_u:object_r:nsplugin_home_t:s0
HOME_DIR/\.config/gxine(/.*)?	system_u:object_r:nsplugin_home_t:s0
HOME_DIR/\.gcjwebplugin(/.*)?	system_u:object_r:nsplugin_home_t:s0
HOME_DIR/\.spamassassin(/.*)?	system_u:object_r:spamc_home_t:s0
HOME_DIR/\.icedteaplugin(/.*)?	system_u:object_r:nsplugin_home_t:s0
HOME_DIR/\.xsession-errors.*	--	system_u:object_r:xdm_home_t:s0
HOME_DIR	-d	system_u:object_r:user_home_dir_t:s0
HOME_DIR	-l	system_u:object_r:user_home_dir_t:s0
HOME_ROOT	-d	system_u:object_r:home_root_t:s0
HOME_DIR/\.ircmotd	--	system_u:object_r:ROLE_irc_home_t:s0
HOME_ROOT/\.journal	<<none>>
HOME_DIR/\.screenrc	--	system_u:object_r:user_screen_ro_home_t:s0
HOME_DIR/\.fonts\.conf	--	system_u:object_r:fonts_config_home_t:s0
HOME_ROOT/lost\+found	-d	system_u:object_r:lost_found_t:s0

I Have no ROLE or USER, but I still need HOME_DIR and HOME_ROOT
translated, and these do not apply to /root
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmcfWIACgkQrlYvE4MpobOlaQCcCU5CDLlKZm/q8DSVqimz9u8z
m9AAoOIOFqm2RRzluq5Er3eraLARkIb+
=hWXM
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
