Message-ID: <4FD61901.1010806@redhat.com>
Date: Mon, 11 Jun 2012 12:12:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Boolean change of names.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We have started pushing a boolean change into Fedora 18.

https://fedoraproject.org/wiki/Features/SELinuxBooleansRename

The problem we are seeing is that boolean names used within an interface are
causing the install to fail on rebuild of policy.

IE If I installed a custom policy with a boolean used in it, and the boolean
changed then the module will blow up the policy compile.


interface(`kerberos_manage_host_rcache',`
	gen_require(`
		type krb5_host_rcache_t;
	')

...

	tunable_policy(`allow_kerberos',`
		allow $1 self:process setfscreate;
...
	')

...
')

And change the allow_kerberos to kerberos_enabled.

One idea would be to pull the translations into the semanage, or would I need
to do this at a lower level.  Or are we stuck with these bad names forever...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/WGQEACgkQrlYvE4MpobOHYQCdEg6dag1f3ucskDiXohzcMITB
pPQAoM21wP+O5Cgsiu2dmFGR+UcRaFne
=1UKe
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
