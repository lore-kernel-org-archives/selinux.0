Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592704;
	b=ZSzl/2rsi6eFeBDv7BwYLY/KCrhaRnb2wUkfUpo5VfYZJWtP2q16QfX+DD7LsH7WUSpu
	 MQyyV0kN+lYGZh4pFjl+Rx8ECAKWbx3LBJZjKrYvmt7w28J0J/6o1ZeyuMjFaPG7DIbLS
	 Dv44lT+2UYPUboX5OUfkBJvzTGwlwlKaWK4DKe9CAlozmNG9Tv7YZmJjrCHJ6Kcc/jDu0
	 074+pDKgzJAigbqI4+le990BPJb8Y7H1EMLI0LUJbHDLdK/PT2oegbJyO5g1CrUnshn21
	 0l2inMS5kjHKRZHAmyD3WYUD+EKf33tIB8UTZUpRL25zm7uP5eU87VglCbzCrDd91Gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zWlhld2jCjLC++teHS9dMcnjJdJbSduV7gmt7hEljfg=;
	b=5ECnKdOqj/I4zAjVNhIjpbNq5rhV8XwZEsZpMrqyIeBAqZ9LJscGXalGTsRsfCcOpyBO
	 GV+KKPAUb9dGbMJdpjPOHzv0ocl0eiqAf4bHSLV/nrbPcE/wAeeesm07KxRXFFHHNMKUL
	 OtNdScjp36mm21J+AXx+DslYXJ8xlHsuwk25f5YGUcs3/rbqCt6iVhp26ya/Qq11FhPx5
	 PSGfpSqmeItll+QO9oEZuvwVtwvHMexApUj9G2nMGXGIwy/REs3QQsi9o4N+plwlKGe+9
	 9SLF/TYl8kH5yVAgTsu7GuiK3Px3R9qljlYtzRTe2yPJFPqj+Gp4dttGSA3d0gyuCgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NQADWO7O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE0606A31D
	for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 14:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94AE0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NQADWO7O
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-675617e81f9so678690d50.3
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 07:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592702; cv=none;
        d=google.com; s=arc-20260327;
        b=l8UCDlhb5TRvHYNFm+Yo7xF6f9qsng+xrEgHiFEVtcx2AOleKtfOOlLBNGMKco2MIC
         ghEvfkTOAe2Ajxb6oLJ9jO6mcRTyTUY+/j7F3csIU+lyOx4r3QgL1ll7ERb9O07p8Yk7
         AgNi0p0yzhANEEeJyx1/ILMQ7NFBxJFABpjXk1gin/GYP7a+u9GSjVFo3MGJUxC/Cuzg
         zgEB4Us2ZFiV1SzDsiElmOWQipo+/lQn+ip6d4beqMp07/LLpHVIwugEdonQyzRAoTSt
         WODpY0araJBxoK+9VT2axGeoayL2EVn7/k8M9aDNdTLOsyOa2ZFb4xLqg3Sh+AuAEjZ/
         TErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWlhld2jCjLC++teHS9dMcnjJdJbSduV7gmt7hEljfg=;
        fh=PvPsygu8J6KKMV3RJxkYbr4VnvzlGPzli5Ytfb5PsAw=;
        b=Jl086KZSVycUBMIIuuImFfh81e58ZTNh20PfS7y7MDRjTzwtKyQy1kJW/Y4UTns83M
         Jr0FzZYW97Ldvh8x+zOcT1EAOmDhQ6aTyfhv7ulgEV2aEy8/H2amfoLuyhUGPMLK5UfO
         AD4rSrzgNpGWXD8vNe6aLTV+dx2qkH19RfD1yy68p6+g5wI6o8RULxhO7LrVPCeEIgZ/
         7AOtd5qimCuVxCVWVRUefutmXjO8U4Bt5Mr87YYK2D5aGWEFIdcqdFWLnUBiUS/7jcU0
         uTggZAeZXL+RHHpj/Ru85WS4NIXfO8HrKZY/UavzYbOkbIZ2pbhNkl7ji1e4ywNc+QB8
         E/Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592702; x=1793197502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zWlhld2jCjLC++teHS9dMcnjJdJbSduV7gmt7hEljfg=;
        b=NQADWO7O6VD6FcCKC4KrMpjvJ/MffRqlQVW3uUJMCC/Mfk4URwRd1/sMqQFYTDcfSa
         pYqIe8DuCoCdk6GdrsGrnsv8LQ4jtNTYsVfT18AXeQx/Sm0BnDWeaK0n7hzoW1oWeBAF
         p/7MINJSYKKQnatoBUIS/qx6ZslytBNDqrfaxIPRqa6NijuuPx/R+H4tDW9+GtgudARS
         2IitPLZxXgJPzSIYQ0ddXxOthgGtb7JzLhgEZPvInuDbJEuu4hm9pc0gflPhkebTM2hy
         xFLk4pYMLf9M4IsysNNEBRHuOqYKpteAzGO638P3ssfRLjInNzRaz4RpQZpysqpT5t76
         DGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592702; x=1793197502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zWlhld2jCjLC++teHS9dMcnjJdJbSduV7gmt7hEljfg=;
        b=i72dGyoHqLq2EHlgVUqxDtMF9/7K9m+Fo4b5B1Duk0qY/6yQkSjt3nmyNJdJYuccmv
         KYdKJcfJGHTpP5DBvHtBAdUndvd8rnWaJFlduDp87VxS2fv8mSnSjJHvpW5dT7XfVOdx
         CGKkRK/RIaERr8jLYTfnp10VO5AzmThYSU577ANa8gjixIwO/j8qf7wrpQ1qmuPAgJEc
         CZS5o7P8DBjrpeMRGhiuijxqqHXrvLMqb4oRz4OGazV6nU2iqtMgoazhyQskEYNcd7p0
         ev2+iZOiT7J5HIQCUL5hTnTaYmqifU32nOcHuz17JpsNcbRlZccpqGoKZQ6pMCjTceWA
         WqMg==
