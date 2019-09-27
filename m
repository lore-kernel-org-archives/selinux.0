Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7528CC4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ADB217D7
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IytLYySr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfI0NtN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:49:13 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:43628 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0NtN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 09:49:13 -0400
Received: by mail-ed1-f53.google.com with SMTP id r9so2363826edl.10
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U340R3DIsgzv7HCH1YpiIQL6bI+gSR1TaWR9viefJAc=;
        b=IytLYySrkUaOmIy8cx8xNngSrgpcNYEOnqjBbVSUKuw06woGXEcka69FANpMYVIdyS
         gq3Vttt4SAP+D92HH9al5NUMOVIN7KChylL0kcIkIYZqEZFV/qHr7TkmiuvMqj/iJEZ+
         Ct1M+Tic45X7deXpIqKs9XrQOZhz2EBI9b1ql1FLoEtHhS/OW06AHoui8YCdSIuu6/Vo
         JQnigiyn3fmAgDi5CbeWyTH1uX05j+TZbzKxkJic2ajXlCEWYbMhUL9RLEu5cgWwACQ/
         bFuIcBYTy7qbhoBpiZ+P6R2WQDr647L4jow1O75Mq352JEcsA7wp9lPJnShC2g+z0p7F
         7KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=U340R3DIsgzv7HCH1YpiIQL6bI+gSR1TaWR9viefJAc=;
        b=WoVmjHvtBoVFyeAtJVK5NoCrCfhwSp5L0V2w9nrQ0xTFIqp3YpOiUOUJAX0nnzK082
         RtRGL+bbzKnA3pvNPpxYh2WKlwcIV79aZfLwHfM/I3r1Ouo//4NfYnaQPfTM7DFomzCe
         VG3izmbMrWlzMknnlXfFCfVmQUTPxyBL8wPausJQwb0ex3LX7LHmlIDOoAj4DGU/jO2D
         JIw3AOY46MXB2pAwxHe9KTHasmirKKpfcor9EujINNXuddZ6S7gq7Z/WZGhKxGbaAbQV
         bFJNOALI3xpytZ/zfbFe6MZsQkxHJ5TIq22KpPQaBeDcQz/F0BmNfQLW4YKIEVyoRNlt
         XUbQ==
X-Gm-Message-State: APjAAAUhZvemjl/9uaUHEPa6X8u4KaoEbfPbLGvTS/wQbnVh1oImNZKC
        QtqJIo73750JLBg0Brgbl0I=
X-Google-Smtp-Source: APXvYqxKTXyXw8x88UZWSvgU+HFqZOpKDpTMIdFsidLyKViZJXnF+9Zf2HHVg3PGoJgWwsFnpO7yqw==
X-Received: by 2002:a50:8a9d:: with SMTP id j29mr4740213edj.283.1569592151123;
        Fri, 27 Sep 2019 06:49:11 -0700 (PDT)
Received: from seamus.lan ([2001:985:d55d:0:6257:18ff:fe75:6e8f])
        by smtp.gmail.com with ESMTPSA id 30sm543468edr.78.2019.09.27.06.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:49:10 -0700 (PDT)
Date:   Fri, 27 Sep 2019 15:49:08 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
Message-ID: <20190927134908.GB22281@seamus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20190927075507.GA20555@seamus.lan>
 <0fb7bf1f-f13b-3bec-7b91-53460dfbe265@tycho.nsa.gov>
 <20190927130805.GA22281@seamus.lan>
 <1aefe0bf-ab82-3b41-7f49-5a540ab8f7f9@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <1aefe0bf-ab82-3b41-7f49-5a540ab8f7f9@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 09:33:06AM -0400, Stephen Smalley wrote:
