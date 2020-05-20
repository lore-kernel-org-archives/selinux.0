Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CDFC433E0
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 16:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3A92065F
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 16:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMFAfQ7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgETQxZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETQxZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 12:53:25 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4D4C061A0E
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 09:53:25 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id v15so1650535qvr.8
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=3NmooF5NFuPaM175KKtJq4mHamIZ+huu4BuRUToPkBo=;
        b=QMFAfQ7s8dNLNRdGyibGsjIRMDhfgjN0GTqimMUtWVe/u0fdrbjrYrSBcWfzoudQ4L
         WHVeucUauifYnUzzDBH2MlmjPYTIL+NKQZXYIcG/jdiS6m7mSaybV3da61lo4db2nrvU
         kwExuoV1DHx81YGPjC2kDa/pnJQhkhTOCHx3EOItLqeGrBIC3NTOJTGds5tzlcy1to/q
         bAdF26RCwzyC5jne8aGuSWzqgjgpded9mSwynZ4XyQZx0Nba6b2Cy0qy0CtagKnW6k/5
         EObBgiLDWzoC3DEBHkHv9e29yvsJdn2od2RmlwYIjoI6GfxgpfARtK453L37wIOgUOy+
         HFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition;
        bh=3NmooF5NFuPaM175KKtJq4mHamIZ+huu4BuRUToPkBo=;
        b=ZF/qqRbCrrQQksKtB5eonLT7reW2IJxiKwHz6wrC3II55m9WjDOnoH4JhW4uDpoNIx
         R/Ikf4K4CffnB4RAOzw5eTugyj2R+kgLkX48+HMsiQRulfoKAKiQRJuMfH2/ZJ8rRUOt
         Q9h/sZr4XJzDdV5ytAWwS2IdGx+ZrLMJMufol+mOv+xILeX2yEMtoAuDlJnldElQYGEV
         FAYeA0hOfIgRojJdByH6pSZqLKC9d5990x3t4mSOh4kOwbeecS5P03V+jUgp5O/sktnD
         vyTvuZBzBP4OuOth7oQLIZRQLitcp9MqeWEs0SWfEHDRqzcUPuDyfUvR0WC5DJs/3pw5
         0evA==
X-Gm-Message-State: AOAM533dij05mm1UkzPqaKP758BcTFD0xwF5NpMbK4wy8gjsVclakNU1
        OIy76IrkakUfjU58lEqb/ql+u/rLTJk=
X-Google-Smtp-Source: ABdhPJw0gUDlcPb3tJABRAP1nMJB11ICfw9acPJJ2F6W1HUWGZFXSBV2whtR2fyHsRETeMBpOi0T5A==
X-Received: by 2002:ad4:4f87:: with SMTP id em7mr5448114qvb.192.1589993604301;
        Wed, 20 May 2020 09:53:24 -0700 (PDT)
Received: from nyx (pool-100-15-227-192.washdc.fios.verizon.net. [100.15.227.192])
        by smtp.gmail.com with ESMTPSA id w21sm3018324qtj.78.2020.05.20.09.53.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:53:23 -0700 (PDT)
Date:   Wed, 20 May 2020 12:53:22 -0400
From:   Paul Tagliamonte <paultag@debian.org>
To:     SElinux list <selinux@vger.kernel.org>
Subject: Documentation on Enabling NetLabel
Message-ID: <20200520165322.GA225268@nyx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey SELinux folks,

Sorry for the second email in no time, but I'm a bit stuck and could use
some pointers to continue my quest to get NetLabel working on a Debian
VM, and send patches to make it easier for others in the future :)

I have SELinux and MLS working (even to some degree whilst enforcing!)
in a VM, generally speaking. I can ssh in and do normal things. The
rules need a bit more love, but it's in a fine state that I'm happy
working from.

I've been able to set up NetLabel to attach a security connect to
connections (nice!) that show up when querying the peer context, but switch=
ing
=66rom permissive to `1` results in dropped traffic.

I'm sure this is likely the result of (correct!) filtering going on, and
because it's now gone from no context to a context, traffic is likely
getting filtered out. I don't see anything in audit2why in permissive
mode, but I also don't know if invalid network activity is logged.

I've tried tcpdump on the host, to no avail. I see packets going in, and
not much coming out. I've kept the kernel on the VM host on a version that
doesn't have NETLABEL enabled, in an effort to not have the host kernel get
in the way.

Specifically, I've tried:

```
netlabelctl cipsov4 add local doi:2
netlabelctl unlbl accept on

netlabelctl map del default
netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
netlabelctl map add default address:::/0 protocol:unlbl
netlabelctl map add default address:10.128.0.0/24 protocol:unlbl
netlabelctl map add default address:127.0.0.1 protocol:cipsov4,2
```


On localhost, I can't connect to any running daemons (such as SSH), and
I've specifically not added the NIC that is bridged to my LAN (in a maybe
misguided attempt to keep traffic from the LAN unmarked) to any netlabel
rules. I was also unable to connect to the OpenSSH server via the
network IP either.

When enforcing without running the above netlabel commands, I can ssh into =
the
box successfully.

Thanks for any help anyone can provide, and thank you all very much for
being so helpful for my last question!

    paultag

--=20
 .''`.  Paul Tagliamonte <paultag@debian.org>
: :'  : Proud Debian Developer
`. `'`  4096R / FEF2 EB20 16E6 A856 B98C E820 2DCD 6B5D E858 ADF3
 `-     http://people.debian.org/~paultag

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEt+z0Ld/ZiscwHAYrEQGtWoE2mtcFAl7FYH4ACgkQEQGtWoE2
mtcX0xAAhl+7IiboWzJf+P5apU6ZVWgiuBXYxrsGc2IxW0slvs30MPt1kUxG2MPk
GegP9rrMQlMIGeAzxigK29keyZGA+zX9hTH+jHm2YoyYu/abR9lKH+9rmkYSaj6t
ItG6Z51CvQvEZK/UVK+XLGaazSHGKcAOlaydkwoWLB1poFgvraxT4vU7HYqcenjX
syseoqNQlHFp3UcjIYFOTr8/c6BrhZbpgVnjpOvmBBTIA5ySBNMQIhzI9qZPOZe5
pv+uHup5nXQ/+1x+GkkP0WLAzQsF2GSR7M7pZkaZ7Zi2qFMnH+ylh2bV/y5b9z6I
MFKXeT7XgFPJiIaNntm25k6YWrtlZ3pDKZa6iB0gjW4vxzL0zqBElZWXBIlUKNhK
lyZFZHZLIRBZqZE5pCN3ElFGTNC3F1UTnMvZ2S8COG2oalJJxPGrVxc1OLbzbi93
S+56r3eZygiTeHzEitivn+uaMqqJ70wQhQFnKqFCVnpjstpqQ8+kOJVY8qKgec2A
xoyg3AD4z1ch7+EZpm9xwJqojAzEPPyYqEzKZzxQvlCQGmfSQk/GAWnpL7LPrpKZ
cfRBqfAnkuSlRv8p/ggKPRnrsr5YVgKyQtYn4TOzFJC3AN5LhqHvnqiXDb7JqLbl
Lbz/zVgHkiBgb7KZX3BeT003AAJlWAQJfyJ+ZNQOnUWjeHa5++k=
=BfCC
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
