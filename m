Message-ID: <5051FB6A.8040106@redhat.com>
Date: Thu, 13 Sep 2012 11:27:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Serge Hallyn <serge@hallyn.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] selinux-testsuite:  Allow test domains to read /etc/passwd
References: <1347545325.15047.34.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1347545325.15047.34.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/13/2012 10:08 AM, Stephen Smalley wrote:
> Several test cases require the ability to read /etc/passwd to look up
> usernames.  Recent Fedora introduced a separate type on /etc/passwd and
> therefore we need to add an interface call to test_global.te.  Fixes three
> test failures on Fedora 17.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov> --- 
> policy/test_global.te | 2 ++ 1 file changed, 2 insertions(+)
> 
> diff --git a/policy/test_global.te b/policy/test_global.te index
> 77121ae..fdfd291 100644 --- a/policy/test_global.te +++
> b/policy/test_global.te @@ -88,3 +88,5 @@
> selinux_compute_access_vector(testdomain) 
> selinux_compute_create_context(testdomain) 
> selinux_compute_relabel_context(testdomain) 
> selinux_compute_user_contexts(testdomain) + +auth_read_passwd(testdomain)
> 
Probably should use

auth_use_nsswitch(testdomain)

Since this will handle cases where users are listed in ldap or use sssd.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBR+2oACgkQrlYvE4MpobMW4wCfatkbYxWYNhJCWH96YUS8frm8
kwMAoJrC6pS6YOFQcYlNFtqE07hFn6ia
=NZ1T
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
