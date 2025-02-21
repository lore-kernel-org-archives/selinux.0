Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB4AD5A
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099025; cv=none; b=bSZ+xh9hTfg4eYTAf1e4EcV0DVBwZ5uNABruK0QO/+7MvnTRWuep3q90fH8mbOBjEqsJjbg+8G7if6I9IJCcY4pbn1IEaJ3op0iWXatlSvd6h+I0M8ytAPbuWn/39yhyfpSq0ITQon+wamtS1gO7NWCQHXQEfAUSwsd4DIz2SA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099025; c=relaxed/simple;
	bh=ufcXxv0aXRI2BMParyC1pnNAax4ke0dhcnMU8SPQf60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owoGX5m/hNaudf8xl3QGj+xDiUSfNPEFflvwSGZ5CUt4f6F/ITqyctYtrAvHtoBssRMn0IS8JQzql7OV32VhhlAdxG9Z+pgJLEJSJHXdYWLBFHG/ta135IrHgF2jiEP2ObAWHlqHF0eItsmfDIIfKG6Hb3pyTK5+FSqfoe4XjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhRRx4ni; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhRRx4ni"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5461cb12e39so1490286e87.2
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 16:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740099021; x=1740703821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5kg6auP0xeQwURcf1/sEbjBkxPDy+21giujDCZGblU=;
        b=fhRRx4niO9HaFkMtWiC3OZNTutqM5o7OnR1oA8uo1fg7TN19z0ej+65jhYwTc9NGsK
         +rIAliY6r1ab8jjMiP4SWYuD987CLAREuCvyePM6wisFFcPXMwrZw9uO35zqKFFxFeZw
         1LH4T+4nGfYYob38Jr8Se3NW4T8kFeFgRVvHyP3sEa1ZoLXK9YLPX5ruJZtimxe6tGaT
         qONzsSFT0NxS8Fw/DCewE5gut7zR9dHtPcaXueCmp+LnEkM8Myi1FOpBLRUZ8YVJJEBy
         93A6s5CmLAi1p2/xj5MRn9GaCkoCfpcBBKmUIjyD9wgfhBbb4csHtK3BpBXlnpVRuqkL
         Rdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099021; x=1740703821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5kg6auP0xeQwURcf1/sEbjBkxPDy+21giujDCZGblU=;
        b=CGj1ZneEnts1sJ5A7DBBDQbNfJclXKHKYpTNf5w7qxnSgfsuCLkBRE8OopWzSK2vps
         XpBrTUfb2aAeRDRaLENp3uUIfkHZuP/0UEGHsZfRMoxx8gewxWaVFfsrIQ5xavSbr+f2
         8gMH4vjNhQmBxLlCXa2Hjpx3zEPzDdBccssEEQwybMnEgv7bhBL+NQ7P9bfgX21CmP2P
         we/XtxMVrhVYHA1l370Vw8Kiy3PFYN3DTwKSA2VIIwDO31sIxa/arz4hAKzCsPv1TxUt
         Bd7qf/f69LfWiDmPLnxJ5aV9WhHBLooK9dEukYUNdGTFt/g2Ae9L4GRVAloo/JHLtcJx
         0Djw==
X-Gm-Message-State: AOJu0Yx44I0eOCW14hkbw0HJOZ4DZ61riZsJiDh3z3mdO4YVKus8yeS+
	qZj27mfKmO81VGONB4AQX3P4N3hZKeX0kD2mMEUpXH1VrzW84glFZPP5Pp/MZZQqOIiAjv6NgNS
	F/0SdUEOudtUpoUfsyYgv7nbhtRfG8if0
X-Gm-Gg: ASbGnctAUhcFc6QUlvmEORH6Znbn71pwMxo06xnjvKPCcs32gb37WBxJgww0TpaxNuS
	iVrsFMxkrCNhpxgFmEwMmQTO14C4HtYLDOkQ/ntezwWv5AlVunHPrjzHlRFVDk/1lBh9RdKL0zw
	==
