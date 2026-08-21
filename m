Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6735676A
	for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323752; cv=pass; b=WGhHP1Sx44n01gKXS2vvMcq0uxvrgAdsnWWowEWc/Og9lFn6WA/6XuvlbJwcRxmI8U8mU1lMD+TljJNO8HKrNcEru0BS6zcj6VCdOAIPwgPtxbYO/nzLKGjz42z/aBlBJMvkw+QXV5ozvrCb7LJI8TzNmm1skS1xJ2RtXHAtIMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323752; c=relaxed/simple;
	bh=e7lZBlf4BQjKWZ7FXBRUvZEHvETpn0y3fvgbNkdPxwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AL1q9llnPFITYjonq4Iw/Tq5V3f5sn1m3HF8HH3QZ64Gomym5f5friqwMhHNnUiuV46z9bjooG0UnTlNkgOl2e4zDWqgp8hpLkM/tGq6jKkKoZnKMlQ0I9X64ljzlpPP/Rsxh3nbvBUSPwR+ZE8KHGAqPZIkxUc+5lQ1Wm44xSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfjl0MYN; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfjl0MYN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cede6375caso101115ad.0
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 07:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787323751; cv=none;
        d=google.com; s=arc-20260327;
        b=bf/yG0xttGSPCbxpyU1BR4f98RBTr1yPWM39gqdty05DgAgpPcBfOXcrVYjtMKq2H7
         cVYylRJ0e+16bTPJssxT94EMleFRtHBjY/dAjEf4jlPh7ZJmAKoeFTlJqyN1LO6mmSCC
         KafhV20hIvXhZUlFJGAVKdgT6vUJrmGDcFV9tXumEQQ3S+aWGEJS0/6IWj/NGVTsJDCs
         DVnQPTPEXrwzCbbShyLuRu/Yp3xv0QxGPVGjrsCjdYkUXgHhFY2pHYGJy/POyvYSIknu
         HZtcMqjsCL44emWCIb4TYRUgeaqm6m7p6rn1ambauykw+gP3U9tK7/g3miNoyQKRHCkl
         pzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vlc/iU0BEBi/KNin4z6a2IXssoOeWKNQCCK9ZmekGRI=;
        fh=b2fV3Fn7DMUyNTFPz+EY0RCKnX09FVNs7a+VjFyGSfk=;
        b=aqphAMPmu0TKxkfkGNmM2AuHv7BfcwHOSeGoNxB+qoF42uMhK2LiV7YWP5VjGmyGOx
         cs4it5iBl1sPWVHIn6xCCe/MWC6qbk1JVQUQ4/+PHKTa6wGATJrMfqomffmCFfmSaI1F
         3BD8wW2jBrT39NVhiWBlGTnufZnJZQxrYTS5JUoEHApRKsoVMMH2pwf2sG8dXhgMy7eg
         oKvtQfcOjuKpPYhnX/UEn40qYR/S29Mva6mOd24dtH5zE6FGIQVItbwFgr0yjluoM5RR
         OQaH96ECKmxsutvARbyjQFLdxqS5WqJlX7vSA/N8hXhyZYMN4pm0kUvS6c5N284qyEDe
         TTng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787323751; x=1787928551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vlc/iU0BEBi/KNin4z6a2IXssoOeWKNQCCK9ZmekGRI=;
        b=nfjl0MYNhwStfkYy8/CHTnFDsoMZ4CVqW2rtTKJlAbbemwhyF5xS6dd7yTgR2Q39q3
         TTHgoVR6lZwYqmPkQNkUAKHsnwrgCrIjquDbQFjoSzQi2HLOU25WJWNe8bWtZEXr0++Q
         n8ovWBvKdDvsuXSu3wT+AZqxDQ08QXVnnByhhvSbRd1uh1Hkawc+b2OmMOALI2ihZbsC
         k8dDAXRNmB4+oOtmA4H9ul2iUAp9Wn5SI5pepMHPoYRoWIf9hMujbM0MuZoFCpqaPGSB
         wVD3zj1ABw9iufj1HY6F2kmJXZFqR9/fMLme2LHClPCNKFv4K+pwEr1pOloFXf0MGCnr
         1SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323751; x=1787928551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vlc/iU0BEBi/KNin4z6a2IXssoOeWKNQCCK9ZmekGRI=;
        b=G1A8zCpOfvwfFeFAbVWEY5gK3WZVzqARwreaTymyQ05vnAkCsJuILk10FTvnOaLYTa
         TjubC/TyPOTT3GU3oJExuwCsBfiWhiuEBeVCYwx2RHIZmGLSAlTvEBvZc2PwtP9zq14b
         +UQ95106WsrlRV0XINRYlmqtJQBBjrnjrqqmK4VM79xE7/5nf35NMYYNdhOC2tES7tyF
         v1+L97hysCCYeYX+T75ONdGF5F2ISG/zlCQCzgb8MFqWPiNY8+z2dgLzlbKSKQ/a8ReR
         aF/0dc+++OcyaybwAY/JWpY01zTSHQFYO+FN0Dwzepb2mVe6oaHqilKS8IZqKZXHgAtI
         /zZw==
