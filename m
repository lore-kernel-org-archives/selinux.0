Return-Path: <SRS0=kO0s=ZM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7214AC432C0
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47311206EC
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoQW8VeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfKTQJD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:09:03 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39202 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfKTQJD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Nov 2019 11:09:03 -0500
Received: by mail-wr1-f46.google.com with SMTP id l7so455750wrp.6
        for <selinux@vger.kernel.org>; Wed, 20 Nov 2019 08:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=J+NXs07Gtht8r79b/S/5GFrPYmbMyAd/JqBSTkOlEiA=;
        b=BoQW8VeF32AQz+UaYGF5cwUS1j1M/cF76c++5AZt7pgSADPQFtQujsPn0VGu4m+0/m
         bu0oGdba2chBpyF/G+P61BWZC4sfLjZPI4bKMw3SU/BmX2QAIgVKDXLhfJXfNF3hbMBr
         1wCBtIlxy26qR4Y/lDYWW1lZk0fHJllPHy3m0t7GhwiWD1m0pT+FWWIESlWBgivinkQt
         JJOTcokPM3SBANkixcqMw04x9I3ryf540I1hVgMqYA4mF8tqxEw0W+1shTcqfmRpwigu
         FAmsl6NbG/1TKOwjr13YXJd/RLdOlNm5mq3OiNMPy0XpXB47bsalXqrRV/pfiLzYxqPI
         uElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=J+NXs07Gtht8r79b/S/5GFrPYmbMyAd/JqBSTkOlEiA=;
        b=l40aDTHgShvsCYrJ1PnYQKRgHwneEZoLGJAZZIC72QHZrdBGL4eklVdJG4Pie9oJOL
         I9a8f+jR6auSxagsudoqasbVxSJeJ1AGMSglJ2WFJGIqnyfgHFvJs3FG30as8luLBivn
         AbpGuqHjWiKBcDhLPvrPrbrRMXyjY8riIZeuOiJqCO/ss/Ji3xqRIbifV8RJax30Nbc9
         mnKe/nikxFuSkes7gyld7tciU0ofZgFrmnQdO851PoiEq2GYPt5Y+GtMx6E0giq9NnxV
         EPDQRzl3W0/8duHYYHDn0zEtBuAIdQLmO+z1+fJGgqJ7hyMUiaxsuiK2AaS0Uq0GLamr
         a8kA==
X-Gm-Message-State: APjAAAV6qDjF8ZRK7XTNwECr8O+Ud2Pp9KCf+N4Bpu77BEEA7Th1WPZ0
        S8mEm5fZp6lGxVSm8RWuS6Q91PRN
X-Google-Smtp-Source: APXvYqzV14zz1fUKM5Sz9yeAjKL1N90xT5YjfZG+Nk3TRvFTHIqk+q0KuMTSGDSijh8TnWLn7AV3KA==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr4440948wrt.142.1574266141420;
        Wed, 20 Nov 2019 08:09:01 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id d7sm32233924wrx.11.2019.11.20.08.08.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:09:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:08:58 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Subject: RFC:
 https://github.com/SELinuxProject/selinux/issues/140#issuecomment-556049712
Message-ID: <20191120160858.GA1624071@brutus.lan>
Mail-Followup-To: selinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was reminded of issue in topic.

"userprefix" functionality has been removed from reference policy since 200=
8, in favor of "rbacsep role".

I am currently the only (known) user of "rbacsep role".

I guess the CIL "userprefix" statement would probably have to be renamed to=
 something like "rbacsep_role", and the -P/--prefix to something more accur=
ate (any naming suggestions?)

Am I overlooking some other visible/exposed references to this deprecated "=
userprefix" functionality?

As the only user of this functionality (although I am not a user of semanag=
e) I feel obliged to some how try to address this.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3VZRMACgkQJXSOVTf5
R2nDggv9ELpgwljERtEYPemPyDWFVL6xnSZbTzilPOLylP134rz+ZXuzICV7uz2S
mIrWd2l5LHK9cWH6fdymWhm4nhn9++o89uJJhZSpI/HhpGfgyLDdTOI1zMC9X9PW
7/t9OKZ1qNdhHUCWLKFqHKB7K8gef3PV1469RHYZnHZSXSL2l506qJ9xRKpwvlNQ
yt8u7nYaiJzUM14I4b/y3x0iI2DFRgqav5V94w+sfEI6xaaAbQm2urILhd/yp4Vk
9N67zjKdG4oAgQKcUbjbc01TXn/LUyBGo+sRFtI82SHYbTN5/NWjgndmdo7QYIaV
H4cBDGYdg11iUVEiyIfsKn9StFWhqCUWbfpbtZxlPd8UeEDNfrW+Sy06HPXKf6om
70o2gAX0aIJvqsG8QITdYTj7ycpwv5lTbKbighi6JIOOw9DU7z9JBpwFmvmDDPeY
Z521FKP9TuDQv387rvdVW+eFEc1PgcTHvxr2BMHlNmo/+6B2ZV2Wg/A1RYtP+bEm
Gvp0OKql
=upjC
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