X-Forwarded-Encrypted: i=1; AKwUvBwnVWDPpxFBg0x9+yIxnteFJQCFNlgBpog/XgAKbPkaONNaMh6fnPscgojlUs8wlWipfiZCeNxs@vger.kernel.org
X-Gm-Message-State: AFq9FYLELkfJqyRq4kl1P019bQMuzeF4OC+HuKV5p1rbrXZycytCYssQ
	Lntp5Njfykcm7x184wVGVF5AeKLuXW6T1CvqIUkOq+svmuNgFFmj0fD4kfdmmvK1bJm4OfKU3Zd
	oS93fBRU7Q2l8IjpedWXMs1xTAW+f9Jv2RmfRtE8=
X-Gm-Gg: AYBFou1L+7eWFDyFwa3dcD0QEsmbxhYSBdmRcX4XzeKuO121lihhXwESAUkyL8DkiEc
	5XTGHQnYLNEBEVPxjGuhaarCyYIHfhyh9CrxYwktnPgBQCiA8fcuAFjiUo/Otfh2GqKyr0Y3gGJ
	NjWSSVB4r56FCe/XUpLxzldNyAdcZTDZlFyAyJOY+BfR3izFzqki6x5dOp5hx1nyl5CYnkLBmTr
	yEfg+/TonVaCpZ3E16Jm4tU5OxhiRU1Pg9OZk/iEkYFTphyOYTLJmaMp0QhXuZXOhew0/tFkLVv
	u9p9ZrUTTT3wi7LlyLu64vwoQLxNUBiTfXWmhahcxzy9NEnr6YZ7E6spA3Kqg1f7oVSQmpPaocc
	lwlrrz9cEAVack/c74nZYJQbg3f/SO/hllvxy3BzPIdTW3Y3ZfzUofmzVnlDZPfLJCz0EcshgIS
	71ujwoOuAqk1GYBX7ka8TItA==
X-Received: by 2002:a53:d04a:0:20b0:675:68f4:67cc with SMTP id
 956f58d0204a3-67a0e57904cmr722888d50.80.1792592702534; Wed, 21 Oct 2026
 07:25:02 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930111444.192037-2-lautrbach@redhat.com> <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
 <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>
 <pjda4ox8pw0.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb> <CA+zpnLdODz8bLBgJY8LOSZuQOz2OHZYr2qK7eJQ-drB1WYrZng@mail.gmail.com>
