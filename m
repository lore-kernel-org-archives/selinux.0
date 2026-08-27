Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE72E7BD3
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844349; cv=none; b=MJe7Nb5wdbByrX50k6SsRJKBnJZTw/mB3UClzr43coZPX9VQ0mk75b32/vyglVLpyqPTgYfBvAIXQSk2GtB20ES5upCwIKWtjePYFYRhqgN8btKp0egBiNG1xJ8AVs8iRtNOXlJD42ovq+K6ax8AlbfsIPndeDJdquPP/SLQPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844349; c=relaxed/simple;
	bh=h0Vzs2r/3RwOYqsBLsoorS72nh/UBxuO4uqgqn+XKFk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lNp9m9Wx6KdYZ4YBB7uFxIdcygJ4hlF16XHyjI4iE1YuNVPNoWQE3V2si+ZExg2+3jHyDyWqZDIiAumVEnVIxl/UvX9cer3IU2BD2Os/qe/KoX475u+khvPXHwoYmU38l4ZKie4Dh5c8RdjXE8LtgTbLZCMVAG7G19Ud4s2/D8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Kmg9qBVo; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Kmg9qBVo"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-936e8bd9caaso176998885a.2
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787844347; x=1788449147; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rwxU2tltaORxkPVxD18O64trI7QtofAnuDkRMpLy+I=;
        b=Kmg9qBVoUVQSK69+pLuHbQDGN1sWiJmxZYeCy4R+xUO5oseGu+XE+xGZiQeBHya7c7
         Hb6VyRl5B/gTu65fdCHBnwWuMquDkUk9bQHVqN68avLrfWef1MamxeiYCJnByLJtI8sr
         r+kHG79Ih8awfQG6H4jkldiQVBTbDnZqDpg2f3Ukr1nvWjs5eMyZ761MzQz3YtSK/6uv
         OJ3g/H5IL/P3rHXyn/mthmHLCfe+lo9VxDsJLEZmFwDrPrtUm3oHIkByPI9beTMSXy6M
         RVti1tR01XzIXqdcEnFAdegA2BFjSmfbOQ9T0J74jkBmAI7rpkhbPPb1f6Q21JmwUzIo
         MNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787844347; x=1788449147;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8rwxU2tltaORxkPVxD18O64trI7QtofAnuDkRMpLy+I=;
        b=pIhrTMhrVaMH8HRKjo4e1TxVA48PtiegpeQ0chO5tlv/v3iaZRqJ4nsUea+73cz74Z
         zVQQ+ARAcCTxGwVqnNge8kgJ0GHHGtTTNI3zjYgx6J+JL9NZjfu8X2OhTCi2n4or179X
         f+bDzKLcnsU02L5NGNgDYH0LQUWFrGfHt8P6jQwSCw+uYtlNpn7RpAhNFvV/fUWGC4i3
         Q2XoK5BCMLZacKkp2hWfdysOplqxZchRVrw9qLTomQIWWxkGZrE2Jgv7G5UOgVzd+BZG
         1QCW7qlTfVIx4YKYRrsAgcUZZJvDDXIHJuag6D0VVqcnUSDh/IutRgHX99qmVe/c+jNU
         ThIg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/O7Yh4dTOb9TBr6IfT3jjgliYY0e6Uf5gMM6UoTLC43EOBscOQtAvRnnC0qJaKlQk5ZKJt0GG@vger.kernel.org
X-Gm-Message-State: AFuF++l+rt9QJEtXBZ45NDQ2kCsIKM3SbOf8/xhQHsnnX4TKqcmRv6Qu
	m8GSo4c8VMfRaGjo1Mnv2pZAbxPTrNtXK00x8g/h9CRYvjic7A3H2vgAhHnvJjUCHg==
X-Gm-Gg: AR+sD11FATBQDnC/0UWPGbsmaBkEumuQHtoehyqR53Yk+K59KFuijebQgW9Cl4L6iEp
	9YMrYbvFVPj7TfI8zAmleiFbwhNTKAMFBmqcsb0NbEVytmWXd9AjF2bCv8KnOoNNFRTNYNNO59X
	V/NxH2tGB6112LI39q9BTYOKiyINL8Ok6mffYAgWwkdMa0VCzGD/FIiPA32UEWDyvAUcQwNNIU0
	Sgw++ZVf3kxbBu2//qx6CF156AUuAR8QPRUYgFjUlS98e7gElxUfoyGG0648tLbpE5vpfexrRN+
	qWL9G90rqlIEV3H+SeW7IFQHXuQqQRn4vq+bjrK/M/SDmVcfs23oFl8R4Hh2pX6tMHP0uGyfokf
	okXvkbjVaaDMfKcKsWJDYvvRNQKOnxKYRRiKQ8EUEnaXnZR68Xp8EUVAGtgZCoLQsTzsZL11lcY
	i9SvIrIWYfsIMbxq1yhy9xtGK8H6VE5vwWjogyQzEdro552yAVhxTkV3S+YM8ZWRUg2BoAF41Wt
	zVTy9bfdRgeQQC8wQ2DUEgSpQL7h2HiAA==
X-Received: by 2002:a05:620a:26a9:b0:938:c176:b324 with SMTP id af79cd13be357-938c176b95bmr1265704185a.6.1787844346954;
        Thu, 27 Aug 2026 08:25:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e61a0a4sm466039485a.28.2026.08.27.08.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:25:46 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:25:45 -0400
Message-ID: <91948e3a164e672830c2fd1640bd7067@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260827_1122/pstg-lib:20260826_1402/pstg-pwork:20260827_1122
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] selinux: tighten policydb_context_isvalid() checks
References: <20260807191342.19500-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260807191342.19500-2-stephen.smalley.work@gmail.com>

On Aug  7, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> policydb_context_isvalid() bounds each of user, role, and type but
> does not require the value to be defined. A crafted policy can declare
> more identifiers that it defines, so an initial SID or ocontext
> context whose type is not defined can be inserted into the sidtab and
> later reach type_attribute_bounds_av() from
> context_struct_compute_av(), thereby reaching the
> BUG_ON(!type_val_to_struct[type - 1]). A user with no datum can reach
> context_struct_to_string() and thereby trigger strlen(NULL). The user
> and role datums are already NULL-checked further down but only when
> role is not OBJECT_R_VAL, so an object context can carry an undefined
> value through.
> 
> Use policydb_{role,user,type}_isvalid(), which check both the range
> and that the value has a name, in place of the inline range checks.
> The name and datum arrays are populated by *_index(), so a value with
> a name also has a datum. This runs after policydb_index(), so the
> arrays are populated. The now-redundant NULL guards on role and
> usrdatum in the OBJECT_R_VAL block can then be dropped.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes a typo in the patch description.
> 
>  security/selinux/ss/policydb.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Merged into selinux/dev-staging for now, will move to selinux/dev after
the merge window closes.

--
paul-moore.com