X-Forwarded-Encrypted: i=1; AHgh+Rrhv7qnj57GLEJCOkobwDgeKhVygt8wzBGlbyBqOcADJDExrGWkw4LVTurpWgmiD0JON5hX1Sj7@vger.kernel.org
X-Gm-Message-State: AFuF++mcEJBm5/KN1E3i28daZwA6PC4WFpklhp33yY34DO9yPMYC/Q5U
	IBuVUH+ZGJm1UzhV7h6RaA+rU9bHVfT+13aurgBixwiYHXCuVmo/rxoKjk1GlcIcXb5lPPoXSXr
	SJmUkc8wa4P+fxb1dVytakDBdgnqwBWj8xVWmzT5g
X-Gm-Gg: AR+sD135BNDexoH5Il05oRsfkEs58DFVAHn9qCYoOS8c0ZCcLoGka1EGR505tvDEshv
	cRSIkRcfJEJt2ClLFizqkxaVlnP138D1nJL3zISoPvKNRK1jdhPbzBiu+5A0blzS3Gp0a1oCbkU
	pSd84ZDIYktt/LQFCPlcMgNI2gH5yLkkPi3uzpUE/zhKPEr3RbSJHynJLWWHr0i+s4PMzsI0xAs
	0qfrhLxLZJuveWq0YUpl5aZlqK0CBPgDCKw4CFi7DmUd1MlegSa1adKBFCH+1Hs06dQLPUir5lC
	rzcmGPFjS97XUb53F2nKlJofZu5XJbrFRJcm8zzGBV+q+DDRW4r+nFTCOacIiYrpIJEj97mUxIj
	Zu4ta4Tk2JHTjlE6OwsdVgibPtF36w60gRs5145g=
X-Received: by 2002:a17:902:d98d:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2d64b0242damr7580045ad.2.1787323750012; Fri, 21 Aug 2026
 07:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com> <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
In-Reply-To: <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 21 Aug 2026 16:48:32 +0200
X-Gm-Features: AcwNN1XIz1KzlKUYbPV7VaC7KEh2VkyaYQONO-MSpK_iCwFkMVBjZQBPINMVB_Y
Message-ID: <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 4:19=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
> On 8/20/26 20:44, Jann Horn wrote:
> > On Thu, Aug 20, 2026 at 7:22=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >> On 8/18/26 21:51, Jann Horn wrote:
> >>> If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently h=
ave no
> >>> good opportunity to block a process from overwriting read-only code i=
n its
> >>> own address space through FOLL_FORCE writes via /proc/self/mem.
> >>> The security_ptrace_access_check() LSM hook is bypassed when a proces=
s
> >>> opens /proc/self/mem because this is considered "introspection".
> >>>
> >>> This causes a hole in SELinux EXECMEM enforcement, which tries to ens=
ure
> >>> that a process cannot create executable anonymous pages.
> >>>
> >>> PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> >>> accesses are only possible when the LSM allows ptrace() attachment; b=
ut it
> >>> is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> >>> environments running lots of third-party code, such as Android.
> >>>
> >>> So, introduce a new LSM hook that can forbid FOLL_FORCE specifically =
for
> >>> such "introspective" accesses.
> >>>
> >>> Signed-off-by: Jann Horn <jannh@google.com>
> >>> ---
> >>>  fs/proc/base.c                |  6 ++++++
> >>>  include/linux/lsm_hook_defs.h |  1 +
> >>>  include/linux/security.h      |  6 ++++++
> >>>  security/security.c           | 15 +++++++++++++++
> >>>  4 files changed, 28 insertions(+)
> >>>
> >>> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >>> index bec6197329dc..3dfaef49bb70 100644
> >>> --- a/fs/proc/base.c
> >>> +++ b/fs/proc/base.c
> >>> @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct=
 file *file, unsigned int mode)
> >>>  /* private_data for proc_mem_operations */
> >>>  struct mem_private {
> >>>       struct mm_struct *mm;
> >>> +     /* Was the ptrace access check bypassed due to introspection? *=
/
> >>> +     bool introspection;
> >>>  };
> >>>
> >>>  static int mem_open(struct inode *inode, struct file *file)
> >>> @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct=
 file *file)
> >>>       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> >>>       if (IS_ERR_OR_NULL(priv->mm))
> >>>               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> >>> +     priv->introspection =3D priv->mm =3D=3D current->mm;
> >>
> >> Is the feat that the fd could be passed to someone else that would the=
n not be
> >> detected as introspection?
> >
> > Yes, exactly, that's the primary reason why I did it this way.
>
> Okay, would "opened_by_owner" or something like that be clearer? At least
> "introspection" is less intuitive for me.

Ack, I'll rename it to something like that for the next version.
