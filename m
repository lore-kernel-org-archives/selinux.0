Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9A3112B2
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627897; cv=pass; b=ZazXmWZ352Mlf8Zxzu2rU7mW1NeF6/PUtbQjiItkSmoaCqwxsZGr1WrDVibGfdEMhuXHtQVbASYI18B81g+wSe8QyRo5SD+rJGwznwSppjUR5SSSpDuMzwUhJBIEKJ0wiAgXDFexEydXoyjXeYdUYGdLzY00HJsGkYq+m3Bono4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627897; c=relaxed/simple;
	bh=V3c/N2f5INrnAZyoh8AculaLWOyVNCj9j/hGOrruP7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiTQiqXb8CZq2fFPfRSzttuPC2aEp3Qf9EtbeIjfGM5zdeFX0NfAADRPoISlGfxtUMEEbsay113eNa2IEIMjvXgh04gYy8cppnshTLFbAWem98QwylGFF4+0A96C4K/snce4pcVpwqK22yFkGBRYbyPO22TIQf6arMG/oeCGwWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucsb.edu; spf=pass smtp.mailfrom=ucsb.edu; dkim=pass (2048-bit key) header.d=ucsb.edu header.i=@ucsb.edu header.b=J+IbK+6r; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucsb.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucsb.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsb.edu header.i=@ucsb.edu header.b="J+IbK+6r"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664d22d7337so496152d50.1
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2026 13:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783627894; cv=none;
        d=google.com; s=arc-20260327;
        b=gf24AeYedmjAg86zLSVlSkKtUwyIjHZwlC6nPZWRsyPXAwohdMLrtvkcxEJuJcdJvz
         hgDJsLAEPrxUC8BtVgsILlDGLeQoIC0PnM06+bCFj7HdQHseTkCQyLsq4XtCdt7PMzzT
         OYwCfX/BEK5jPapeAOQjzq/UsrexPYwMTdMGcAthX8Xf1WeHFErnZV74AIeqyKKlvjHk
         +YHFjtXYmoUCKmgWEmOJhSsYGHxy4N1+z0nPEVrnqaQTldOqo6Y7umn+86S2x3l272j3
         +JhOPAG4qqOp5DH5jrNRMLzMUo7K99Jp4YvMYoAnGs/XNTxOQvwilkCtLi/G4A5j5PBk
         I70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RIBAP7E2WBn61oAftV8ubSMy6cxH5aPuPrtagtYPY8w=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=ej66KH+fhpYPdk6SkaE1ePYAyhskizsufnBTMppWaXTMo3RJvGG9W8CdTVmkr2frff
         vjaxsruURLlafzG6gDT6gjnD5G3n8f/pDKo2yXBQtPhsB4mGCeRsaWQcpzsntPI9cKIQ
         h8KACeZn1ogCLn1wGb1eKPU6xkDX1wXC9BzEOnaZuhVOQpz8y4zUVU9GgZVQk6TfJfkH
         fYmeqEMi7mZ6OUjrk1RggN/h+QW6aek8ucC9W9dkAqy72YPCmI1JeK+JXPhNTCya5LZS
         lPISXXq+VGDmJYP0KhyULEoqped1PsD6bNXTuMhmXNZMReQGe3hCwoPql3GhbqA727V/
         7jOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsb.edu; s=google; t=1783627894; x=1784232694; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RIBAP7E2WBn61oAftV8ubSMy6cxH5aPuPrtagtYPY8w=;
        b=J+IbK+6rCxJS99hVa6jmU7UiUCOHJmKiOjzt/A5s+NZriLIKnXyAf+zcNtb/P4UUxJ
         rEzotQ/oa6YMUQ1XO6Xq1ul2iCD+EVrt586oHvfd9aSz+zPW0CWyXRU3n3DdulS3u7O4
         yvtCqvGior4xJfDV8vfZ7ZEmRh+dbE7XPhbWm2zV59GrWBaab+OQeKSufVwQOLGB5jzL
         bp3/Rh5jzxO5T6Wd9siDcGHv5w8E0tRVlui0K9NPo2RZG2NB9aHONde4+XL64fLoMYgP
         aMCu7GwSBDwjTm1Vc0u8QVDuQiLf2aUk7jpXQ9X8ndkfNMwqQB4jU9Jsj3ioPYyIdQNz
         u4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783627894; x=1784232694;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RIBAP7E2WBn61oAftV8ubSMy6cxH5aPuPrtagtYPY8w=;
        b=gymDZuTMS1jtxkJjnd6Thrwal2aAXQj1l6Qi1X7FwnPhS5klZd/ggeg/NrLnX9dOyA
         LpWEro3MH+rMB5w4uKGwqzhzHSeEsh3htT0G6Zro4s7jLqzU6QOtzF1Z9VYRh90ybjnD
         Ly8E6bRmjHD+3jPEQlOgZtvRBb0AGXw5zs2kmPr/JW55P2MblD5OvFBy0+cSHl3P2E0S
         T2EKPlyp4bkbXHngHZ5jR80Te7qRC+IXnbhh+KVbABDSnoHBG3ZLl6HNbUXkJdAAufCE
         MiuU1C5fM2aloCeA7NqzVKSddPA6FHMkLYU2OBW05R8xObPbO89RlvpjJr75MQzqoS3C
         Pp2Q==
