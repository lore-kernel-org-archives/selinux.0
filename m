Message-Id: <200607311428.k6VESR6m004599@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH 0/2] new and improved range_transition statements
In-Reply-To: Your message of "Mon, 31 Jul 2006 09:56:24 EDT."
             <1154354184.1447.23.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <44CA2919.4010708@trustedcs.com> <1154351236.26550.14.camel@localhost.localdomain>
            <1154354184.1447.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154356107_3409P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 31 Jul 2006 10:28:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1154356107_3409P
Content-Type: text/plain; charset=us-ascii

On Mon, 31 Jul 2006 09:56:24 EDT, Stephen Smalley said:
> On Mon, 2006-07-31 at 09:07 -0400, Karl MacMillan wrote:
> > My biggest question is how to handle the format change. There are some
> > other bug fixes awaiting a module format change (not certain about
> > kernel format change) and it would be nice to include those in this
> > format bump. Unfortunately there are not patches for those fixes at the
> > moment.
> > 
> > Could we branch the code for a month or so for the other changes can be
> > introduced or is the fix more critical? Do you think that this must go
> > into RHEL 5 / FC6? Is it possible for the kernel changes to make it in
> > time for 2.6.18 and if they don't will this be included in RHEL 5 / FC6?
> 
> It doesn't necessarily have to be in 2.6.18 to make RHEL5; consider the
> MLSXFRM and NetLabel patches, which are being queued for 2.6.19 but IIUC
> will be back ported and included in RHEL5.

2.6.18-rc3 just came out - I suspect that a patch that modifies an
external module format won't be looked upon kindly for inclusion in .18.
Looks like "submit for the .19 merge window and backport for RHEL5" will
be the way to go. (Looks like FC6 will be in the same category, AFAICT).

--==_Exmh_1154356107_3409P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEzhOLcC3lWbTT17ARAiLyAKDcSdVyNYsryjIQz2MIpd99hF5A3wCeLh0U
gUSy/Abtdys6wtEsc2iKaBU=
=sBmG
-----END PGP SIGNATURE-----

--==_Exmh_1154356107_3409P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
