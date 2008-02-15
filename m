Message-ID: <47B60285.9010801@redhat.com>
Date: Fri, 15 Feb 2008 16:22:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: secadm/sysadm discussion
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com>	 <200802150855.47722.paul.moore@hp.com>	 <1203088187.3669.241.camel@bluejay.goodinassociates.com>	 <1203088562.16038.196.camel@moss-spartans.epoch.ncsc.mil>	 <1203089944.13618.40.camel@gorn>	 <1203091760.3669.249.camel@bluejay.goodinassociates.com>	 <1203091792.13618.56.camel@gorn>	 <1203092070.3669.251.camel@bluejay.goodinassociates.com>	 <1203092610.13618.58.camel@gorn> <1203093415.3669.258.camel@bluejay.goodinassociates.com>
In-Reply-To: <1203093415.3669.258.camel@bluejay.goodinassociates.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

<rant>


Personally I think sysadm_t is a waste of time.  It is a poor mans
unconfined_t and should be eliminated from the face of the earth.  All
it does is generate Bugs and avc messages without supplying any real
security.  It makes no sense, as a confinement of a root user since it
is so easily gotten around.  If you have an administrator of a machine,
that you want to confine, start with only allowing him the privs that
are required to do his job.  You can't start by saying he can do
everything except ABC.

If your goal is the admin can not modify the SELinux security policy and
you don't trust the admin, you loose.  The admin can use fsadm tools, he
can use rpm, he can bring the machine to single user mode he can modify
init.

You need to define what the confined admin is allowed to manage
Apache/postgrsql/mysql and then define rules and a domain for an
administrator to do that.

Fedora 9 will have the ability to easily design an confined admin role.
 I have added NAME_admin interfaces to every confined service domain,
and system-config-selinux/polgengui now has the ability to select the
NAME_admin domains that you want to administer.  I believe this is the
way to confine a root user.  You can than setup a confined login user
staff_t or guest_t and define transitions from this domain to the admin
domain.  sudo can now be used to handle the transition.

I think we will find lots of bugs in this method, but we need people to
experiment with it.  I think we will also find security vulnerabilities
which we will need to fix in the kernel.  (chmod 4755 shell) for example.



</rant>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke2AncACgkQrlYvE4MpobN2zgCfTs1WPmpgUm5m8wo50Vwcpb9J
jy0AnAibTphoR0N2DgUG45cv3HIfkqZV
=xBer
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
