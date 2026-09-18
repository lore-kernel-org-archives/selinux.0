Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A947DD42
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761759; cv=pass; b=H2p0I4tdExEzBIDp8BaEIpdH6MrxQBNcNX0Wa+8MYsyxUTUvDLiuJM9e+YBgGbMzOn+iJX+kuIdd+3qqGc0XcDzHKMJSb84WtHKRDUBhFmzWYA2vIxwMNRDL1R600CqyasW1qBRyg24RvTpoHzFHuGghUw5jfm3CN4HI8Elfm18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761759; c=relaxed/simple;
	bh=QOlSMP9Cogr9aOol3U9+h7T94a/RlxF8NiWoR0MA8MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+HbIc8+KbuaigPUcCUAAfqf+mrY2PAZGdAszuh/Bhs9lIUU2GamEeqLvdzjucdKG3vnin05enMEdNCE/FW8ZPzaB7DHgbqCRX6qrd+5LHzQKMGvIt5w2T6Z3A1Z4rj83tABZltX5lMzJ/WnQ2uc6hVocyDbUfSVsTIy78z4a4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N63bbJuE; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N63bbJuE"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6bda350b708so491496eaf.1
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 13:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789761757; cv=none;
        d=google.com; s=arc-20260327;
        b=O6GTpBRgUpOfbHqdc4cm1bNIuduakhp8Cxcw778SM4+GEtUrkLcfw3kUSH1MPqCyKY
         wuSWJkNBe9GCmHRb+1nL8PoKt8NKxap/gF7JZJmqGzxf+rWM12d/NkMYwdXqlpVEFHkY
         4Jnw31gTm9TTtAnChKrmnf5uQBXRyrtmWO9Jeqtdpu+uE+ZArkxjcQ/7YzpfHBethBlk
         XbDWqBZ3tnE4l59jvmumeQ3IQtP2vJJrWgzmbCtumvI01Bha3wkolDK1HHly1ey444iH
         gBImuaOEjM7TmFSWBFdPtEjHKj1GEsTUIt1GGgWUGtRcYQ3IWpALxW9FdSj+kVXb42hN
         6nTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QOlSMP9Cogr9aOol3U9+h7T94a/RlxF8NiWoR0MA8MQ=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=R1zWi6VVIVF9kmteafZ8vhDq8gbctYxk6KCgWPsClZ1bFVFOo//Rj4xm4wK+QPQd/d
         NelB97V32/itSudFrLaErwER4isG6NI9WSo/Vu9ywkf6s2mM0lkUcO1qXspdggynUdNx
         Q8+nk34foNFC/zccm0UrhY6XDb08PXUMsDDK/R+mme4Ua1koR4nwRut2GFehVlALRJ55
         CUF2ID/YpLCIC7qscleyLWX/0KVYhLfSxxDPrgQcHdZreG1yXSl30GQoOUNPrCGJ4dG1
         kchT4UleBswBJYlPOKgnpi6x0WfLfTwNQJ4tcA/orX3nEtvY9lRldbU9nuXBwUCwO19T
         XQZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789761757; x=1790366557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QOlSMP9Cogr9aOol3U9+h7T94a/RlxF8NiWoR0MA8MQ=;
        b=N63bbJuElMgQes55rhk9WApJbt1jW+uxZCLmVnuuaPq8zE07cYr+LK+e3DCqk673Ak
         pjAJ60saFkyw7cBABITp6ojIeUhflCSsh1o9Z4nHIzVNfua5vcd5oSNEGz+h5NVY4ug9
         Sy+uqQoIJfNKSFP1qA7Cg2B28KXUe/zLjH8AkY2tBH15hpRnbzCPkjMk178fbPJM5B49
         VftS89/83DvV0byO2YPvpPrQexN3Dix4L/Vmsq/CT3RPmTtjyDOcIr0Fv2euJwT+8l8C
         +DflYrXO8WxJ+O198/+tsOoHGGCdWwCKmrr16jjf3Wim4fTjPLs6/yIS9A85jA0oN9EA
         TTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789761757; x=1790366557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOlSMP9Cogr9aOol3U9+h7T94a/RlxF8NiWoR0MA8MQ=;
        b=qdVRHoCXpKGTGg/wp8MiAcNPMxGycMKq10Ixz3ZFUi7jTlUSH8IOOIHnBT1S5Vt6ir
         V0Ki9e9zXkW3pGhyfR5LEGyow9KKXi+1qsVhJaNQ/2NehVRgPIxT1hiK/4G4LGPDgXQD
         DXAbchpfQVjwU+EXGFtV3aRAIxtcBZKDAU3QTlcz/RKKVrVLKX8LnQ3/x+6n2MVGMMNX
         1qpzuGypREDk26GOxIXs1UgRb/DHqOBH0x4NyF3t4t19fvpquwSR3K3ZQUz8o8zsd+uI
         08ot9qFhrDQ5H5oQB/mUeB+V0PCUSUYkeh8L5HLifGOE62vqFlI/2T34W6CUaDq4a10+
         RCOQ==
