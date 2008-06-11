Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BH6pRJ013151
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 13:06:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5BH6pX5000365
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 17:06:51 GMT
Message-ID: <485005C9.8050902@redhat.com>
Date: Wed, 11 Jun 2008 13:05:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: kernel/kernel.* diffs
References: <4836D603.1000506@redhat.com> <1213020149.27496.3.camel@gorn>
In-Reply-To: <1213020149.27496.3.camel@gorn>
Content-Type: multipart/mixed;
 boundary="------------010009020005070001070502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010009020005070001070502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
| On Fri, 2008-05-23 at 10:34 -0400, Daniel J Walsh wrote:
|> Mainly adding additional dontaudits for permissive domains.
|
|> Subject: [PATCH] refpolicy: kernel_kernel changes
|> --text follows this line--
|> --- nsaserefpolicy/policy/modules/kernel/kernel.if	2008-05-23
09:15:06.224337000 -0400
|> +++ serefpolicy-3.4.1/policy/modules/kernel/kernel.if	2008-05-23
10:29:05.107838000 -0400
|> @@ -1198,6 +1198,7 @@
|>  	')
|>
|>  	dontaudit $1 proc_type:dir list_dir_perms;
|> +	dontaudit $1 proc_type:file getattr;
|>  ')
|>
|>  ########################################
|> @@ -1768,6 +1769,7 @@
|>  	')
|>
|>  	dontaudit $1 sysctl_type:dir list_dir_perms;
|> +	dontaudit $1 sysctl_type:file read_file_perms;
|>  ')
|>
|>  ########################################
|
| These two violate the intention of the interface.
|
I though the intention of the interface was to dontaudit list of all
proc or sysctl.  I believe this means we know this app tries to list
sysctl or proc so dontaudit the listing.  Well part of the listing in
permissive mode is the getattr or read.  So to make this work the way
customers would expect we need to add interfaces all over the place and
patch every call to this will a dontaudit file, which seems to be a
colossal waste of time.

Maybe we need a way to indicate whether this should be dontaudited in
enforcing mode versus permissive.

Added patch for

cgroup_t.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhQBckACgkQrlYvE4MpobM7GwCfTcHGsZQV8ZRuKTD9I6/YJ2e4
snkAoM+HSsJzbfDEfAvXfxb0ZeXbZWo/
=j1e0
-----END PGP SIGNATURE-----

--------------010009020005070001070502
Content-Type: text/plain;
 name="kernel_kernel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_kernel.patch"

--- nsaserefpolicy/policy/modules/kernel/kernel.te	2008-06-11 08:15:43.000000000 -0400
+++ serefpolicy-3.4.1/policy/modules/kernel/kernel.te	2008-06-11 10:06:56.000000000 -0400
@@ -45,6 +45,15 @@
 sid kernel gen_context(system_u:system_r:kernel_t,mls_systemhigh)
 
 #
+# cgroup fs
+#
+
+type cgroup_t;
+fs_type(cgroup_t)
+allow cgroup_t self:filesystem associate;
+genfscon cgroup / gen_context(system_u:object_r:cgroup_t,s0)
+
+#
 # DebugFS
 #
 
+

--------------010009020005070001070502
Content-Type: application/pgp-signature;
 name="kernel_kernel.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kernel_kernel.patch.sig"

iEYEABECAAYFAkhQBckACgkQrlYvE4MpobOYQwCg0p2jZ7F6nIFLmL1gywZAW3dQsw0An2i3
sYoxjsdRlXN6iBevEw9OH1rI
--------------010009020005070001070502--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
