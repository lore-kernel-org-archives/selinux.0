From: "Waide, Ronan" <waider@amazon.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Yuichi Nakamura
	<himainu-ynakam@miomio.jp>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        James Morris
	<jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh
	<dwalsh@redhat.com>
Date: Wed, 13 Feb 2008 12:06:00 +0000
Subject: RE: Disabling SELinux by kernel vulnerability
Message-ID: <263FA95FD38963459CE5DF116730557A12A4E39E91@EX-DUB2-A.ant.amazon.com>
References: <20080212234339.40551955.himainu-ynakam@miomio.jp>
 <1202841912.24250.105.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1202841912.24250.105.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On Behalf Of Stephen Smalley
> It would be more useful to just build a kernel with a config that
> disabled the support for permissive mode and runtime disable
> altogether;

Is this the current recommended way of preventing SELinux from being switched off? There's a FAQ somewhere that used suggest disabling a particular macro in the policy build (which I can't recall off the top of my head) but by the time I got around to trying it out it on a test system the technique no longer worked.

Cheers,
Waider.
- --
Ronan Waide / waider@amazon.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)

iD8DBQFHst0lBK4+zUKLsUkRAh5iAJ0YsGzYawUdra5uqxPQD5nJTzQU+wCfWU5D
dRfh+aboTpBtCW4q8+6TlT0=
=hU46
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
