Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF2CC47404
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D031D206C0
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 17:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwhgWH1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfJGRJs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:09:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43611 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfJGRJr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 13:09:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id r9so13148801edl.10
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2019 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDtSxYCIpcV1xusFIP/dik8wEEngruv6RLaSfb0fVbw=;
        b=YwhgWH1QlATXl1WGiooA4Ncy1TCBtzlBUIQ7UVTUOiYbwuaKbiiEbAdcImCEqfqKUi
         2oq3g4qP4Wlv9xWMWZFVFE+mHsXeKxC+pCR4lFps/3lrXZ2KbhuXWHshCpnir3W+LvTw
         sPhiScIJwc+yHjDKOZB7Q8G5UpOK1brNWhuxdCDZFJUQfCG9ZcKHi9+6FRagEZi14Lbn
         B3lrZf3mHJg+2VtiWONU9cKJVzDmnzTRKjcjHO/Ca2ki2+JsKgVHLYPlGFvo1JzVtmxv
         8JPrUTiUqvKuJoFIzmalEb+bKQNtlKRIU94JfQIqt8RXKMfvxe8FkD+Ou4oZOEDCyHBK
         d0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDtSxYCIpcV1xusFIP/dik8wEEngruv6RLaSfb0fVbw=;
        b=UblU5KI60GJ3DHWYz7UDzpFKC9r0TpLjfjcdmsldv8NJi/eSdh1cfAYaznCSOU2unt
         rAN7jio+zEsn0nLKYMgxdE4detEzBNOr6OkfkkqHsYE8cK69Qtz7F9baL2Ah7lZhngJ9
         f69KY9Op0HgOZTYqruJhdL6EJHblD2jvA75K1kVsqqJpW4ze47GMYgIFWPG+OB2Cj9L2
         3PNMKuEnQpUrXK1LulfREAeKxlFqehTE27g+M1zwXyQmlmGD0J2V5urkN1o8pVY/wH5J
         rhrwtVUSAznPcjcVHsT26Ox6dc6WayoXmC9kippODSTSQZcBg4yTb781Zdx/V8ZPcapr
         iTHA==
X-Gm-Message-State: APjAAAVUBlyCfSGzWVwHHuq7LeLbKNMgw7kOrSBg+S4dTlGWucFliegM
        PlFnCrfiV8yLqJLPNeKD8CU=
X-Google-Smtp-Source: APXvYqwjS/aGChFZlGtPVt4yC5wO8YMN4tE+gkQTdUA6mitWEX8z7mlQs4LMOHCRXMWk6BVi7BqFBA==
X-Received: by 2002:a50:e691:: with SMTP id z17mr29921000edm.84.1570468183999;
        Mon, 07 Oct 2019 10:09:43 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id p1sm1925884ejg.10.2019.10.07.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 10:09:43 -0700 (PDT)
Date:   Mon, 7 Oct 2019 19:09:41 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Ian Pilcher <arequipeno@gmail.com>, selinux@vger.kernel.org,
        Systemd <systemd-devel@lists.freedesktop.org>
Subject: Re: [systemd SELinux] system status permission
Message-ID: <20191007170941.GD1088825@brutus.lan>
Mail-Followup-To: Ian Pilcher <arequipeno@gmail.com>,
        selinux@vger.kernel.org,
        Systemd <systemd-devel@lists.freedesktop.org>
References: <ae9ac0bb-0354-4d5a-fce7-dfc37481f439@gmail.com>
 <20191007165157.GC1088825@brutus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <20191007165157.GC1088825@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2019 at 06:51:57PM +0200, Dominick Grift wrote:
