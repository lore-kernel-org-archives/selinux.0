Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE83793CA
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707092; cv=pass; b=rj089Ajl/EuRGoABsMNblrXLdvc0trFo7hUnlKam0XdmEpqLaDKQtKuY22pA434WkAsPylJBCBB8YJu3B5qB+hJ6mdziWmUK3oF4L6NHZnyDWM+Cg4MBax1IYKYR9vQYJ6v4zJz4NSI+4Ofr/HYrFfi6IysVak9SwRtLTGl0f2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707092; c=relaxed/simple;
	bh=cbaarbv0h8q0r0wc2i736wRtWUx1DlpbGzPvPzmigOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djK71qvLIsusIWBe6t6juX6JAZj5bdJIXV21pKMZ0+CDZZO1DlHuW8a9oUGvZTqQOMGwLUJIyyXAclOciVRpaMDPlYydwHePSRYtgoxwqBxcUKQ3MYhu37+hpwmui69JD85yboK1GdRhXZd8ZwHTldb7PDxl+CrqrJqR0MZbaf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY4bGapn; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY4bGapn"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso940844a12.0
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 11:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783707090; cv=none;
        d=google.com; s=arc-20260327;
        b=LAq0hk2DGq81UGbFtQTiQuRLADyRbVyg2w6nUy5w0noosS339VLIxeq56IkekA7pbJ
         vGaZa+5sLyxNnqUNqbLSvih3D/vKhELKEju65qxSZwrHcYno/M5RT9O5/cApX0xNyw6J
         ArNXC4Hiy7KkAz8bFFv3A2tdlFAi9oTTyKhpR9v/ikdRK0uTGF6hMN1c131E9Xj6YPyX
         E5i8zv28+3eZa+x03Go634Tk5evbwVlkkvFq0rX7rHqUH+LPbliZNIQH2M35dft7J9Ln
         e5f1Wwh2lPkv7VCxjcitbt9GBMWu//k4vtq7rw3WkOx+D1UBhImUvWikIpjeL/kHvELY
         8Zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+yZPTPosOYQEi2Q5RQK1GU47aNX0cTjKa3og3SFJMbo=;
        fh=cWi3kW8rsHyAhg0+a/rjvnARy8e1ms2xzmZhoFZJJgk=;
        b=iCgRZD75Y/IO1R2+oRByTVmbv0M5oki8fE61NmRsg0Jt3Q5+9kDB8PFhyhaCLRsiBb
         QpfmEmg5Heh5lASr5kxvIIbx3Pbdjlx35NkqvRE2emnDmnoR0EueP5YAvC3+vorOYr05
         +1DCYNYdr170ucNn/1Ep8kdfacx3xV61BnMb6VXlXOBSjrnnPPP7vgU2DejM5l+2y+D+
         NDtkTE7/GN7eW7B1zuE1mLM6g6SDMUI9sLuyZ0Db+OAycZrEt2kEyEZ1wV0cZvqRgGf4
         7Mlyot1gZ8CR3dnc5RDiQd81uBjvTkVKTZsWT8DU0whxj1mnATLhqNUEa4erVhFve56J
         pz6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783707090; x=1784311890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+yZPTPosOYQEi2Q5RQK1GU47aNX0cTjKa3og3SFJMbo=;
        b=CY4bGapnKCyRQUCxHkP8xqpa8Gk4Wtj6Hn8sUa5yLuAIQTAprjlOeEoM+n3p++W+Yk
         H/kto4e8XbD4U3Bu+yG2z8jFC7e4V5fRYk1z7DwwuALjDrG+0pdgt1c5UjNPuN6K+RkL
         0bg8bnTVhcED+xHmg6f8qclH4Vg7+fiD/F4m3hC1i0ImM8abXCfNcoweLyxixUuilB+e
         w3orUCglO/gcMBkzC8+jyPXFKUJZV01uLlWqRYPc94HCrxvmmdQr/nkto18auzscx8vM
         66UgLYsvPfTKYLd/4at44YWjK/TuD65jlafZI1Ue1pPeyu31HxxptY4mDmo/NrLLNFzY
         agAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707090; x=1784311890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yZPTPosOYQEi2Q5RQK1GU47aNX0cTjKa3og3SFJMbo=;
        b=goNQi/2VbdC7ds1q/IkJubvL33dsPRTkLIiSuXayAXaYHH1UCi41goODEMtV8vRq3U
         LX2Qsjiu29IGKfSFVEOMNNF8pxrCO3k7pXSsvzBJy1qIyOgvhbpJJBe3KQ60zAHIvJZK
         fIxGFQxaoy+ul5MdYKRv/D3EBJRYi4ml5tckqc2BXLfBywdTlkdNP4jqWM77a4R/793v
         w4a6TZrXsGPLJzdgauiOPfY9ANxsTZB94AXr1eejtvPAw/z73avJ4rUH3Yby12i4C2Wo
         wy5Vm3HALq7DrBD3fwGimuIEn2Zt3GXGz/7v0QZGtiOB+09ZNbrA8wRZ/hTHzzmPl6z3
         DWJA==
