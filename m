Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8RG5lng009399
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 12:05:47 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8RG7Hgg026507
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 16:07:17 GMT
Received: by ewy7 with SMTP id 7so3970124ewy.41
        for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 09:05:45 -0700 (PDT)
Date: Sun, 27 Sep 2009 18:05:42 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: pam_namespace context inside of name.inst
Message-ID: <20090927160540.GA7217@notebook3.grift.internal>
References: <dd18b0c30909262312l1c5a82dfxf9270ecc33b9d64a@mail.gmail.com>
 <20090927131307.GA4502@notebook2.grift.internal>
 <4ABF8148.4010108@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <4ABF8148.4010108@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2009 at 08:14:16AM -0700, Justin P. Mattock wrote:
> Dominick Grift wrote:
> >On Sat, Sep 26, 2009 at 11:12:20PM -0700, Justin Mattock wrote:
> >>I'm going crazy over here trying to figure
> >>out how one system created a context inside
> >>name.inst one way and another for the other system:
> >>
> >>the first system has inside of
> >>name.inst:
> >>system_u:object_r:file_t_name
> >
> >This is wrong because the fs wasnt labelled properly
> That's what I figured,(this is the system that I did not label
> before turning on namespace).
> >>and on the other system I have:
> >>
> >>name:object_r:user_home_dir_t_name
> >
> >This is right
> This is from the system that was labeled before turning on namespace.
> >>the only difference with the machines is one machine
> >>had not been labeled yet, before turning on namespace.
> >>
> >>what should be the right context directory inside of
> >>name.inst?
> >
> >Depends, i think theres 3 different possibilities (not sure)
> >
> >first theres only name (no selinux) which create a dir with the user name
> >second is context which create a dir with the context of the usre home d=
ir (user_home_dir_t and appends the user name
> >third is level , which creates a dir with the context of the user home d=
ir and appends the username and also appends the level of the dir.
> >
> >>--=20
> >>Justin P. Mattock
> >>
> >>--
> >>This message was distributed to subscribers of the selinux mailing list.
> >>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.go=
v with
> >>the words "unsubscribe selinux" without quotes as the message.
> So either you can use(name,context,level) or (meth=3D1,2,3)?
> (I'm wondering if this is all I need to configure)

This is what i use in /etc/security/namespace.conf:

/tmp     /tmp-inst/             level      root,adm
/var/tmp /var/tmp-inst/         level      root,adm
$HOME    $HOME/$USER.inst/     level    root,adm


Besides that you would add entries to the related logins in /etc/pam.d/

For example:
session    required    pam_namespace.so

These entries are often already there.

And you need to set the boolean:
allow_polyinstantiation --> on

Also chmod -R 000 /tmp-inst (and /var/tmp-inst)
And make sure the have proper labelling:
[root@notebook3 pam.d]# /usr/sbin/semanage fcontext -l | grep tmp-inst
/tmp-inst                                          directory          syste=
m_u:object_r:tmp_t:s0
/tmp-inst/.*                                       all files          <<Non=
e>>
/tmp-inst/\.ICE-unix                               directory          syste=
m_u:object_r:xdm_tmp_t:s0
/tmp-inst/\.ICE-unix/.*                            socket             <<Non=
e>>
/tmp-inst/\.X0-lock                                all files          syste=
m_u:object_r:xserver_tmp_t:s0
/tmp-inst/\.X11-unix                               directory          syste=
m_u:object_r:xdm_tmp_t:s0
/tmp-inst/\.X11-unix/.*                            socket             <<Non=
e>>
/tmp-inst/\.font-unix(/.*)?                        all files          syste=
m_u:object_r:xfs_tmp_t:s0
/var/tmp-inst                                      directory          syste=
m_u:object_r:tmp_t:s0

After that , the rest should go automaticly. You do not have to manually cr=
eate /home/joe/joe.inst ( usually this is done for you, and same goes for s=
tuff under there plus stuff under /tmp-inst and /tmp-inst.=20

If however joe.inst is not automatically created on login , than do it manu=
ally. also do chmod -R 000 on it and make sure its context is user_home_dir=
_t.=20

>=20
> Anyways what's getting me is after the initial loading
> of namespace, the directory is created with the context
> (namespace.conf is set to it's default).
> Then after wards I haven't found a way to change that directory
> (besides using mv, or cp)from what it is(*file_t) to
> the correct context(*home_dir_t)
>=20
> if I delete that directory, then logout/in namespace does not
> create another. Is there a way to reset namespace and start fresh
> since I messed up and turned on namespace before labeling my filesystem,
> causing it to somehow be stuck with the wrong labeled context?

It should create a new one automatically...
>=20
> Justin P. Mattock

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkq/jVQACgkQMlxVo39jgT9+EgCdGOqSMTnpIGtOw4mnfCrh5iur
o8QAnAuxLGIWxd7LXkdkPoFU4gyfuw0T
=b3Jm
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
