Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AKa7Iq030137
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 16:36:07 -0400
Received: from mail-ew0-f206.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AKZRB2029619
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 20:35:28 GMT
Received: by ewy2 with SMTP id 2so513376ewy.41
        for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 13:36:06 -0700 (PDT)
Date: Thu, 10 Sep 2009 22:36:03 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: XACE: tclass malformed
Message-ID: <20090910203602.GB6469@notebook3.grift.internal>
References: <20090910160307.GA6469@notebook3.grift.internal> <4AA96193.7020905@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
In-Reply-To: <4AA96193.7020905@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2009 at 04:29:07PM -0400, Eamon Walsh wrote:
> On 09/10/2009 12:03 PM, Dominick Grift wrote:
>> Some XACE avc denials end up in /var/log/messages as opposed to /var/log=
/audit/audit.log. These particular XACE avc denials appear with a malformed=
 tclass field:
>>
>> Example:
>>
>> Sep 10 17:50:31 notebook3 Xephyr: Can't send to audit system: USER_AVC a=
vc:  denied  { get_property } for request=3DX11:GetProperty comm=3D/usr/bin=
/xterm resid=3D102 restype=3DWINDOW scontext=3Ddgrift_u:dgrift_r:sandbox_x_=
client_t:s0:c29,c36 tcontext=3Ddgrift_u:object_r:sandbox_xserver_t:s0:c29,c=
36 tclass=3Dx_drawable#012: exe=3D"/usr/bin/Xephyr" sauid=3D0 hostname=3D? =
addr=3D? terminal=3D?
>>
>> note the: tclass=3Dx_drawable#012:
>>
>> I believe this may be the reason why these avc denials end up in /var/lo=
g/messages instead of /var/log/audit/audit.log , but i am not sure.
>>
>>   =20
>
> Can you take a look in /var/log/Xorg.0.log.  The same avc's are printed =
=20
> there, please let me know if the message is malformed in the Xorg.0.log =
=20
> file as well.

I cannot find that particular AVC denial in /var/log/Xorg.0.log at all. It =
does have the AVC denials that end up in /var/log/audit/audit.log though. T=
hese have correct tclasses. For example:

[root@notebook3 Desktop]# cat /var/log/Xorg.0.log | grep X11:GetProperty | =
less | tail -n1
(WW) avc:  denied  { read } for request=3DX11:GetProperty comm=3D/usr/bin/x=
dpyinfo property=3DRESOURCE_MANAGER scontext=3Ddgrift_u:dgrift_r:sandbox_x_=
t:s0:c170,c220 tcontext=3Dsystem_u:object_r:info_xproperty_t:s0 tclass=3Dx_=
property

So It seems that the avc denials that have malformed tclasses are not in th=
ere at all.`
>
>
>
> --=20
> Eamon Walsh<ewalsh@tycho.nsa.gov>
> National Security Agency
>

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqpYzIACgkQMlxVo39jgT/tGQCgjUTJp/KIbroaW4gx9TmyeKFa
7YgAn2jN7dviq4x2GGyNPh7/nfcJFgjC
=HEGD
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