In-Reply-To: <CA+zpnLdODz8bLBgJY8LOSZuQOz2OHZYr2qK7eJQ-drB1WYrZng@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 21 Oct 2026 10:24:51 -0400
X-Gm-Features: AclHuK_K3IQvYUEIC90AR6C1LdEFycWWwgV9CeJP_JLf3FVrRcJ7p7feVrkxYHI
Message-ID: <CAEjxPJ4k0iyQDwx_CV-+mcxeXpAXEqJVLR+6JsfgfzroAiaaEw@mail.gmail.com>
Subject: Re: [PATCH] Replace SHA-1 with SHA-256
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org, 
	Jason Zaman <jason@perfinion.com>, Russell Coker <russell@coker.com.au>, Cathy Hu <cahu@suse.de>, 
	Johannes Segitz <jsegitz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 10:51=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> On Fri, Oct 2, 2026 at 12:19=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >
> > > On Wed, Sep 30, 2026 at 9:44=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > >>
> > >> On Wed, Sep 30, 2026 at 7:18=E2=80=AFAM Petr Lautrbach <lautrbach@re=
dhat.com> wrote:
> > >> >
> > >> > From: Petr Lautrbach <plautrba@redhat.com>
> > >> >
> > >> > SHA-1 is considered obsolete so move to SHA-256 as the default dig=
est algorithm.
> > >> >
> > >> > Import the public-domain SHA-256 implementation from WjCryptLib an=
d use it for
> > >> > label digest handling.
> > >> >
> > >> > The original source of sha256.c is
> > >> > https://github.com/WaterJuice/WjCryptLib/releases/tag/Version_3.0.=
0
> > >> >
> > >> > Ignore sha256.{c,h} in make-format and check-format targets in ord=
er to adopt
> > >> > possible future changes in WaterJuice/WjCryptLib simpler.
> > >> >
> > >> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> > >> > ---
> > >>
> > >> A few comments below regarding compatibility / versioning and code
> > >> formatting inconsistency, but otherwise
> > >> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >>
> > >> 1. selabel_hash_all_partial_matches() output size grows from 20 to 3=
2
> > >> bytes. selabel_hash_all_partial_matches() is a public exported symbo=
l
> > >> (libselinux.map, LIBSELINUX_2.9) whose prototype is uint8_t *digest
> > >> with no length parameter and no man page. Any external caller sized
> > >> for the old SHA-1 output gets a 12-byte OOB write from
> > >> hash_all_partial_matches(). This interface/functionality was based o=
n
> > >> Android-specific functionality and I don't see any distro users, so
> > >> this is probably fine to break, but it should be a stated decision a=
nd
> > >> called out in the commit message and the 3.12 release notes. I will
> > >> defer to the distros on whether it requires a libselinux.so version
> > >> bump; I am fine either way.
> > >
> > > Actually, if someone cares, we could just use symbol versioning for
> > > this and fallback on the old symbol to only write the first 20-bytes
> > > of the SHA256 hash to the output buffer to avoid a compatibility
> > > break. That said, the only user of this function that I see is in
> > > Android's libselinux and that wouldn't be helped by that.
> > >
> >
> > I guess it's related to
> > https://android.googlesource.com/platform/external/selinux/+/refs/heads=
/main/libselinux/src/android/android_device.c#394
> >
> > It seems to me that symbol versioning would not help if android just
> > pulled new libselinux and left other code intact.
> >
>
> Thanks for the patch.
>
> Changing the content of security.sehash has a strong impact for us:
> during a regular update, if /data needs to be relabeled (because the
> hash optimization is skipped), the boot time increases significantly,
> leading to reports from our users and partners.
>
> It is also worth discussing why this migration is required. There is
> nothing wrong with treating SHA1 as a regular digest. On Android, the
> file_contexts used as input are all backed by dm-verity read-only
> partitions.
>
> If we still want to move forward, I recommend using a different set of
> functions that explicitly uses SHA256 (or have a schema to support
> future hashing functions). To ease the transition, we could add an
> option to restorecon to trigger a migration from SHA1 to SHA256 (we
> could potentially run this as a background thread after boot).

Have a look at revised version of this patch and my suggested
Android-specific fix in:
https://lore.kernel.org/selinux/CAEjxPJ4Mqw=3DwjktVfZDBkwQ_h9mO8oP4uPEHJL=
=3DM8z+5V84mbw@mail.gmail.com/

I think that would address your compatibility concern. WRT to whether
or not to transition at all, Fedora has been shipping a version of
this patch for years now and regrettably certain compliance frameworks
complain about any usage of SHA-1 regardless of whether it is
security-relevant.
