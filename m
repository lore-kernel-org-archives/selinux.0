Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C773C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 07:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3192075D
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 07:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4VkvLQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfI0HzM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:55:12 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38905 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfI0HzM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 03:55:12 -0400
Received: by mail-ed1-f51.google.com with SMTP id l21so1515137edr.5
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=wrnm/74VUeNcmtOnWa1DD5GyU6RgH24RKV2RjBLZARg=;
        b=W4VkvLQ4HR8WkKEVU9ESw/4s2L5Yis+z2YAtwKGf8MsXx9BiWf7gEKYffeU6LNBw/6
         0dXf9mJKs0MTng/VaLsg3RY1g91y3hBe3PDIpvkHbUh87joyuB5NJXZQrkXyBb79iKHq
         qS5JuTL5EPLdHrBIBJQ3lcWi76cywlyFSash+rrJljIzpNs6/l+/rrS7GUxmp0OIoyaR
         nUwu8zR+06HbC4eynthESbX+oM8c4VOv+jm1Cnp0BmnBvwN1P2aLsBRLTdayU2gz8hpn
         A33J3ro7n7SQZUULLyrtkQ/r4PEJl6+NB/lrCfQGiMhejn0tAqejUxyO8spEBQcClrX1
         l2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=wrnm/74VUeNcmtOnWa1DD5GyU6RgH24RKV2RjBLZARg=;
        b=jc0djXrHkqiSC7pL2bnCjT/KtODtasPD+jYSOgbuPo+/5SMpOjhKbho4jKutr20Omu
         JIJFKjV1Oyy1yEp4Ru0Kv89j0A5qwEkCxB7YZnW8jj745Por/JYlI1Vc2obOCNnnJkWb
         oP/XroHXfKHJAHoB3rdXxhJKXS9Gewd5SxAnq8EZ/rROGHLLMqJ4y3vh8HymQDHbJcDr
         lno05dzwHb/dGp7M9hsQ9PJ5Grlf87F7rpVwbDhbCST/epGPwqWBzVuj94GJ2TBE7Crf
         Gh8pHe4yHWEitJftZ1XIqfVtPEBnIfFE7aTlFHjtaVve6ziW24++7JM+fjNLFSseNNFN
         B6sw==
X-Gm-Message-State: APjAAAWosUjlIsoZm8fjvPDIKCd8loNZYPP+RXSIeA6DnjgaFQsXQKA7
        doorotUGIK/j3W0jJEBu2YNeEY/c
X-Google-Smtp-Source: APXvYqwEJBYZATuufg56AEcAUkJuK9fG8NmIDvsiO+Z9Lnq9Ecwo66aDk1uCKYGQ+y8LBU6vbYISKA==
X-Received: by 2002:a50:b582:: with SMTP id a2mr3072478ede.98.1569570910601;
        Fri, 27 Sep 2019 00:55:10 -0700 (PDT)
Received: from seamus.lan ([2001:985:d55d:0:6257:18ff:fe75:6e8f])
        by smtp.gmail.com with ESMTPSA id z20sm358478edb.3.2019.09.27.00.55.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 00:55:09 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:55:07 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Subject: question about selinux_restore_tty() in sudo's selinux.c
Message-ID: <20190927075507.GA20555@seamus.lan>
Mail-Followup-To: selinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

sudo does not reset the role of my tty properly [1], and i was wondering if=
 anyone is able to determine what is causing this [2]

[1] https://bugzilla.sudo.ws/show_bug.cgi?id=3D898
[2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2NwFcACgkQJXSOVTf5
R2m9BAv8CWRcP8nacCXF4oNSMtugIZKCVB4nMI44l7moxrpvQtgwogy121/W7nCq
xHDR6qHVpSeF90nLyO+hp4hat0ZnNHGVSZMYV70rMp1VI11/0c1sns/IJ+dQTvWz
ZFuUqmEPF9OjpsRxKwc6xIwEs5cTp9EduPh8sMupbcglCZ05Eb5tVmWAwfg2ymbI
S181W+jzO0EN/RI+ozCzk6poRdLVtIfLw30+zykknsiu9eS9WQ+qgu81h7LTQsh/
QvhlwLSWdGjpcPM2AFRdWVlr9941rsrvBDJTg6Ne7muwdfTfJzMzZlO4bEkZUfh7
QepKwwV2MPsG/EZaI9My+4j+ICuZGGKAfWr+cQIF5smBr9NTuehAA2C6WPRywjCR
M6jRGiHXY9oP2IGdYWWamNhcw5gRG1IODDlhgslABOAlBfxCxIy13zcsgu/SI39A
IjrRRY4jxIk3NJ25p/N9/GrMuVO5hrRgLI4L3+C98iNTvA2E9i7yRtkJs9ozdftc
3F0KNQB8
=MWUQ
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
