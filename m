Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6QM5trT028430
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 18:05:57 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6QM5P7L014043
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 22:05:25 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 27 Jul 2004 00:05:52 +0200
Date: Tue, 27 Jul 2004 00:06:09 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux ML <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: file_contexts patch
Message-Id: <20040726220609.GB2175@jmh.mhn.de>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407170802.08072.russell@coker.com.au> <20040716224252.GD4940@obadja.jmh.mhn.de> <200407171159.00489.russell@coker.com.au> <20040717195326.GA16762@bern.cip.ifi.lmu.de> <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Smalley <sds@epoch.ncsc.mil> [2004-07-26 22:26]:
> On Sat, 2004-07-17 at 15:53, Thomas Bleher wrote:
> > * Russell Coker <russell@coker.com.au> [2004-07-17 05:16]:
> > > Maybe we should have a suse.te and suse.fc for such things?  One thin=
g we want=20
> > > to avoid if possible is having entries in types.fc for distribution s=
pecific=20
> > > names which bloat types.fc and make setfiles run more slowly.
> >=20
> > I think this is a good idea. I have a few other policy snippets which
> > are needed on SuSE but won't be suitable for general policy.
> > As a start, I have attached a small suse.te and suse.fc.
> > Can this be included in CVS?
>=20
> Would it be better to make the distro a tunable (e.g.
> policy/tunables/distro.te) and use ifdef's in the individual .te files
> and .fc files for the distro-specific changes to a given domain?  I'd
> particularly like to see all of the RedHat-specific changes moved from
> rpm.{te,fc} into something that is clearly specific to RedHat.

That would be okay with me.

To support distro-specific file contexts we would have to modify the
build to include the tunables when creating the file_contexts file (it
is already run through m4). Something like the following quick patch:

--- orig/Makefile
+++ mod/Makefile
@@ -139,9 +139,9 @@
 	@mkdir -p $(CONTEXTPATH)/files
 	install -m 644 $(FC) $(FCPATH)
=20
-$(FC): $(FCFILES) domains/program domains/misc file_contexts/program file_=
contexts/misc users /etc/passwd
+$(FC): $(FCFILES) $(ALL_TUNABLES) domains/program domains/misc file_contex=
ts/program file_contexts/misc users /etc/passwd
 	@echo "Building file_contexts ..."
-	@m4 $(FCFILES) > $@.tmp
+	@m4 $(ALL_TUNABLES) $(FCFILES) > $@.tmp
 	@grep -v "^/root" $@.tmp > $@.root
 	@/usr/sbin/genhomedircon . $@.root  > $@
 	@grep "^/root" $@.tmp >> $@


Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBYBRxWIrrrL0q+cRAncuAJ0Xsdwq5oESfXfaJ47EWI2OjInTGwCgu8Lj
JnDTZvYp6mVrsNGA4HFmz34=
=nsHH
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