X-Gm-Message-State: AOJu0Yz+1BapOJSGsfIDygVqBhOijNIHJyw1f8Uq/pPBgzEBYZ1O8VpJ
	CLKIngNP/srbJ88iz7AK7//kqUIn/8dkAspPKlgENIAO2b4TK3rJon4ljMg2HxVZ0zYFfBSw1Ab
	ak2eymDD4sJfeni6H7P/wy8AhrWAVJ2jn4RnMKF27rQ==
X-Gm-Gg: AfdE7cnR8kC3tG0lFGtFfFw4zD0PFBe+faUS2DQpNdRH9BcJTk8plffA7rnxa9N6bYX
	uEjf+/JejfmPJLq7/WrGpePi5YadVnUFij7CeRhDFbEa5FbYcR1SdSUEr3pMU6UFzPqv3OBVNNG
	luxRF1hYFFtKofqhPtdt+e/EbMG5ZQydlGMFnstDmE8AZ4j84zXNdVCRh08kN6qVF5CQNbrXHPD
	Dj6bK7m0YSJJnj91KSsVrxqHDAO+43SyFie7lpGjVRZyd8FB1e77aEkYIqfwE8BIVIXlyyh+g==
X-Received: by 2002:a05:690e:2541:b0:664:eac2:b3d1 with SMTP id
 956f58d0204a3-667c5a657d5mr461295d50.11.1783627894420; Thu, 09 Jul 2026
 13:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+jXL7=3=+wxXqm42Q_tQaoeusdUCnwzav_6gF6niAttPZ4ijg@mail.gmail.com>
 <CAEjxPJ6oehVAWO47=dCnk7q2-GZ+wkyiKXa6j--PAziPP4135g@mail.gmail.com>
In-Reply-To: <CAEjxPJ6oehVAWO47=dCnk7q2-GZ+wkyiKXa6j--PAziPP4135g@mail.gmail.com>
From: COMS VLAB <coms-vlab@ucsb.edu>
Date: Thu, 9 Jul 2026 13:11:23 -0700
X-Gm-Features: AVVi8CeJHzWEZsNxxYTWMu73yPoXuNzquiEecCXh51CgxM2aBkzaXqEhxuMrufA
Message-ID: <CA+jXL7m20TzvdCuuz0d_bgAvf+GV5dFmKJb9gFEYjf+OYUYuZQ@mail.gmail.com>
Subject: Re: [Bug] Double free vulnerability at define_genfs_context_helper
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000f9db00656333bdd"

--0000000000000f9db00656333bdd
Content-Type: multipart/alternative; boundary="0000000000000f9dae0656333bdb"

--0000000000000f9dae0656333bdb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Yes, patch below. Please attribute the report to "Reported-by: UCSB VLab <
coms-vlab@ucsb.edu>".