> On 9/27/19 9:08 AM, Dominick Grift wrote:
> > On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley wrote:
> > > On 9/27/19 3:55 AM, Dominick Grift wrote:
> > > > sudo does not reset the role of my tty properly [1], and i was wond=
ering if anyone is able to determine what is causing this [2]
> > > >=20
> > > > [1] https://bugzilla.sudo.ws/show_bug.cgi?id=3D898
> > > > [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
> > >=20
> > > Are you sure sudo is calling selinux_restore_tty()?
> > >=20
> > >=20
> >=20
> > running sudo with:
> >=20
> > Debug sudo /var/log/sudo_debug all@debug
> > Debug sudoers.so /var/log/sudo_debug all@debug
> >=20
> > Yields:
> >=20
> > grep selinux /var/log/sudo_debug
> > Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @ ../../../lib/util/k=
ey_val.c:61 :=3D selinux_role=3Dsysadm.role
> > Sep 27 15:06:29 sudo[3417]     7: selinux_role=3Dsysadm.role
> > Sep 27 15:06:29 sudo[3447] -> selinux_setup @ ../../src/selinux.c:349
> > Sep 27 15:06:29 sudo[3447] -> get_exec_context @ ../../src/selinux.c:274
> > Sep 27 15:06:29 sudo[3447] <- get_exec_context @ ../../src/selinux.c:32=
8 :=3D 0x564eed3621b0
> > Sep 27 15:06:29 sudo[3447] -> relabel_tty @ ../../src/selinux.c:160
> > Sep 27 15:06:29 sudo[3447] <- relabel_tty @ ../../src/selinux.c:253 :=
=3D 0
> > Sep 27 15:06:29 sudo[3447] -> audit_role_change @ ../../src/selinux.c:76
> > Sep 27 15:06:29 sudo[3447] <- audit_role_change @ ../../src/selinux.c:9=
8 :=3D 6
> > Sep 27 15:06:29 sudo[3447] <- selinux_setup @ ../../src/selinux.c:395 :=
=3D 0
> > Sep 27 15:06:29 sudo[3447] -> selinux_execve @ ../../src/selinux.c:405
> > Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @ ../../src/selinux.c=
:114
> > Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @ ../../src/selinux.c=
:142 :=3D 0
>=20
> Ok, so you entered and exited selinux_restore_tty() without error. No
> warning messages of any kind in any of the sudo logs? Not sure where
> sudo_warn() and sudo_warnx() messages go.

No warnings or any other clues. I guess it must be this then:

    if (se_state.ttyfd =3D=3D -1 || se_state.new_tty_context =3D=3D NULL)
	goto skip_relabel;

>=20
> selinux_restore_tty() does a goto skip_relabel in multiple cases:
> - if there was no tty (ttyfd =3D=3D -1),
> - if we didn't set a new tty context (new_tty_context),
> - if the context on the tty was changed from the value set by sudo
> (strcmp...) e.g. some other process changed it in the interim, but this
> should have logged a warning,
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2OE08ACgkQJXSOVTf5
R2nErgv8DIjZgHfzOE+wE5Lm6vohYhLMY8SgpBSzi2Al+F5wzWYQHnjoKcHKNGB1
fHQOZRuVSy7hptksDz5kfHI6vY/YMBz9NBni8Xcm/ayKNX+SkcomWdmKb6GvvRc4
XVBkOM95DDo/N+0QxQ//oajVG9wyisBMk906MNvpkLWeafkG/9f2HiFrglISRjYT
g1Q70x9BF9FJpys3F4tVUF14/Ql+mTsZewW4D9+rewlEKhlNQM/X656KJFmfiM/T
hrlywhjjS2WwdEJZSDj5myXMcdG3V80XTHcCrxgR0U9jGwnejB4W0u9eSRyLy/L1
uu7VxpFKF+WtvahI1oIC/ehPR7mIYNNicXiZe0PtlrfwjVkgTTlsvx+xSFcHlR7V
U5EyZC424B92qQbli5+5T7cr9scW/K1ombpxkJKwDDnUlYGGL/mjuYPR+JVpHtk2
QSZuy20v/TUYzgbXCWvOtv06fsuIJEUSenC8+gFUXlMOL9iJzIyELVXx+IZcEJrf
cfcFPAG3
=1AkN
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
