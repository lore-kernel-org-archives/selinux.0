Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8TNJ4xH032208
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 19:19:05 -0400
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8TNJ4RD008892
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 23:19:05 GMT
Message-ID: <48E1625E.3050003@manicmethod.com>
Date: Mon, 29 Sep 2008 19:18:54 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Some missing man pages from libselinux
References: <48DA3948.9060003@redhat.com>
In-Reply-To: <48DA3948.9060003@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> We are still missing the following man pages.
> Perhaps some of these functions should be removed?
> selinux_users_path seems to return a bogus directory?
> Also do not have _raw functions defined in man pages.

This and the other 2 patches were merged in libselinux 2.0.73. I added a Todo page to the wiki (http://userspace.selinuxproject.org/trac/wiki/Todo) and added the man pages below.

> 
> matchpathcon_checkmatches
> matchpathcon_filespec_add
> matchpathcon_filespec_destroy
> matchpathcon_filespec_eval
> matchpathcon_index
> matchpathcon_init_prefix
> print_access_vector
> security_canonicalize_context
> security_disable
> security_set_boolean_list
> selinux_check_passwd_access
> selinux_customizable_types_path
> selinux_file_context_cmp
> selinux_file_context_verify
> selinux_get_callback
> selinux_init_load_policy
> selinux_lsetfilecon_default
> selinux_mkload_policy
> selinux_raw_to_trans_context
> selinux_trans_to_raw_context
> selinux_translations_path
> selinux_users_path
> set_selinuxmnt
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkjaOUgACgkQrlYvE4MpobOiewCeJmyth4NPBeNu4rvnvc8fcsMd
> UxEAn0mDTAiDHVzyhvG2QNaBUKBzemE9
> =dElU
> -----END PGP SIGNATURE-----
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