The fix clears the local `fstype` after it's handed to `newgenfs`, so the
`fail:` cleanup no longer frees it and the genfs list becomes its sole
owner (freed once by `policydb_destroy()`), mirroring the `else` branch.
Verified with ASan: pre-fix double-free, post-fix clean.
---
 checkpolicy/policy_define.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index b73de45..f8c4d28 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -6050,6 +6050,8 @@ static int define_genfs_context_helper(char *fstype,
int has_type)
  }
  memset(newgenfs, 0, sizeof(struct genfs));
  newgenfs->fstype =3D fstype;
+ /* ownership transferred into the genfs list; do not free on error */
+ fstype =3D NULL;
  newgenfs->next =3D genfs;
  if (genfs_p)
  genfs_p->next =3D newgenfs;
--

I added the patch file. Let us know if you need anything more.

Thanks,
UCSB VLab

On Thu, Jul 9, 2026 at 12:05=E2=80=AFPM Stephen Smalley <
stephen.smalley.work@gmail.com> wrote:

> On Thu, Jul 9, 2026 at 2:57=E2=80=AFPM COMS VLAB <coms-vlab@ucsb.edu> wro=
te:
> >
> > Summary
> >
> > A double-free vulnerability exists in the checkpolicy source policy
> compiler's handling of genfscon statements. When parsing a new (previousl=
y
> unseen) filesystem type string, define_genfs_context_helper() transfers
> ownership of the fstype pointer into a genfs struct that is linked into t=
he
> policydb's live genfs list, but fails to clear the local fstype variable
> afterward. If any subsequent parsing step in the same function fails,
> execution jumps to a shared fail: cleanup block. This cleanup block frees
> fstype, which leaves a dangling pointer in the genfs list. When the
> policydb is later destroyed via policydb_destroy(), it frees that same
> pointer again, causing the double-free.
> >
> >
> >
> > Version
> >
> > 06159ee35d6b4c968c1f942c9361c111644de826 - current version
> >
> >
> >
> > PoC: Please see attachment
> >
> >
> >
> > ASAN Report
> >
> > =3D=3D2502=3D=3DERROR: AddressSanitizer: attempting double-free on
> 0xfc1f82fe1330 in thread T0:
> >
> >     #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId:
> ea3a1d5343a0633f08393e738125b8f44be83f66)
> >
> >     #1 0xaaaac9ffd49c in policydb_destroy
> selinux/libsepol/src/policydb.c:1596:3
> >
> >     #2 0xaaaac9faf758 in main selinux/../repro.c:11:5
> >
> >     #3 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18)
> (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >
> >     #4 0xffff83c63058 in __libc_start_main
> (/usr/lib/aarch64-linux-gnu/libc.so.6+0x23058) (BuildId:
> b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >
> >     #5 0xaaaac9ec7c6c in _start (selinux/repro+0x47c6c) (BuildId:
> ea3a1d5343a0633f08393e738125b8f44be83f66)
> >
> > 0xfc1f82fe1330 is located 0 bytes inside of 2-byte region
> [0xfc1f82fe1330,0xfc1f82fe1332)
> >
> > freed by thread T0 here:
> >
> >     #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId:
> ea3a1d5343a0633f08393e738125b8f44be83f66)
> >
> >     #1 0xaaaac9fc8a60 in define_genfs_context_helper
> /selinux/checkpolicy/policy_define.c:6163:2
> >
> >     #2 0xaaaac9fc8a60 in define_genfs_context
> /selinux/checkpolicy/policy_define.c:6171:9
> >
> >     #3 0xaaaac9fcbc1c in yyparse
> /selinux/checkpolicy/policy_parse.y:787:30
> >
> >     #4 0xaaaac9fb95b4 in read_source_policy
> /selinux/checkpolicy/parse_util.c:70:6
> >
> >     #5 0xaaaac9faf750 in main /selinux/../repro.c:10:5
> >
> >     #6 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18)
> (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >
> >     #7 0xffff83c63058 in __libc_start_main
> (/usr/lib/aarch64-linux-gnu/libc.so.6+0x23058) (BuildId:
> b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >
> >     #8 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId:
> ea3a1d5343a0633f08393e738125b8f44be83f66)
> >
> > previously allocated by thread T0 here:
> >
> >     #0 0xaaaac9f53a4c in strdup (/selinux/repro+0xd3a4c) (BuildId:
> ea3a1d5343a0633f08393e738125b8f44be83f66)
> >
> >     #1 0xaaaac9fb9aa0 in insert_id
> /selinux/checkpolicy/policy_define.c:131:10
> >
> >     #2 0xaaaac9fcc744 in yyparse /selinux/checkpolicy/policy_parse.y
> >
> >     #3 0xaaaac9fb95b4 in read_source_policy
> /selinux/checkpolicy/parse_util.c:70:6
> >
> >     #4 0xaaaac9faf750 in main /selinux/../repro.c:10:5
> >
> >     #5 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18)
> (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >
> >     #6 0xffff83c63058 in __libc_start_main
> (/usr/lib/aarch64-linux-gnu/libc.so.6+0x23058) (BuildId:
> b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >
> >     #7 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId:
> ea3a1d5343a0633f08393e738125b8f44be83f66)
> >
> > SUMMARY: AddressSanitizer: double-free (/selinux/repro+0xed518)
> (BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66) in free
> >
> > =3D=3D2502=3D=3DABORTING
>
> Thanks for the report. Are you planning on submitting a patch for it?
> How did you want us to attribute the report regardless?
>

--0000000000000f9dae0656333bdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<br><br>Yes, patch below. Please attribute the =
report to &quot;Reported-by: UCSB VLab &lt;<a href=3D"mailto:coms-vlab@ucsb=
.edu">coms-vlab@ucsb.edu</a>&gt;&quot;.=C2=A0<div><br></div><div>The fix cl=
ears the local `fstype` after it&#39;s handed to `newgenfs`, so the `fail:`=
 cleanup no longer frees it and the genfs list becomes its sole owner (free=
d once by `policydb_destroy()`), mirroring the `else` branch. Verified with=
 ASan: pre-fix double-free, post-fix clean.<br>---<br>=C2=A0checkpolicy/pol=
icy_define.c | 2 ++<br>=C2=A01 file changed, 2 insertions(+)<br><br>diff --=
git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c<br>index b7=
3de45..f8c4d28 100644<br>--- a/checkpolicy/policy_define.c<br>+++ b/checkpo=
licy/policy_define.c<br>@@ -6050,6 +6050,8 @@ static int define_genfs_conte=
xt_helper(char *fstype, int has_type)<br>=C2=A0		}<br>=C2=A0		memset(newgen=
fs, 0, sizeof(struct genfs));<br>=C2=A0		newgenfs-&gt;fstype =3D fstype;<br=
>+		/* ownership transferred into the genfs list; do not free on error */<b=
r>+		fstype =3D NULL;<br>=C2=A0		newgenfs-&gt;next =3D genfs;<br>=C2=A0		if=
 (genfs_p)<br>=C2=A0			genfs_p-&gt;next =3D newgenfs;<br>--</div><div><br><=
