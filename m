Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MJ7mgW025824
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 14:07:48 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MJ7k29006270
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 19:07:46 GMT
Message-ID: <47BF1D7C.4060207@redhat.com>
Date: Fri, 22 Feb 2008 14:07:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: default user roles
References: <1203704148.3669.953.camel@bluejay.goodinassociates.com>
In-Reply-To: <1203704148.3669.953.camel@bluejay.goodinassociates.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremiah Jahn wrote:
> I can't seem to get the login to set the proper initial role for a user.
> Every time I login, I end up as auditadm, and not secstaff.
> 
> I have the following in my policy:
> 
> userdom_unpriv_user_template(secstaff)
> userdom_role_change_template(secstaff, secadm)
> userdom_role_change_template(secstaff, auditadm)
> allow secstaff_t devlog_t:sock_file write;
> allow secstaff_t newrole_t:process { siginh noatsecure rlimitinh };
> allow secstaff_t syslogd_t:unix_dgram_socket sendto;
> allow secstaff_t unconfined_tmp_t:dir { write search rmdir remove_name create getattr add_name };
> allow secstaff_t user_home_dir_t:dir { read getattr search };
> userdom_manage_generic_user_home_content_files(secstaff_t)
> userdom_read_generic_user_home_content_files(secstaff_t)
> 
> ############################################################
> # Set default role for sec staff <-- not quite :)
> #
> role secstaff_r types secstaff_t;
> 
> ############################################################
> # define roles the secstaff can transition to
> #
> user secstaff_u roles { secstaff_r secadm_r auditadm_r } level s0 range s0 - s0;
> 	
> 
> 
> 
> 
> In the olden days in England, you could be hung for stealing a sheep or
> a loaf of bread. However, if a sheep stole a loaf of bread and gave it
> to you, you would only be tried for receiving, a crime punishable by
> forty lashes with the cat or the dog, whichever was handy. If you stole
> a dog and were caught, you were punished with twelve rabbit punches,
> although it was hard to find rabbits big enough or strong enough to
> punch you. -- Mike Harding, "The Armchair Anarchist's Almanac"
You probably need a

/etc/selinux/TYPE/contexts/users/secstaff_u
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke/HXwACgkQrlYvE4MpobOX5ACeO5fHUGU3f4xqttOd/YktKDTG
eVMAn2XUtWC6zeLZEkybzGMUQqIDUZkA
=6Hjz
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
