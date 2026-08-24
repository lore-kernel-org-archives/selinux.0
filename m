Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D244C65B
	for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591204; cv=pass; b=aSDvrsBzSJv4Ohgdk2pXaMmlWgonOHK7T0F44AHwOAFnTFXva1HmK13dGqzz5FttB0KXl1y6mSlxbYOVAvum1scZXdLlRHRzTx1THYW+uD1LwAeyzZVASIt4Ycpk34vc1TpjCAGEIGRNcLfg15CmtxRTE/Q/z+8zPuzA38XaYGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591204; c=relaxed/simple;
	bh=RetglhChGs54xh+G4sIllqLQaZbHa84fR8ti4Eb52Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKb6+N4RRda/+xVrCC3HnEB7TNwPcaItDVWz4lSNbXZYdZT/5LDzIqt8Ccg2vLwOBWvp7/RrwBGBwopqbGtkw82hftBKlQYUhBb6dZEkQ6hos/uhKb9FN0JRsNQkM2A5nPZ31lGPMvxaD7Sk4goCtcMrMQIgxge0VE4pkPKigIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo7CX6da; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vo7CX6da"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cede6375caso5025ad.0
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 10:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787591202; cv=none;
        d=google.com; s=arc-20260327;
        b=sKy/tSDdTLFAiDTOiow5WOySclQoI3yn0UknTUNSSc6CJYXouggX7UAAPtoC5cFMfg
         IJD0J0LB6UnbN5deLXpYTmX5Hm2Zo80Z742/ZtYhO+8CcUd5FzYIopp1W3JKrA2h9BU+
         ZwzqfPEqftdXqLQgtF1VBqfdt1yFjAk5RJTCRV0AVcRc13GtoAZQZsXORvRZznmQqHKj
         3UuRbXCeQrATwbSPCyB4oSfbc8KTuRHaTGq024MqU5l7rsoAyig2b2RVGhH+pQpc+PaX
         CPn0KtsUIJMriPVRJRqmvDRvz+j0kpHm1kBcT1Inv6VRpoLMMuYlOS9sag3yRdJMpSqg
         M9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wBrui9oca87xmLJo5FCru/sywwEnBCWCZyUpBYfq9bA=;
        fh=COY+CXKcdynicNuCxINSxNTX1gZel9RfOhhLr/vOpF8=;
        b=qwxOGAa32nAI3wAa8WNGefomCmZMa76LBuRiCPU3EIBPClgn9PXiBOMtpqgAGOg+iI
         9E2kQMPzxEXJUfrlrZGqGfK7hgTde/zEM5lwBJcz/egWaRrpEDktg4yxUmDPv3GmYQn4
         BPCTyEqxPPBvCaGFA1kX6VjJ8OdQZEOW4zCDWYwg2D3noamybqvphOba94M5NSKSdNHn
         ueocyyaMjCn7xdEiGg4l1wzgEwEJt3ZR8iTpACqLlG02ugMJ/2z81Hw+zcGFoslqXNSI
         aJFPu1TID8fX9lKmK2ty2k8rlutU68vCNHsh/4lg4V9sQ+qYxXu0sO/Aie6+eqgcqjH3
         zWjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787591202; x=1788196002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wBrui9oca87xmLJo5FCru/sywwEnBCWCZyUpBYfq9bA=;
        b=vo7CX6dacDq3q2MBn4zKHTMEovNhzBuyfUC2ySAhPRikC6MgthlA3DcavDh0Du4RKb
         vNhH+ry6oUFWzx5kDriVlQlsFp2awFoahbHruVN4841x5DU670ckNINOGk7vv2AsPCeh
         alykxwXEN/RfBuR1EjJ6cz+3lYDIyIE9QC4z6QOM2AGpwXiHZt40a3Z3m4/E1sDcRDW0
         15M55ELxms/ZwscMIDMmVi6vHmZfTtzu8VsHF1QzFn8lzT+6XO+FTdxpmK+6Lb2MuFEp
         RqqBhFwJ42yPIJgd023xLdyyb0vD/PeLT90/WT+PajJWfDK9UmFvIP6UHkzqWPhMinlB
         0sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787591202; x=1788196002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wBrui9oca87xmLJo5FCru/sywwEnBCWCZyUpBYfq9bA=;
        b=LTqgIzoGmdVS7KafR3pw7E8q3XnFyP9+PveTLiXA2TiHVtRX5TQzD3VEbK1X2a7q3E
         Ky39OYhZrEoESzh7fu1oeez5Rz8Dx+L0wH80HneY0+0LKljZ7RGqT8OYGNATqMHSgizU
         ivWYJXIP0rf909JAXp1Xlgc+G2bURp26p67hcKa6KH66UqarFVe0CpfYV6cngJ0Yisep
         aNjjsNnHfkD59S+TN//eBd8B+Dfr2dhqz7UE7QVZtGlmQPxhRVFVo7yLAUVLbJcVJNWb
         hArhAbA//SiZ5ZITTb3Mx5IamjyWJwFH3iuqowkJfBLjLw+Hvix4mudpeKCpvMp4M4UP
         fa7w==
