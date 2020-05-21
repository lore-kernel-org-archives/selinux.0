Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E9FC433E0
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5763020759
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 17:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrd9iUzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgEURQc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 13:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgEURQb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 13:16:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A3CC061A0E
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 10:16:31 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z18so6115279qto.2
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGzhS5oHbYZXgMdjt0B1Vm3pRK4m51r8PvFWkSJnUl8=;
        b=nrd9iUzEh74B6Txs9+e2v2pO/hoG4MH//Sx5pDtdp7EpVmS/99PNZT1OoXzJlbKeE1
         sv7CzD1RG4PKt97WTs/775Un3wuAzOvEA73/Vn2Te94OhWbI6+vDgaN0WpD1xcruEAZK
         2NcMf0INWV/gSYUMfkwxxYttyv9tty413XL9ZrgygvvmUfntMg1mMp8oS2Wsv1c9GyrE
         ro3oV3x+BZ0QdlwYskDdAykq6VN6pOORG79cUX234e5Cu+40rQmAq1op1Q3Dg3wharkt
         ibVfmLtUTXl+VqSBQacUDog5hrpuUxVy58JC9iIfqqTAC/xrqNSGGFdxGLAfas1fs802
         Mfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oGzhS5oHbYZXgMdjt0B1Vm3pRK4m51r8PvFWkSJnUl8=;
        b=Ox6epD/ZQP2usM+NeGYZ9oQ2JDD6g5vzSV+H4L2JDDTJfAseMqb6BnAUYDrhWtvU2B
         OpHSqkziwt5hHVzg/EvBWwMlv3jmyWbn1UYxGAzPtDyOHfV3J6gFbA+O2UlBsmy3nG0Z
         Zra0uSxNsd93J3p16a90rhVW7nRr+Sx9NGJ0FPJX4RYqm6CdW916v8FWuJ/s2IEN+ceE
         XQRHhqb4Vp/ytdTNUE6dZOAZ4UnDd/IN7Bsh+M7Lr34VLkrSgU1VeKIRlBJAU6Kk+jE0
         lFyi+/snBVziOWMPNEKkFen5caIMhUK1Jmy2wMKDi1CPTlBU7V6H93jIEAOqQzb664hs
         zfGg==
X-Gm-Message-State: AOAM5320J+pscaalNKai+tuGt17GjjL+thm8PpRBJoI0Ke2E/MFLohpx
        dHCH17tzkXhKwkPz1Bilw+/CCxs6its=
X-Google-Smtp-Source: ABdhPJxflnyhnvX3DVP1Ub1JR5SB4L37/xym/YsZCr48Y7WOVS26+pSbgY5z70l36sP8EpkEZ66LpA==
X-Received: by 2002:ac8:3609:: with SMTP id m9mr11807092qtb.107.1590081390097;
        Thu, 21 May 2020 10:16:30 -0700 (PDT)
Received: from nyx (pool-100-15-227-192.washdc.fios.verizon.net. [100.15.227.192])
        by smtp.gmail.com with ESMTPSA id j36sm5928817qta.71.2020.05.21.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:16:29 -0700 (PDT)
Date:   Thu, 21 May 2020 13:16:27 -0400
From:   Paul Tagliamonte <paultag@debian.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: Documentation on Enabling NetLabel
Message-ID: <20200521171627.GA326433@nyx>
References: <20200520165322.GA225268@nyx>
 <CAHC9VhQUYVmsXgXUqi6CUa2Np68-PajDkzd7BsDGk7kxLz+Uiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CAHC9VhQUYVmsXgXUqi6CUa2Np68-PajDkzd7BsDGk7kxLz+Uiw@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 02:39:49PM -0400, Paul Moore wrote:
> Presumably it works when you are in permissive mode but fails when you
> are in enforcing mode, or does it fail in permissive too?

That's correct, everything seems A-OK in permissive mode, and starts to
get denied (likely correctly) in enforcing mode.

> If it works in permissive mode but you aren't seeing any AVC failures,
> you may want to try removing the dontaudit rules from the policy.  You
> can do that via 'semodule -DB' (the semodule(8) manpage has some
> examples).

Just tried that, thank you for the suggestion! I don't see any
additional logging, but I'm going to follow up more comprehensively
after reading the documentation. I'll give this a stronger go tonight.

> You may find that in the near term you need something like Fedora's
> unlabelednet policy module which blanket allows unlabeled network
> traffic to all the domains on the system.

