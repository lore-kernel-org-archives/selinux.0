Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DBUfrT001888
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 07:30:42 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DBUeSW008836
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 11:30:40 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 13 Sep 2004 13:30:39 +0200
Date: Mon, 13 Sep 2004 13:31:14 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: policy patch: some misc additions
Message-Id: <20040913113113.GA2544@jmh.mhn.de>
References: <20040911133324.GA2557@jmh.mhn.de> <200409121718.46194.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
In-Reply-To: <200409121718.46194.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell Coker <russell@coker.com.au> [2004-09-12 09:19]:
> On Sat, 11 Sep 2004 23:33, Thomas Bleher <bleher@informatik.uni-muenchen.=
de>=20
> wrote:
> > The following patch against latest CVS adds some misc policy:
> >
> > logrotate.te: the suse version doesn't work without this
>=20
> I think that this is a bug in logrotate.  Looking at the source to figure=
 out=20
> what the problem is would be a good idea.

I will look at the code and see why it's happening.

> > iptables.te: added tc (traffic control) to the iptables domain
>=20
> domain_auto_trans(initrc_t, iptables_exec_t, iptables_t) is already inclu=
ded=20
> in daemon_base_domain().  Does SUSE have a change to daemon_base_domain()?

No, it's the same as everywhere else. I can't remember why I added this
(it has been in my tree for a while), but, as you noted, it should work
without so you can forget about that part.

> Why do you have tc labelled as iptables_exec_t?  On Debian and Fedora tc =
is=20
> working well labelled as ifconfig_exec_t.

Ahh, hadn't seen this.
Then I propose the following patch instead:

--- orig/file_contexts/program/ifconfig.fc
+++ mod/file_contexts/program/ifconfig.fc
@@ -3,6 +3,7 @@
 /sbin/iwconfig         --      system_u:object_r:ifconfig_exec_t
 /sbin/ip               --      system_u:object_r:ifconfig_exec_t
 /sbin/tc               --      system_u:object_r:ifconfig_exec_t
+/usr/sbin/tc           --      system_u:object_r:ifconfig_exec_t
 /bin/ip                        --      system_u:object_r:ifconfig_exec_t
 /sbin/ethtool          --      system_u:object_r:ifconfig_exec_t
 /sbin/mii-tool         --      system_u:object_r:ifconfig_exec_t

It could also be surrounded by ifdef(`distro_suse', `') if noone else=20
has tc under /usr/sbin.

> > xdm.te: needed with XFree86 4.3, kdm 3.3 and nvidia
>=20
> Why would xdm_xserver_t need it but user_xserver_t not need it? I've adde=
d it=20
> to macros/program/xserver_macros.te in my tree.

Not sure. KDM wouldn't want to start without it, but users don't seem to
need it. It don't think it's a problem to allow it unconditionally.

Thanks for your comments!
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBRYUBxWIrrrL0q+cRAjw/AJkBgcCtDwitWomqTG4BKcZnIVHgfwCgiyZ1
KBotsOEtgMLMzNPgPfvSTQQ=
=O+PC
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