/div><div>I added the patch file. Let us know if you need anything more.=C2=
=A0=C2=A0</div><div><br></div><div>Thanks,</div><div>UCSB VLab</div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Jul 9, 2026 at 12:05=E2=80=AFPM Stephen Smalley &lt=
;<a href=3D"mailto:stephen.smalley.work@gmail.com">stephen.smalley.work@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Thu, Jul 9, 2026 at 2:57=E2=80=AFPM COMS VLAB &lt;<a href=3D"mailt=
o:coms-vlab@ucsb.edu" target=3D"_blank">coms-vlab@ucsb.edu</a>&gt; wrote:<b=
r>
&gt;<br>
&gt; Summary<br>
&gt;<br>
&gt; A double-free vulnerability exists in the checkpolicy source policy co=
mpiler&#39;s handling of genfscon statements. When parsing a new (previousl=
y unseen) filesystem type string, define_genfs_context_helper() transfers o=
wnership of the fstype pointer into a genfs struct that is linked into the =
policydb&#39;s live genfs list, but fails to clear the local fstype variabl=
e afterward. If any subsequent parsing step in the same function fails, exe=
cution jumps to a shared fail: cleanup block. This cleanup block frees fsty=
pe, which leaves a dangling pointer in the genfs list. When the policydb is=
 later destroyed via policydb_destroy(), it frees that same pointer again, =