> On Mon, Oct 07, 2019 at 11:03:44AM -0500, Ian Pilcher wrote:
> > I am hitting this (non-fatal) denial when reloading a service via the
> > systemd dbus API:
> >=20
> > > type=3DUSER_AVC msg=3Daudit(1570462081.809:743): pid=3D1 uid=3D0
> > > auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
> > > msg=3D'avc:  denied  { status } for auid=3Dn/a uid=3D0 gid=3D1001
> > > cmdline=3D"/usr/bin/python2 /usr/local/bin/test.py"
> > > scontext=3Dsystem_u:system_r:denatc_t:s0
> > > tcontext=3Dsystem_u:system_r:init_t:s0 tclass=3Dsystem
> > > exe=3D"/usr/lib/systemd/systemd" sauid=3D0 hostname=3D? addr=3D? term=
inal=3D?'
> > https://selinuxproject.org/page/NB_ObjectClassesPermissions defines this
> > permission as "Get system status information," which isn't particularly
> > helpful.
> >=20
> > Ultimately, I need to decide whether to allow or "dontaudit" this
> > denial, so any information/pointers on what systemd is doing here and
> > what functionality I will lose if I dontaudit this denial would be
> > appreciated.
>=20
> Not sure but this is my best bet:
>=20
> Generally, i think, its about "getting" information from systemd1, as opp=
osed to setting things.
>=20
> Stuff like: introspection, getting info about objects it manages, about i=
t's properties.
>=20
> Theres a lot of "status information" to be gotten I guess. Introspect sys=
temd1 to see what all is there.
>=20
> But if you reload a unit, I gather, you might get some status information=
 about it from systemd1.
>=20
> I guess you can probably see the methods that are being invoked if you se=
t the systemd loglevel to debug
>=20
> systemd-analyze log-level debug && systemctl reload foo && journalctl -rb

I tried it out with simple `systemctl status`

Oct 07 19:04:21 myguest systemd[1]: Sent message type=3Dmethod_return sende=
r=3Dorg.freedesktop.systemd1 destination=3Dn/a path=3Dn/a interface=3Dn/a m=
ember=3Dn/a cookie=3D1 reply_cookie=3D1 signature=3Da{sv} error-name=3Dn/a =
error-message=3Dn/a
Oct 07 19:04:21 myguest systemd[1]: SELinux access check scon=3Dwheel.id:sy=
sadm.role:systemctl.sysadm.subj:s0 tcon=3Dsys.id:sys.role:systemd.system.su=
bj:s0 tclass=3Dsystem perm=3Dstatus path=3D(null) cmdline=3D: 0
Oct 07 19:04:21 myguest systemd[1]: Got message type=3Dmethod_call sender=
=3Dn/a destination=3Dorg.freedesktop.systemd1 path=3D/org/freedesktop/syste=
md1 interface=3Dorg.freedesktop.DBus.Properties member=3DGetAll cookie=3D1 =
reply_cookie=3D0 signature=3Ds error-name=3Dn/a error-message=3Dn/a

So the method "get all properties from systemd1" was called by running that=
, and that triggered a "system status" check

>=20
> >=20
> > Thanks!
> >=20
> > --=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Ian Pilcher                                         arequipeno@gmail.com
> > -------- "I grew up before Mark Zuckerberg invented friendship" --------
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2bcVEACgkQJXSOVTf5
R2kotQv/W8AwOh1vheEeedJtD+QCoQ2OXwOzRo73WWREa1kbA+bEAdjk0B9or/kA
/khdn5hqcVr4OXxAYdf8lXt3phlplNVtIGR3F354UkCLU36VKO/6T0C0zdB8HaGD
irF/KpL1cfHBs+XXOJPmtz6Tu0VTeSF3oDO12up4SI9VAKnfWu1mNMtNNRn7t7rN
oh0/5EKWpHLNZL+ldsJPg6MR1rNuWu0crLJiA0h9WwvfIrPlRG1wJLL3lb1QGLgs
L+0TIpJqswrOp+SZmYMMvCkvhIpGWhwSQjgd1NsGZsADS0VJb7PVXOmSoZFkwB8k
nXOV7mlSsdbl97z5voST7sptl+XrX/hkM/lVJOmfx0soCKmVtg5Kgdf2NykMAmc7
Jtw/u9C3OuKqIcThHZb4QyFNWGtF6+ElBiRHkhQAFZQ23JOcZvggq33I7YzEd4yL
LbBq2oWNDN32vuqu++PkHJVKoWb6A7gdb71ybmWOjMdhNeLAztxFchEBnIf2lAM9
i3GTx2LG
=eGTM
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
