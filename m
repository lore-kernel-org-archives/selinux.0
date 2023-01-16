Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCAAC54EBE
	for <selinux@archiver.kernel.org>; Mon, 16 Jan 2023 03:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjAPDkq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 15 Jan 2023 22:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjAPDkp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 15 Jan 2023 22:40:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AF030FB
        for <selinux@vger.kernel.org>; Sun, 15 Jan 2023 19:40:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so32590697pjk.3
        for <selinux@vger.kernel.org>; Sun, 15 Jan 2023 19:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PnN2WvekRzTIZL7+ijyn98LpgDDWvz84PA7SOaj9Y8=;
        b=hvNNsQ8UvwpSEQ6As97QiqxySIa8M8lYa1qe7XnbTQa6hgpxhIG7+vyCJzEurmkUFp
         aEyHUcb92jflA8wiOjKONoEXIVE2LNAXRIv+X0XV8xEFia6ag+PFiNKdXv65onHWA11d
         xk0P+zqF+6knur6tT7Q8SZ/kNP8hfx+JDE3/QAmOpbNkofcfM4ZukCVI0DW6I1o5Mxyz
         5RkdMwXM/bJ/nmiaMF+8jagQwpKwofefGSn1V6cLiQ+kmxih8BIx5+huO9lraW9V5wH7
         DspsrjNiXMBNAo91fn6nPK7J3RVEOLj55tJr3I9H85YbE6GgxIUMU09+iPSwHhG2038S
         tJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PnN2WvekRzTIZL7+ijyn98LpgDDWvz84PA7SOaj9Y8=;
        b=59okBzSolzIF1UpmDFwd97gbHHhJRQrU48AVD7MrZuR3yyR9Z4dlID3idY4dWOj8ta
         9cCIWKJt6VND/ROrnpUm73ZBXknb5p5FRldw7GefdBLmw7XDeWPOMURxsbAKTB0CUzNo
         H9LWfOscvAD+5HX0lRzx/9KQwfRjOw2O3SPtRyKsykkSUA/4uYWbAo023kHcJPmkcqPl
         OooszJ8YM+EJq+ci6SZQSrI4Wfu7VSg2/JbDHNC1VRqKPyFcOJ4XF0D0NazSoWaNngxt
         mRjHi6kDVXVe74Iqt83zWA89M5nmXwxXLauLgOPX5IDQFZi/pBzLyGtBO2Pc9GL4e9L9
         P0Yw==
X-Gm-Message-State: AFqh2kqafHtdaYDkfApuDYjIeWRMJovh8wkz/kY3F48NMAY/ub4Yr3O6
        LqH6Y3ygXyT5JKcdY5Q6qeGwojBHP0k7V9WphYo=
X-Google-Smtp-Source: AMrXdXu0xD09AtrbIzLidZle8lJrD+5zqmxivCYs8On7pJc2kZFQv71c8SPheAY+xtlnZX3Y57JJKQ==
X-Received: by 2002:a17:90a:17ee:b0:229:2962:b7db with SMTP id q101-20020a17090a17ee00b002292962b7dbmr10617489pja.45.1673840443255;
        Sun, 15 Jan 2023 19:40:43 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id co9-20020a17090afe8900b001ef8ab65052sm15870128pjb.11.2023.01.15.19.40.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 19:40:42 -0800 (PST)
Date:   Sun, 15 Jan 2023 19:40:41 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.5-rc2 release
Message-ID: <Y8THOQeP7houyxmv@anduin.perfinion.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lphd7xozGHAjWu6F"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--lphd7xozGHAjWu6F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

The 3.5-rc2 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/perfinion.gpg

Thanks to all the contributors, reviewers, testers and reporters!

With Kind Regards,
Jason Zaman

User-visible changes
--------------------

* libselinux: Add workaround to reduce pcre2 heap memory usage

* sepolicy: Add missing booleans to man pages

* libsepol: reject attributes in type av rules for kernel policies

* libsepol: do not write empty class definitions to allow simpler round-trip
  tests

* Translation updated for generated descriptions

* Lots of code and spelling issues fixed

* Bug fixes

Shortlog of the changes since 3.4 release
-----------------------------------------

Christian G=F6ttsche (3):
      libsepol: reject attributes in type av rules for kernel policies
      Correct misc typos
      libsepol: do not write empty class definitions

Inseob Kim (1):
      libselinux: Workaround for heap overhead of pcre

Jason Zaman (1):
      Update VERSIONs to 3.5-rc2 for release.

Jie Lu (1):
      policycoreutils: fix potential NULL reference in load_checks

Petr Lautrbach (1):
      sepolicy: Make generated boolean descriptions translatable

Vit Mojzis (1):
      python/sepolicy: add missing booleans to man pages

kkz (1):
      sepolicy: fix a spelling mistake

lujiev (1):
      checkpolicy: delete invalid spaces

--lphd7xozGHAjWu6F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEE4WLerRzN0RPwSz1JK77Zyxpo71UFAmPExzhfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEUx
NjJERUFEMUNDREQxMTNGMDRCM0Q0OTJCQkVEOUNCMUE2OEVGNTUACgkQK77Zyxpo
71XSeRAAkakhdqyOgThJEoKh1pzJO7lEVSkYFXmUukGH0Gu5bkTfEPv2javrOs9S
8gxUQOp7CyiYnT4WAlvDxC0Pgo3e7ARMd145VSjI5nVfxoUTHNomdI0QaaFl93JX
qVc+6k+eg/jFuCWCeGqKuzc23OqkcQtWeCn6ZIdaBdIrHItR+qWAi7kik40G/1r8
FBFcGDpm5f1nV9U4zaN7ABQunUBpcYnIkQ/M+eBm3BSlpSvef9pJ9f73tcIwUCD6
L+oR6IY7I3KcXl9kRf1+ymaeMu/FpmutLZy8bn2/zKgUNTT7ZLrnBsHdb1eIClYF
z+2Bdy/fxFOgU0mb87RcOZWQMoKdKe2EUDhVpst9hMhf48lBlQTiK65s+JICBHff
neMd+wICHZ/Nm8RVAb7wVp/lNn4j0LDSoMmJzrRhnpFe6ikGlU/SJxx33ByOZUGf
vFH0xaVCMsdZ8G4libHlyvYmTEMyZ3igGwT/Xdr54ZQfwdi/F3r22OCKTVWhIv/w
a9HgMB2mkLLnEdHKiJpUa/BtjjTMsc6+Mwp5IaCnokbSaQ+v9Qn3Ru0Na9QDYwhU
wjOLHF97+gtBI8fvMNSOmUNMGkYQjUUqcbsJRq6c+PWyv4ky1sAMEGcPrmf+gts2
OrdJZ4mfNdKQEY2AL/TyJ+3mfLBOHBdhTbKeRUBEy+/c9OEUQRg=
=dvB7
-----END PGP SIGNATURE-----

--lphd7xozGHAjWu6F--
