Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v37J1Iad005536
 for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2017 15:01:18 -0400
Received: by mail-wr0-f172.google.com with SMTP id o21so86610261wrb.2
 for <selinux@tycho.nsa.gov>; Fri, 07 Apr 2017 12:01:16 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id l132sm31293458wmd.10.2017.04.07.12.01.14
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Apr 2017 12:01:14 -0700 (PDT)
Date: Fri, 7 Apr 2017 21:01:13 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: MLS directory label inheritance rules
Message-ID: <20170407190113.GA30370@markus>
References: <CAFJ0LnFHgkGSY73LwKNUbn+r+E6+TivuSkZq851y12ZvQ85Qbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
In-Reply-To: <CAFJ0LnFHgkGSY73LwKNUbn+r+E6+TivuSkZq851y12ZvQ85Qbw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 11:39:55AM -0700, Nick Kralevich wrote:
> When a file is created in a directory, the default label for the file
> is based on the label of the enclosing directory (unless something
> like setfscreatecon is used). For example:
>=20
> bullhead:/ # cd /data/misc/zoneinfo/
>=20
> bullhead:/data/misc/zoneinfo # ls -ladZ .
> drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
> 1971-06-19 17:07 .
> bullhead:/data/misc/zoneinfo # touch asdf
> bullhead:/data/misc/zoneinfo # ls -ladZ . asdf
>=20
> drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
> 2017-04-07 18:32 .
> -rw-rw-rw- 1 root   root   u:object_r:zoneinfo_data_file:s0    0
> 2017-04-07 18:32 asdf
>=20
> note how the label of the "asdf" file matches the label of the
> enclosing directory.
>=20
> However, that's not true when the directory uses categories. In that
> case, the newly created file inherits the label, but not the
> categories. For example:
>=20
> bullhead:/data/data # cd /data/data/com.android.chrome
> bullhead:/data/data/com.android.chrome # ls -ladZ .
> drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768 4096
> 1971-07-15 15:31 .
> bullhead:/data/data/com.android.chrome # touch asdf
> bullhead:/data/data/com.android.chrome # ls -laZd . asdf
> drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768 4096
> 2017-04-07 18:35 .
> -rw-rw-rw- 1 root   root   u:object_r:app_data_file:s0              0
> 2017-04-07 18:35 asdf
>=20
> Note how the label is maintained, but the "c512,c768" portion is not
> maintained. While this example occurs when I'm running in a permissive
> domain, it also occurs in an enforcing domain.
>=20
> The inconsistency seems weird, and I'm sure there's a good reason why
> this occurs that I'm not familiar with. Can someone help me understand
> if this is expected, and if so, why?

I think that is actually a sane default (defaultrange source) as opposed to=
 default range target because if a process associated with s0:c123,c456 cre=
ates a file, then i would expect that file to inherit s0:c123,c456 from the=
 source and not s0 from the target for example

RedHat, i think, overrides this default as well and uses defaultrange targe=
t and I think that is a strange decision.

If I have qemu instance with s0:c123,c456 that for example creates a pty, t=
hen I would want to have that pty constrained by s0:c123,c456 as well

>=20
> --=20
> Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljn4fEACgkQJXSOVTf5
R2nR0gv/by58yiha/mDIiGUNELqnrh+UGgYfWpmpCGXQSC0iORkPhsmdWCAYFP81
P86WJNDOYiw9CMIgdkLZtB36hcIPnsfuH61PX/ytfHXMdb5d1KyQdjCsEYsQLgoM
IQRFd1M3UaJEcdekwsGi95szUCQhmjePpX3+zwp4gpC+Tjsj1I5ETpk8lRhhdCtv
m1nN1RuozCVPCe536DLZZ5INXf/S/o+/ZFZUfK1A3BLaINXx+ffNgUu6LzAltzbp
nFIVX8bldUvZ7brdvIShzLGhLE7zAXtfT7jiACoMlafOK87dWP4QTXiDWIQjpMg/
XxFgyGjX3c5uWFOLiQ/IJAk4Wl/KL1xaTTDFcUbwfZgz/4mvY2XPL11jNB7mbusr
pzyCraXX2kCa/OqEDcotmGUiv19BOU7SBloCuOu3ykDJ5mDZoFVGgT4IjRX6SLqo
9kMhZPMJjRavpYGve5yiqdB+/NLc0ESrPc1yzUJiid7z7iRza6XtWDhCAHR7JXV+
6ktYK/Pf
=AHOr
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
