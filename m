Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LIErPA031983
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 14:14:53 -0400
Received: by wghq2 with SMTP id q2so93872945wgh.1
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 11:14:48 -0700 (PDT)
Date: Thu, 21 May 2015 20:14:45 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: add selinux_openssh_contexts_path()
Message-ID: <20150521181443.GE683@x131e>
References: <1432224862-14659-1-git-send-email-plautrba@redhat.com>
 <20150521162441.GB683@x131e> <20150521165322.GD683@x131e>
 <555E1DA2.1030606@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
In-Reply-To: <555E1DA2.1030606@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 02:02:10PM -0400, Stephen Smalley wrote:
> On 05/21/2015 12:53 PM, Dominick Grift wrote:
> > On Thu, May 21, 2015 at 06:24:41PM +0200, Dominick Grift wrote:
> >> On Thu, May 21, 2015 at 06:14:22PM +0200, Petr Lautrbach wrote:
> >>> openssh in Fedora uses "sshd_net_t" type for privilege separated
> >>> processes in the preauthentication phase. Similarly, openssh portable=
 uses
> >>> "sftp_t" for internal-sftp processes. Both type are hardcoded what is=
 not ideal.
> >>> Therefore selinux_openssh_contexts_path() was created to get a path w=
here sshd
> >>> can get a correct types prepared by a distribution or an administrato=
r.
> >>
> >> I requested this feature and i am using this feature in my personal po=
licy. So hereby my ACK for what it is worth.
> >>
> >> However:
> >>
> >> That SYSTEMD_CONTEXTS though, that must have been a mistake?
> >=20
> > As far as i am concerned this commit should be reverted:
> >=20
> > https://github.com/SELinuxProject/selinux/commit/ce2a8848ad45e375cfdb58=
cebe28bc12431bb3db
> >=20
> > I just did a grep -ri systemd_contexts in the systemd repository and no=
thing returned. I also cannot place that commit message.
> >=20
> >>
> >> I do not believe that this is used or that it is needed/wanted.
>=20
> We can remove it as a separate change, but only if there are no users,
> even in legacy distributions, as otherwise it would be an ABI break.
>=20
>=20

I do not believe this was ever used. Am i right, Dan?

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVXiCQAAoJENAR6kfG5xmcmJ0MAJ6AMgXWyFPl5y4Ycr99nYn4
YQmiq9xM6EeomocgbQf7ei9/D87j7xwZW0pIw6aitXi2B97FC+LXJqD3oH0m5AP7
cI/+EEktOi4loG4RZCZJ9JfZmsNdsBhssi/hRf0c7+7QYbUzcoRYF+Ie7OhZnGIe
Q9WMJNrn21HFFgzN9Nt4DjE87LBazgCeu6BRkzBwK0r0N/MpPZflh5Gupv83EU2B
wwf7NpPz4MsIa5kbuifwgJeH2xVx2oHVjCqNe2GC+vsdKsqPFakhPjVUWEkUPl/+
JtEh9BnTmFe15Drxn0T8J2Kh8KGZBPtfPc0EwXh0xtJkkLx+4EBUYmT/X7GkLu5B
fhfLbVOSlLM7E2OEXEzMpSdM33TpVPd9iZEybF9mRNHNKOnENXkVknwFmzIrRD8W
fRvFjjLEaZFhvqpT+h/+0aMzbu8Kc1Re0p8awx1xxce0SV7BQ8bzxunCk5gOVA1+
Miwlda4mU3Wx9fBZqFmkV8oVt20IGAANcAflw8jUmw==
=aWcU
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
