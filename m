Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF9C636CC
	for <selinux@archiver.kernel.org>; Sat, 11 Feb 2023 06:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjBKGuJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Feb 2023 01:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKGuH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Feb 2023 01:50:07 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EA6728A4
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 22:50:06 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v3so5175557pgh.4
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 22:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihElxdHNVmEutZASxlLDtBHl7GsKLCp+K41w5WHSSU4=;
        b=6Ibo4KH58OEOwcNopcMEWTtylEwpUTLvtlxu0e6ZIVYFKhK2YUdNna9TzSKmHgTjaQ
         3zkJlsqF+aVE17rPP2w7H+W0vh7Jr2wjrJNP+6dheRXHi/HNr4W/OYeVbL4Q3m96yRxV
         n/8JvVLZ9H5wV2WninwS4F1h3UUzDR3qG27Cq54LC/e5aReiPyBUvm+TuD+T9ZYcqOk+
         EZWiIXFv+DrzWx21Apxq4yRFKWEjGJix5ktIkvYJHMJnvOU7x1EMQtOLT0pIThtyx23S
         fqJYifn5Mpg7Nq9dsgr+Z/DFzVnm2E781ggrlmyaWR6P5Lmvjcs+Sv1u5j6kZ1lTktP/
         S4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihElxdHNVmEutZASxlLDtBHl7GsKLCp+K41w5WHSSU4=;
        b=uqTyq/0TLWUc4X59d+fxwHXLdWnrAC41uUIIZfryDq9HCN+1C7V7Dox7i0lPVFxzfE
         HdlDe7eNB5SnaCTaCNEtOfyyTSja6vl1RGQvOWF5D0qpQ7JRLUL2NvQCODnC9vEtPj63
         cJlO0NUI1tsJiN3o+4hy+gwkdMRB8XKkfQkvSSIyvXVO4OTSKQDDn98tavdePVS1WFkL
         tmhp3W5LZtLzTV2lfCKsZpdtIVr1w0Kif9swpV4zQ9PlxBuDotyrKPbKvgJlONRdM9fk
         11VDZkgj2pGO9OKImJb4p6qclLSb4Atv7DAk3QEwUX3/cpUOV22pA/mNUxMOngf0frzu
         uBmw==
X-Gm-Message-State: AO0yUKWdg/oz7Waq/Kl2LYqmubBrmO9KsUIwmLqv6vBk444Z7PWuSDqJ
        JiBbPDAccF4smAdPKea/Gi61rp6q1U5OaWqvPIM=
X-Google-Smtp-Source: AK7set+IBvh8NTIUYOj6PPx2Z6bo60Lv6+opUYcD0f9J/6Zoa0Cqxs5mo9HVJB0qMOTI4Qp6Sp+2Ow==
X-Received: by 2002:a62:198d:0:b0:5a7:a688:cd89 with SMTP id 135-20020a62198d000000b005a7a688cd89mr6205720pfz.5.1676098205365;
        Fri, 10 Feb 2023 22:50:05 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id v9-20020a62a509000000b005941ff79428sm4320948pfm.90.2023.02.10.22.50.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 22:50:04 -0800 (PST)
Date:   Fri, 10 Feb 2023 22:50:03 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.5-rc3 release
Message-ID: <Y+c6m2JbQuK4oVtt@anduin.perfinion.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/bSRlMhnbzcLGUmv"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--/bSRlMhnbzcLGUmv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

The 3.5-rc3 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/perfinion.gpg

Thanks to all the contributors, reviewers, testers and reporters!

With Kind Regards,
Jason Zaman


User-visible changes
--------------------

* libselinux: add getpidprevcon()

* libselinux: restorecon hashtable and other misc fixes

* sepolicy: Cache queries to speed up manpage generation

* mcstrans: preserve runtime directory

* Many updated translations

* Build optimizations and other bug fixes

Development-relevant changes
----------------------------

* ci: Run on Python3.11 and drop py3.5, py3.6

Shortlog of the changes since 3.5-rc2 release
---------------------------------------------

Christian G=F6ttsche (6):
      mcstrans: preserve runtime directory
      libselinux: drop obsolete optimization flag
      libselinux: restore: misc tweaks
      libselinux: restore: use fixed sized integer for hash index
      libselinux: add getpidprevcon
      libselinux: getcon.3: add note about PID races

Jason Zaman (2):
      ci: bump to python 3.11 in GitHub Actions
      Update VERSIONs to 3.5-rc3 for release.

Petr Lautrbach (1):
      Update translations

Vit Mojzis (1):
      python/sepolicy: Cache conditional rule queries


--/bSRlMhnbzcLGUmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEE4WLerRzN0RPwSz1JK77Zyxpo71UFAmPnOppfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEUx
NjJERUFEMUNDREQxMTNGMDRCM0Q0OTJCQkVEOUNCMUE2OEVGNTUACgkQK77Zyxpo
71XY1hAAnqDQklLGW8yAkAcFfLY7uzTr8yQyHLHvUqGJ9OOfV9FC2rTjF9HyjUGa
ejg3KMTRAeM4gPZzmjwY5itvFiHkCWywYzYr31G7ZFM4mVyf8lzqBPvVq4FX/oJg
Ri0ul4bqrMMpckZ5aVR1i4BPj9l78nC7YrtTrOPnBHDbCKSrtmL2X4rWbX8X+cRI
4F8GUq5FOAWlJ9wVrVhMbN743R1pK5FKMDZv7e0KcEMqu4YNEz9iz5z+CpfBQk8h
kb2FALKXcw5MR5BWw2yzDpfJIzw2balUtBcS3h0eYSNyfvCBmA5cYQj0pCqfXVfW
axlZOL4lMydyVVtkhpKCx/oRkhPMNKyWnJWvnXr0lq1pDX0SzRJZwjiQBctHhkt/
EYbExwIlbeA97Ljb+BK/K6BOIZXDUE/pbJKG26Frte7coX3OX0zkEE5B09QehYfk
EQ5yX0k2e4xv5WAM5z7fmRNMNzc37prPgxJJiQ7AcilyDx/MLJLQ7ps1AXJy/sov
wXNpiTov1S7gyveRnlWz+8DUDf/xEUouixuDmEowii2Ur2mvVFUaWZie6e8ZtZA3
SdU21lzaLB36gWZNzgcEFQ5sDjtRB0EjNN0R5KOchextpa4ipBaSGMiI/dXukMlX
0f5DNsDzrXD3JdWmkwYqhlMx8kuPxA6HPfpBWUm7eStNZBTur+I=
=dPhL
-----END PGP SIGNATURE-----

--/bSRlMhnbzcLGUmv--