X-Gm-Message-State: AOJu0YyVNq5kz2KH6x43VdFY5+FvkPjvPl6fIEDYzXEDejVIhWy80ujc
	mLNdkzPWxm2wK9Vu8zIGaq3Fc4whJgkCtbMLplrxrOn2g0khBdI87X29FezLuvYwNqo8ZKIQXib
	5Dk/U6lVP7pRF9+Il3+ICgZS3qnG1C2g=
X-Gm-Gg: AfdE7clOICT6IQyrPXBNioHhymJ+YvfbyGJyzB6L4Okj5Z14jclR2HXNjp/HZKRCFtg
	typT/A7zffXer+Q4GbwNNuqX1YUuNiFgjtlGEueke6az3i2CDL+5xC1ZmBQyq8HJM2iiPUvrpbw
	NFiSUH+L80i7nMwyIz2SBH2ZAXMuI0hySEKLsuxXK0ckJiDQFB1f/QXtagc4PMZBKBY86x+SasQ
	31dsqVFdqxLoTQ2PRN/j7nHjYYsGpVAvE25VZi2qHhO9FXdhz7zr219mx4glk7XHIfhytHH
X-Received: by 2002:a05:6a20:431a:b0:3bf:edfb:62f0 with SMTP id
 adf61e73a8af0-3c110ba1098mr100384637.55.1783707090314; Fri, 10 Jul 2026
 11:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+jXL7=3=+wxXqm42Q_tQaoeusdUCnwzav_6gF6niAttPZ4ijg@mail.gmail.com>
 <CAEjxPJ6oehVAWO47=dCnk7q2-GZ+wkyiKXa6j--PAziPP4135g@mail.gmail.com> <CA+jXL7m20TzvdCuuz0d_bgAvf+GV5dFmKJb9gFEYjf+OYUYuZQ@mail.gmail.com>
In-Reply-To: <CA+jXL7m20TzvdCuuz0d_bgAvf+GV5dFmKJb9gFEYjf+OYUYuZQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Jul 2026 14:11:18 -0400
X-Gm-Features: AVVi8CenZNHppYM2owkSgqZsNrO8f2oo9x-ejrLRsNARXX5BQ2RdlZq7mbKH7hI
Message-ID: <CAEjxPJ6rMJd--Tg5yzByzFRQ=irbE0f4fxik48FdaxsT=Qtfbg@mail.gmail.com>
Subject: Re: [Bug] Double free vulnerability at define_genfs_context_helper
To: COMS VLAB <coms-vlab@ucsb.edu>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:11=E2=80=AFPM COMS VLAB <coms-vlab@ucsb.edu> wrote=
:
>
> Hi Stephen,
>
> Yes, patch below. Please attribute the report to "Reported-by: UCSB VLab =
<coms-vlab@ucsb.edu>".
>
> The fix clears the local `fstype` after it's handed to `newgenfs`, so the=
 `fail:` cleanup no longer frees it and the genfs list becomes its sole own=
er (freed once by `policydb_destroy()`), mirroring the `else` branch. Verif=
ied with ASan: pre-fix double-free, post-fix clean.

Thanks, unfortunately we need a Signed-off-by: line with an actual
person's name and email address and your patch was whitespace-damaged
by your mail client. Try using git send-email instead, see
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#submi=
tting-patches
for some tips.

If that proves unworkable, we can always just fix it on our end
especially since the fix is so trivial.