X-Google-Smtp-Source: AGHT+IFhMV4ASDRNSwL9ax2vQvavJfyc09m5/9ZPFllI8Rt7LMAYhxm1VVle0fnw+i9++pxAJArqmSiMSr5GE0atLmk=
X-Received: by 2002:a05:6512:108b:b0:545:bf4:4bc7 with SMTP id
 2adb3069b0e04-54838ee9139mr381167e87.19.1740099021294; Thu, 20 Feb 2025
 16:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220211249.574456-1-nvraxn@gmail.com> <CAFftDdo6SvOE9+XZY3bKidFGz_So6_N6jNxxSyB0OPR8thSY=Q@mail.gmail.com>
In-Reply-To: <CAFftDdo6SvOE9+XZY3bKidFGz_So6_N6jNxxSyB0OPR8thSY=Q@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 20 Feb 2025 18:50:10 -0600
X-Gm-Features: AWEUYZlf0uVwoLLlz6CsWQJ7tLeg7IRuY2SFZO6R2-CTKDoHmfMxFTdElU3azlE
Message-ID: <CAFftDdpV-dnLKVTDACgm2RUG8gnBU=3YnJDp5_ZyvR78p0eZdw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: define basename macro for non-glibc systems
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 6:16=E2=80=AFPM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Feb 20, 2025 at 3:13=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Passing a const char *path to basename(3) is a glibc specific
> > extension.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> > ---
> >  libsemanage/src/conf-parse.y | 3 +++
> >  libsemanage/src/direct_api.c | 3 +++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.=
y
> > index 6cb8a598..97cc5438 100644
> > --- a/libsemanage/src/conf-parse.y
> > +++ b/libsemanage/src/conf-parse.y
> > @@ -50,6 +50,9 @@ static external_prog_t *new_external;
> >  static int parse_errors;
> >
> >  #define PASSIGN(p1,p2) { free(p1); p1 =3D p2; }
> > +#if !defined(__GLIBC__)
> > +#define basename(src) (strrchr(src, '/') ? strrchr(src, '/') + 1 : src=
)
> > +#endif
> >
> >  %}
> >
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.=
c
> > index 99cba7f7..4459a7d7 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -63,6 +63,9 @@
> >  #define PIPE_READ 0
> >  #define PIPE_WRITE 1
> >  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > +#if !defined(__GLIBC__)
> > +#define basename(src) (strrchr(src, '/') ? strrchr(src, '/') + 1 : src=
)
> > +#endif
> >
> >  static void semanage_direct_destroy(semanage_handle_t * sh);
> >  static int semanage_direct_disconnect(semanage_handle_t * sh);
> > --
> > 2.48.1
> >
>
> What system are you on where you run libsemange without glibc, just curio=
us?
>
> I am not opposed to adding an implementation for basename where the
> input can be read only for non-glibc, but this patch doesn't work:
> Per the man page, https://man7.org/linux/man-pages/man3/basename.3.html,
> basename("/") should return "/", this one return "\0"
> basename("/usr/"); should return "usr", this returns "\0".
>
> There are two ways you could approach this:
> 1. If you wanted to do an implementation, I would add it to
> utilities.c/h and call it something other than basename so we don't
> get any odd issues with it choosing the one from the headers over the
> macro. Perhaps libsemange_basename(). On glibc systems this would just
> call basename directly and on non-glibc systems do the implementation
> with your own logic.
> 2. Just copy the path into a modifiable buffer on non-glibc systems
>
> I would do both approaches. Create a utility routine that calls
> basename for glibc and for non-glibc just copies it to a modifiable
> buffer and then calls basename over rolling our own and the bugs
> associated with it, also add a unit test for this. This would keep the
> logic in one place and be dirt simple.
>

Looking even more closely it's only the conf-parse.y usage where
selinux_policy_root() returns a const char *,
the usage in direct_api.c path is a char *, so we only need one spot
changed and that can just be a simple
copy to an intermediate buffer or am I missing something else here
you're pointing out?

> Bill