causing the double-free.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Version<br>
&gt;<br>
&gt; 06159ee35d6b4c968c1f942c9361c111644de826 - current version<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; PoC: Please see attachment<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ASAN Report<br>
&gt;<br>
&gt; =3D=3D2502=3D=3DERROR: AddressSanitizer: attempting double-free on 0xf=
c1f82fe1330 in thread T0:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) =
(BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1 0xaaaac9ffd49c in policydb_destroy selinux/libse=
pol/src/policydb.c:1596:3<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2 0xaaaac9faf758 in main selinux/../repro.c:11:5<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3 0xffff83c62f18=C2=A0 (/usr/lib/aarch64-linux-gnu=
/libc.so.6+0x22f18) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4 0xffff83c63058 in __libc_start_main (/usr/lib/aa=
rch64-linux-gnu/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7=
eaa152bef4)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#5 0xaaaac9ec7c6c in _start (selinux/repro+0x47c6c)=
 (BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66)<br>
&gt;<br>
&gt; 0xfc1f82fe1330 is located 0 bytes inside of 2-byte region [0xfc1f82fe1=
330,0xfc1f82fe1332)<br>
&gt;<br>
&gt; freed by thread T0 here:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) =
(BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1 0xaaaac9fc8a60 in define_genfs_context_helper /s=
elinux/checkpolicy/policy_define.c:6163:2<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2 0xaaaac9fc8a60 in define_genfs_context /selinux/=
checkpolicy/policy_define.c:6171:9<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3 0xaaaac9fcbc1c in yyparse /selinux/checkpolicy/p=
olicy_parse.y:787:30<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4 0xaaaac9fb95b4 in read_source_policy /selinux/ch=
eckpolicy/parse_util.c:70:6<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#5 0xaaaac9faf750 in main /selinux/../repro.c:10:5<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#6 0xffff83c62f18=C2=A0 (/usr/lib/aarch64-linux-gnu=
/libc.so.6+0x22f18) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#7 0xffff83c63058 in __libc_start_main (/usr/lib/aa=
rch64-linux-gnu/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7=
eaa152bef4)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#8 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c=
) (BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66)<br>
&gt;<br>
&gt; previously allocated by thread T0 here:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0 0xaaaac9f53a4c in strdup (/selinux/repro+0xd3a4c=
) (BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1 0xaaaac9fb9aa0 in insert_id /selinux/checkpolicy=
/policy_define.c:131:10<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2 0xaaaac9fcc744 in yyparse /selinux/checkpolicy/p=
olicy_parse.y<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3 0xaaaac9fb95b4 in read_source_policy /selinux/ch=
eckpolicy/parse_util.c:70:6<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4 0xaaaac9faf750 in main /selinux/../repro.c:10:5<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#5 0xffff83c62f18=C2=A0 (/usr/lib/aarch64-linux-gnu=
/libc.so.6+0x22f18) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#6 0xffff83c63058 in __libc_start_main (/usr/lib/aa=
rch64-linux-gnu/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7=
eaa152bef4)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0#7 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c=
) (BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66)<br>
&gt;<br>
&gt; SUMMARY: AddressSanitizer: double-free (/selinux/repro+0xed518) (Build=
Id: ea3a1d5343a0633f08393e738125b8f44be83f66) in free<br>
&gt;<br>
&gt; =3D=3D2502=3D=3DABORTING<br>
<br>
Thanks for the report. Are you planning on submitting a patch for it?<br>
How did you want us to attribute the report regardless?<br>
</blockquote></div>

