Date: Thu, 19 Feb 2015 11:58:44 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MCS error
Message-ID: <20150219195844.GD12937@tracyreed.org>
References: <20150219014803.GB12937@tracyreed.org>
 <54E60CF9.2090006@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H7BnLk9CMipoMykF"
In-Reply-To: <54E60CF9.2090006@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--H7BnLk9CMipoMykF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 08:19:05AM PST, Stephen Smalley spake thusly:
> As Dominick pointed out, Fedora and RHEL migrated away from trying to
> using MCS on users to using it for specific use cases, e.g. sandbox,
> sVirt (KVM+SELinux), openshift, etc.  So the MCS constraints may not be
> applied to anything in that policy except for the domains used for those
> specific applications.

We intend to use it to sandbox web apps. This sounds like what RHEL is tryi=
ng
to use it for, right?=20

Will it simply not work at all for users in RHEL6 as it used to for RHEL5? =
That
seemed a very simple way to set it up and would work perfectly for our need=
s.
If it won't work for users do we now have to assign a specific type/domain =
to
our app? The app always runs under a specific user so we could actually
associate that user with a domain instead of unconfined, correct?

Here is our current setup, which is all messed up. I'm not sure how we arri=
ved at this:

# semanage login -l

Login Name                SELinux User              MLS/MCS Range          =
 =20

__default__               unconfined_u              SystemLow-SystemHigh   =
 =20
p16001                    p16001_u                  p16001                 =
 =20
p16002                    appuser_u                 AppAdmin-p16002        =
 =20
p16003                    appuser_u                 AppAdmin-p16003        =
 =20
p16004                    unconfined_u              s0-s0:c0.c1023,c4      =
 =20
p16005                    unconfined_u              s0-s0:c0.c1023,c4,c5   =
 =20
p16006                    unconfined_u              s0-s0:c0.c1023,c6      =
 =20
p16007                    unconfined_u              s0-s0:c0.c1023,c7      =
 =20
p16008                    unconfined_u              s0-s0:c0.c1023,c8      =
 =20
p16009                    unconfined_u              s0-s0:c0.c1023,c9      =
 =20
root                      unconfined_u              SystemLow-SystemHigh   =
 =20
system_u                  system_u                  SystemLow-SystemHigh=20

So the first problem I see is that the login names p16004-16009 are assigne=
d to
unconfined_u so they will never be denied anything except DAC and MCS will =
not
be enforced, correct?

Is the user p16001 setup correctly in that it has its own assigned SELinux =
user
and one specific category assigned to it?

Then we need to fix the MLS/MCS ranges for the other users. Currently
unconfined_u has s0-s0:c0.c1023 plus a seemingly redundant ,c4,c5 etc. Just=
 as
a test I am trying to use:

chcat -l -- -c4 p16005

to remove the c4 category from p16005 but that didn't work for some reason.=
 We
need to remove all of the categories except one which should be unique to e=
ach
user since each instance of our web app runs under each user p16001 or p160=
02
etc. respectively.

Currently I have the above setup and can login as p16001 and see files like=
 this:

-bash-4.1$ id
uid=3D16001(p16001) gid=3D16001(p16001) groups=3D16001(p16001) context=3Dp1=
6001_u:user_r:user_t:p16001
-bash-4.1$=20
-bash-4.1$ ls -laZ
drwxr-xr-x. root   root   system_u:object_r:default_t:SystemLow .
drwxrwxr-x. root   root   system_u:object_r:default_t:SystemLow ..
drwxr-xr-x. p16001 p16001 unconfined_u:object_r:default_t:p16001 p16001
drwxr-xr-x. p16002 p16002 unconfined_u:object_r:default_t:p16002 p16002
drwxr-xr-x. p16003 p16003 unconfined_u:object_r:default_t:p16003 p16003
-bash-4.1$ id
uid=3D16001(p16001) gid=3D16001(p16001) groups=3D16001(p16001) context=3Dp1=
6001_u:user_r:user_t:p16001
-bash-4.1$ cd p16002/
-bash-4.1$ ls -laZ
drwxr-xr-x. p16002 p16002 unconfined_u:object_r:default_t:p16002 .
drwxr-xr-x. root   root   system_u:object_r:default_t:SystemLow ..
-rw-r--r--. p16002 p16002 unconfined_u:object_r:default_t:p16002 testfile
-bash-4.1$ cat testfile=20
I am 16002

Why can I cat that file? User p16001 has category p16001 and the file I cat=
'd
id category p16002. Seems like enforcement is not working here. Is this what
Dominick was referring to in that I need to do something else to "opt-in" to
the enforcement?

What are the best resources for learning how to use MCS in RHEL6?

> The -mls policy might be a better fit if you want to apply it system-wide.

Isn't MLS even less used/supported than MCS? From my description of our use
would you say that MCS is the right fit as opposed to MLS? It seems like the
standard targeted policy for most stuff on the box plus MCS to confine/sand=
box
our apps would be the way to go.

Thanks!

--=20
Tracy Reed

--H7BnLk9CMipoMykF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFU5kB0BhSTPg0d/nQRAsaxAKDE4SnwOgw4zlcIvMDcbt62dd9kFACgj+AZ
dfzhGyow/ur+VD3K6/xcEiA=
=lfB4
-----END PGP SIGNATURE-----

--H7BnLk9CMipoMykF--