X-Forwarded-Encrypted: i=1; AHgh+RoSBgkKD2RB6CDbggLL41dWKiDvWvNl3RNh/FN2tzO6h5bdyyTa1ie5Isosb0cr73E4jTnLBHxu@vger.kernel.org
X-Gm-Message-State: AFuF++k/RWtURkLrlplh2qBkNW9lQQ5vQi9NNx3mnntawxv0plSc3vJn
	gE52oDnvYUMjqFqWQTASukyzWsOKtvlegn5JWSD+4dzAMsMonAszyljCLUJeoeiWkUHx7F5rfbG
	gWnTx9rAOHft5RDacmQI3sJdRM03qyeB/pCvYpq6w
X-Gm-Gg: AR+sD12KFeHlCBu8xGIO/JIenz5H52cDMPA9gAs710UH0Ke+oBSvuEVTxfY3APAgDc9
	I7IBxGeUtoc9CLUzWpzZHqtQnApPQMFXlRJbSYdbaBXztQf8LIZhx7mA0LrPy3Cpw4V/euXJ6e+
	BjtP69vZUW/zmIZiBOJJvVhmwsDI3iacaYxNch4GodVvbP+69RI83fIp4mvIybekd35Q82SeqLq
	Zy+JK17Rm2OcLGP5h0wJNDFtibOn0a+p2i2XYGNsyGQ8/XlO9xw/3nhVvvlwiMCsC6z7lyWVxln
	xS68kWgfmoMZIqGIy833CU/YXvOzGrLxz5C49IaT0+vCdhrKWIOtIhv9W6XRNfjwCtUzXnBG92q
	0HWgFcF7sF7L4A9o8T1vOX7JM7BTvZmI=
X-Received: by 2002:a17:902:ced1:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2d673b9afe4mr10236935ad.9.1787591201205; Mon, 24 Aug 2026
 10:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin>
In-Reply-To: <aoibvf6CY99IXynk@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:06:04 +0200
X-Gm-Features: AcwNN1XN1HjALO-7sEAr3yIwV5QVslvlMZpManf5842ZQgDGGQ6V_1u_W3SFNwE
Message-ID: <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> OK so the whole thing is:
>
> mem_open()
>   -> __mem_open()
>     -> proc_mem_open()
>       -> mm_access()
>         -> may_access_mm()
>
> And:
>
> static bool may_access_mm(struct mm_struct *mm, struct task_struct *task,=
 unsigned int mode)
> {
>         if (mm =3D=3D current->mm)
>                 return true;
>         ...
> }
>
> And what this flag is carrying is 'hey the reason we allowed the _open_ i=
s
> because it's looking at its own address space'.

Yes.

> I did wonder if what you're protecting against is even a process updating
> execmem _it_ owns, no fd shared anywhere, as something LSM might want to
> prevent even so?

Sorry, can you rephrase that? My goal with this series is to let LSMs
block a process that tries to modify its own non-writable executable
memory using /proc/self/mem; I'm not sure if that answers your
question.

For context: In this series, I'm using "execmem" to refer to the
SELinux permission PROCESS__EXECMEM, which essentially controls
whether a process is allowed to create writable+executable mappings
that can contain anonymous pages. Additionally, it blocks creating
executable mappings of S_PRIVATE inodes. There are other SELinux
permissions for things like making a VMA containing anonymous pages
executable (FILE__EXECMOD and others) or mapping files as executable
(FILE__EXECUTE). FILE__EXECUTE is granular, it can be granted based on
the security labels of the process and the file that is mapped.

> The sharing a /proc/mem fd seems like that's a pretty dumb thing to do in
> general :) but I guess you have to protect against that.

Yeah, it's a kinda weird thing to do...