Ah! This makes _so much_ sense. I was wondering where rules defining
this behavior lived. Looks like it's a (very comprenstive?) RH specific
changeset that we don't carry in Debian. I've got some work cut out for
me from the looks of it.

I started to graft sections I thought were relevent from policy-rhel-7.2-ba=
se.patch
into my local policies, but I think I'm super in over my head. This is
likely going to take me some time to work through, but it's monumentally
helpful. I was only looking at the upstream rules and our package, which
explains why I was missing a lot of this.

I assume since this is being maintained by a lot of folks working
upstream too which makes me suspect this is a WONTFIX situation
with the upstream rules. Seems like I ought to tread lightly here.

> It's not clear which interface you sniffed, was it the loopback
> interface?=20

I was sniffing from the VM Host (a laptop) to see what was coming in/out
of the network when I tried to initiate an SSH connection from the LAN
to the VM, since that *should* be unlabeled and pass through (although
given the bit above about the default unlabeled rules, it's likely
getting filtered out).

I was trying to minimally set up labeling for localhost (without
impacting the LAN NIC) to make a baby step in enabling NetLabel with
enforcement on, and still allowing network I/O except where I was
placing specific rules in place.

> That is the only interface which should be doing any
> explicit labeling; if you see CIPSO IP options on non-loopback
> interfaces something is wrong.  I would also expect you to see CIPSO
> options on the loopback traffic, do you?

I believe so, but I wasn't sniffing inside the VM because my SELinux
rules need to be fixed :)

It certently works in permissive mode, and I'd expect it works in
enforcing mode, but it's tough to tell right now. I'll see if I can put
a rule in place to start up a getpeercon daemon and see what it says.

> As an aside, Wireshark does know how to parse CIPSO options so you
> should be able to peek at them that way; although Wireshark does not
> know about the "local" tag type we use on loopback (... and it
> shouldn't, it's a horrible abuse of CIPSO, done intentionally <g>).

Roger that :)

> Try removing the dontaudit rules (above) and see if that helps with
> the AVCs.  Let us know what you find.

Will do, I'll dig deeper, and come back with something a bit more
specific. I think between that and the unlabelednet module, I've got
some debugging to do.


   paultag

--=20
 .''`.  Paul Tagliamonte <paultag@debian.org>
: :'  : Proud Debian Developer
`. `'`  4096R / FEF2 EB20 16E6 A856 B98C E820 2DCD 6B5D E858 ADF3
 `-     http://people.debian.org/~paultag

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEt+z0Ld/ZiscwHAYrEQGtWoE2mtcFAl7Gt2gACgkQEQGtWoE2
mtd+jA//Y0OWUN9ycxdxsAcwwmLoxzxREp9RERHKL221mWAi9NrPtiPtveSemYvi
u1zA5RKEnUQF771KflP0y1h6K4cxNRmOhCmQqOMTOg5U1HYuEQ7ZcH0X1hdd9Kz8
iUpEpEeg9Nseuc6sa2jw+ywloLO4AB/F+VEwwj/sbQymo76DIvQKc47Vn4Mf+iQd
tQ1h18CwPT1ryPSTf27IK+rE3N1AhOydaElJKVRlceXMsqG8LKk4Aw75B2IZdhdP
u+5YH6pV7/IrOm6qvsxfvj4nBr6Erm1KWf5JCVXAOrVRNlJUTDurM/aiUkytXMvB
hoCuMLgHDj4V01BaJLx4NBUbeEN4NxM/7SA5iG3tvOKmjA8jdXwR+YS6banq2UpI
M/h/chdBmCCQyj2pPe1Y44WS2NNnosg8F6BwebXpV7xILWpm/cfnISsbhmINdPhD
DJZ+rU9IhLBmqnohWpzC4GX29NLSGj+5VJGo/C1a1pUpTKHjnM1DAHQnpY4DSbMH
rp/Yt00eglq4EkY4L71Ce9FP3Pu27AzEf+FkylxZbobSL0dow8rIm4sHykq/44qU
a6VhP6V1kj2o49AUXl/ltswcMMa2EuFyXTnpxJdNm66RPIM1kn+1S+LCoIQBan9I
iieftPxnQptkXbS++frmc1h+8k5d8M3T7Jz1mtAZOYHdXoPVeV8=
=JWFh
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