X-Gm-Message-State: AFuF++mJ4cXvQctTNmtCDNOOB8Oz/XVd7ow4tNHT/lm0KVTqdu0r6eCY
	UzISO355lBUNIeDZ836TSiNKl6KxtXHGXbh+uFPgBYp5eiGCdSEMIsHiB+j0f+TaKdi/m5nK54g
	eXo/mSncigR7sJuJ2cJKbz5cmSyIOeQgPOQ==
X-Gm-Gg: AYBFou1XR+U/qKMeMMVcW382VPypQEtKuTe2XJpVU6l29oyvjMBqhH2nQtzo334Yz45
	ikoKdvBPJKEW+9YHa7KiB04sus+CtccXNEKbO6I7iICJkkcxiVptHhUROuzXXzLm5Uljx9QqgDg
	CbXqhOGuRK63lMos9/+tCkP7NB6w5aDRmtedk+08KOIoQp+JqRgBQqJOTsuuVA03ccA12RzoUaq
	EFAgPT/9sdAgMcDs6zdt+qQhcE7zUZWtET9aDKETolIfR8/6a2X6Mru5h4CK2E1YwUFEgf1spmh
	3KsdD7s0hvb5jVQ7E7VIumBYkn8xC2EWL+awxUCHt51uiqOT5GM+/Jyy
X-Received: by 2002:a4a:ee0e:0:b0:6ae:ab01:9199 with SMTP id
 006d021491bc7-6ca9c0589cdmr3810244eaf.34.1789761757262; Fri, 18 Sep 2026
 13:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918153118.20298-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260918153118.20298-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 16:02:26 -0400
X-Gm-Features: AcwNN1UzfPAZOWJpR95n-ibv0EmIfG9JATw8FDMVSkw067ntJ7rB0lkYMu3BeuU
Message-ID: <CAEjxPJ7qLKhKh1q45fP6kTrvyxuauNvC+X1R1bvnMZgVTvy3Tw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: skip unrequired class slots in is_decl_requires_met()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 11:31=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> copy_scope_index() sets a linked-in decl's required.class_perms_len to
> the largest mapped class value seen in that decl's required class
> scope, and allocates class_perms_map[] out to that length; the
> intermediate slots not present in required.scope[SYM_CLASSES] are left
> as empty ebitmaps. is_decl_requires_met() then iterates every slot
> 0..len-1 and looks up p_class_val_to_name[i] / class_val_to_struct[i]
> for each.
>
> If the base has undefined class values below that high-water mark
> (which policydb_validate() permits via the gaps bitmap, and which
> arises when a module requires a class not in the base so
> class_copy_callback() creates it at ++nprim), those array entries are
> NULL and is_id_enabled() derefs a NULL key in symhash().
>
> Only examine slots the decl actually requires. For decls that came
> from the base itself, validate already guarantees every i <
> class_perms_len is a defined class, so this changes nothing there; for
> linked-in decls it skips the padding.
>
> Reported-by: oss-fuzz (issue 562655132)
> Fixes: https://issues.oss-fuzz.com/issues/562655132
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