> ---
>  checkpolicy/policy_define.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index b73de45..f8c4d28 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -6050,6 +6050,8 @@ static int define_genfs_context_helper(char *fstype=
, int has_type)
>   }
>   memset(newgenfs, 0, sizeof(struct genfs));
>   newgenfs->fstype =3D fstype;
> + /* ownership transferred into the genfs list; do not free on error */
> + fstype =3D NULL;
>   newgenfs->next =3D genfs;
>   if (genfs_p)
>   genfs_p->next =3D newgenfs;
> --
>
> I added the patch file. Let us know if you need anything more.
>
> Thanks,
> UCSB VLab
>
> On Thu, Jul 9, 2026 at 12:05=E2=80=AFPM Stephen Smalley <stephen.smalley.=
work@gmail.com> wrote:
>>
>> On Thu, Jul 9, 2026 at 2:57=E2=80=AFPM COMS VLAB <coms-vlab@ucsb.edu> wr=
ote:
>> >
>> > Summary
>> >
>> > A double-free vulnerability exists in the checkpolicy source policy co=
mpiler's handling of genfscon statements. When parsing a new (previously un=
seen) filesystem type string, define_genfs_context_helper() transfers owner=
ship of the fstype pointer into a genfs struct that is linked into the poli=
cydb's live genfs list, but fails to clear the local fstype variable afterw=
ard. If any subsequent parsing step in the same function fails, execution j=
umps to a shared fail: cleanup block. This cleanup block frees fstype, whic=
h leaves a dangling pointer in the genfs list. When the policydb is later d=
estroyed via policydb_destroy(), it frees that same pointer again, causing =
the double-free.
>> >
>> >
>> >
>> > Version
>> >
>> > 06159ee35d6b4c968c1f942c9361c111644de826 - current version
>> >
>> >
>> >
>> > PoC: Please see attachment
>> >
>> >
>> >
>> > ASAN Report
>> >
>> > =3D=3D2502=3D=3DERROR: AddressSanitizer: attempting double-free on 0xf=
c1f82fe1330 in thread T0:
>> >
>> >     #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId: ea3a1=
d5343a0633f08393e738125b8f44be83f66)
>> >
>> >     #1 0xaaaac9ffd49c in policydb_destroy selinux/libsepol/src/policyd=
b.c:1596:3
>> >
>> >     #2 0xaaaac9faf758 in main selinux/../repro.c:11:5
>> >
>> >     #3 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18) =
(BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>> >
>> >     #4 0xffff83c63058 in __libc_start_main (/usr/lib/aarch64-linux-gnu=
/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>> >
>> >     #5 0xaaaac9ec7c6c in _start (selinux/repro+0x47c6c) (BuildId: ea3a=
1d5343a0633f08393e738125b8f44be83f66)
>> >
>> > 0xfc1f82fe1330 is located 0 bytes inside of 2-byte region [0xfc1f82fe1=
330,0xfc1f82fe1332)
>> >
>> > freed by thread T0 here:
>> >
>> >     #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId: ea3a1=
d5343a0633f08393e738125b8f44be83f66)
>> >
>> >     #1 0xaaaac9fc8a60 in define_genfs_context_helper /selinux/checkpol=
icy/policy_define.c:6163:2
>> >
>> >     #2 0xaaaac9fc8a60 in define_genfs_context /selinux/checkpolicy/pol=
icy_define.c:6171:9
>> >
>> >     #3 0xaaaac9fcbc1c in yyparse /selinux/checkpolicy/policy_parse.y:7=
87:30
>> >
>> >     #4 0xaaaac9fb95b4 in read_source_policy /selinux/checkpolicy/parse=
_util.c:70:6
>> >
>> >     #5 0xaaaac9faf750 in main /selinux/../repro.c:10:5
>> >
>> >     #6 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18) =
(BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>> >
>> >     #7 0xffff83c63058 in __libc_start_main (/usr/lib/aarch64-linux-gnu=
/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>> >
>> >     #8 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId: ea3=
a1d5343a0633f08393e738125b8f44be83f66)
>> >
>> > previously allocated by thread T0 here:
>> >
>> >     #0 0xaaaac9f53a4c in strdup (/selinux/repro+0xd3a4c) (BuildId: ea3=
a1d5343a0633f08393e738125b8f44be83f66)
>> >
>> >     #1 0xaaaac9fb9aa0 in insert_id /selinux/checkpolicy/policy_define.=
c:131:10
>> >
>> >     #2 0xaaaac9fcc744 in yyparse /selinux/checkpolicy/policy_parse.y
>> >
>> >     #3 0xaaaac9fb95b4 in read_source_policy /selinux/checkpolicy/parse=
_util.c:70:6
>> >
>> >     #4 0xaaaac9faf750 in main /selinux/../repro.c:10:5
>> >
>> >     #5 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18) =
(BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>> >
>> >     #6 0xffff83c63058 in __libc_start_main (/usr/lib/aarch64-linux-gnu=
/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>> >
>> >     #7 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId: ea3=
a1d5343a0633f08393e738125b8f44be83f66)
>> >
>> > SUMMARY: AddressSanitizer: double-free (/selinux/repro+0xed518) (Build=
Id: ea3a1d5343a0633f08393e738125b8f44be83f66) in free
>> >
>> > =3D=3D2502=3D=3DABORTING
>>
>> Thanks for the report. Are you planning on submitting a patch for it?
>> How did you want us to attribute the report regardless?