--0000000000000f9dae0656333bdb--
--0000000000000f9db00656333bdd
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-checkpolicy-fix-double-free-of-fstype-in-define_genfs_context_helper.patch"
Content-Disposition: attachment; 
	filename="0001-checkpolicy-fix-double-free-of-fstype-in-define_genfs_context_helper.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mrdxvg7a0>
X-Attachment-Id: f_mrdxvg7a0

RnJvbSA5YzBiMWM5NTAxYjU2MzgzMWM0NmI0N2ZiNWY0ZjNkMTgyZGJlNzg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBVQ1NCIFZMYWIgPGNvbXMtdmxhYkB1Y3NiLmVkdT4KRGF0ZTog
VGh1LCA5IEp1bCAyMDI2IDEyOjAwOjAwIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gY2hlY2twb2xp
Y3k6IGZpeCBkb3VibGUgZnJlZSBvZiBmc3R5cGUgaW4KIGRlZmluZV9nZW5mc19jb250ZXh0X2hl
bHBlcgoKV2hlbiBwYXJzaW5nIGEgbmV3IGZpbGVzeXN0ZW0gdHlwZSwgZGVmaW5lX2dlbmZzX2Nv
bnRleHRfaGVscGVyKCkgdHJhbnNmZXJzCm93bmVyc2hpcCBvZiBmc3R5cGUgaW50byBhIGdlbmZz
IHN0cnVjdCBsaW5rZWQgaW50byB0aGUgcG9saWN5ZGIncyBnZW5mcwpsaXN0LCBidXQgZG9lcyBu
b3QgY2xlYXIgdGhlIGxvY2FsIGZzdHlwZS4gQSBsYXRlciBnb3RvIGZhaWwgdGhlbiBmcmVlcyBp
dCwKbGVhdmluZyBhIGRhbmdsaW5nIHBvaW50ZXIgdGhhdCBwb2xpY3lkYl9kZXN0cm95KCkgZnJl
ZXMgYWdhaW4uCgpDbGVhciBmc3R5cGUgYWZ0ZXIgdGhlIG93bmVyc2hpcCB0cmFuc2ZlciwgbWly
cm9yaW5nIHRoZSBlbHNlIGJyYW5jaC4KClJlcG9ydGVkLWJ5OiBVQ1NCIFZMYWIgPGNvbXMtdmxh
YkB1Y3NiLmVkdT4KLS0tCiBjaGVja3BvbGljeS9wb2xpY3lfZGVmaW5lLmMgfCAyICsrCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvY2hlY2twb2xpY3kvcG9s
aWN5X2RlZmluZS5jIGIvY2hlY2twb2xpY3kvcG9saWN5X2RlZmluZS5jCmluZGV4IGI3M2RlNDUu
LmY4YzRkMjggMTAwNjQ0Ci0tLSBhL2NoZWNrcG9saWN5L3BvbGljeV9kZWZpbmUuYworKysgYi9j
aGVja3BvbGljeS9wb2xpY3lfZGVmaW5lLmMKQEAgLTYwNTAsNiArNjA1MCw4IEBAIHN0YXRpYyBp
bnQgZGVmaW5lX2dlbmZzX2NvbnRleHRfaGVscGVyKGNoYXIgKmZzdHlwZSwgaW50IGhhc190eXBl
KQogCQl9CiAJCW1lbXNldChuZXdnZW5mcywgMCwgc2l6ZW9mKHN0cnVjdCBnZW5mcykpOwogCQlu
ZXdnZW5mcy0+ZnN0eXBlID0gZnN0eXBlOworCQkvKiBvd25lcnNoaXAgdHJhbnNmZXJyZWQgaW50
byB0aGUgZ2VuZnMgbGlzdDsgZG8gbm90IGZyZWUgb24gZXJyb3IgKi8KKwkJZnN0eXBlID0gTlVM
TDsKIAkJbmV3Z2VuZnMtPm5leHQgPSBnZW5mczsKIAkJaWYgKGdlbmZzX3ApCiAJCQlnZW5mc19w
LT5uZXh0ID0gbmV3Z2VuZnM7Ci0tIAoyLjU0LjAKCg==
--0000000000000f9db00656333bdd--
