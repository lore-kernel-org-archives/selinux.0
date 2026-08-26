Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1CF4229BA
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775253; cv=pass; b=Vys1BgzRsu8KfZB4T8a1EsWuwzt57yGKdb/BSAFbuuTNCTOW7k+MgMMCnPY3iMQsn3nUsptrMB/59vZRuZki83LhdDkIW6l2go1hgk7t6Ut683vR5yoUAEEwebyTMd9cwH4em1alpvhSQbuCrDL3n4yItRohTs5u8C3e+49vSlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775253; c=relaxed/simple;
	bh=j8xhbpA/27L2ybX+6YCuhJ80gjjp3ZjZjRDcDBqtl/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OB7ZfuMv9YzCFyT6Z9EITVeJloMcLJl1xVVKAq0LOGQENgFQQ1CSv9/zzKwiOWWbaI5wDT8tpUrMb+wi1cnLwCGrG2pG2WkMxuqiU19LZVrfBAecAjPXyLB0Lp9dRGtdr2hLBG3Ow27pOTYefILXazptLzSy6V9xtuuPfRheVqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD3VOp8D; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD3VOp8D"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43b7e186a0cso831833fac.0
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 13:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787775251; cv=none;
        d=google.com; s=arc-20260327;
        b=kgZvrH/j9ts1sXgZZTVVg6GC0jclV2vFGO4XfyzKU1FhsBs0tnUzFJsTj9MbGVPf73
         zFE7LtcxMLFs6Z9Pwy5pi2LmWOFpc9vLZmn1ujZ5iOqnJKVuKJ9DaqUC6ThN/a8rCWoK
         /GCDsKVcdAZO/C2Tv8JXpIOfUxSLZnwLfaTGeT5buFtBDtEqXGnhaInK/7RuhFs6fBfZ
         3TvicZKynsurYPgFPvP4FsvhgyrKmRct4gZgM6wt/qm5ARUq5EGsOSTLOvI5H8YXQEwt
         fDGGX+EMhHG4rRVu7lFL63LPZMlqjXDVpNLAnsuhDq353nRuzMZ00kxA/mRc/Rk0MB3p
         a3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TchWu4bA0zSxKVrOO3vxD3Nfx1MZiKP1iSjNUpyhHfk=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=fYki8YUQG5k/TlQlup9MIvjtx7B6l5VWmIJ0tGYPTsvUsjjMf07IXjivHDzB1cO0bc
         jaq8lpNATuDNTv/+gR2xU9+PCDKNACBDo/QLy1R8jQ2cwh1bl0VOSJAY0GwbUwm9PZ88
         uuxIVppaJcCDvOCwBkDzCIq2ry6pKIJzzDQF78sAkiICfBME7tjSy0Zhd2HB4bdQZl/i
         9N0PPa+IzVYqzWSh+hTN5a7J+Gw7JN8lOLZprK6jRKwviNX/2LjA8SDgZyViTXYjzkfY
         3hGSTHCLCTz6V7RuBRMavcnpn1zHVNg03o/4LWAcuLLV3Y1Ky3ZBP6C48kZlhBg576hZ
         WDDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787775251; x=1788380051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TchWu4bA0zSxKVrOO3vxD3Nfx1MZiKP1iSjNUpyhHfk=;
        b=ZD3VOp8DKAb3mVkJN2GVWBfzWvyqW5PkX9wtbHNMEij/2YRBYQIbD7Jzs+GNvEaE+0
         ZmEkOUJMqv0DaacnqZlGZZTGJZTzULGMNy5iPYyiGujY1gSwW+YLaocF1sLX1XJ/zIYB
         pf2FMcoH6fA3Imjf1H9jIdNiK8CDzQ0jmXbcuu/ChwpP+IBaiTxYe90KytUZ4Bz0va5a
         PYbKRT1c0dL5b8yz+7kIWhoyMSGs5H0h5E++5+YaU39MsBQvDjLKfiz8X06yMWmbeYyx
         fnry3YmbXEVM1VInM8z7KBPPADbeAbLEwzg9U86NyceDeGbcVeq2YWS2P/Tg/dryAZkD
         L3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775251; x=1788380051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TchWu4bA0zSxKVrOO3vxD3Nfx1MZiKP1iSjNUpyhHfk=;
        b=FGiRL/KF4OFy3+biqtBuc3gLhDYluQiFyuesW2MMIqC7a43oJJRaIjeJaedCUGEVH8
         re1xdPCGLJCer2kIZf33tBvuad+E5gudS5FaJZIPKqzFFhE+7Z8ypC97WRazZPsRa3I+
         btGPy8Z/l/imH8lPQue3nGVU7OVJBDbXTKAyvb5nUyVbnU5CJVm+iiWP9DyExNy4o6t7
         0z/vv2dhhwuhZl5/QOCItrouyaFDkQ6GLO4pYYI36tE3IkkWpYOsiTHVmMsrNkO6qGrX
         wWl5LpellkvQtvmkwPwEbMHgOLYDXOX6woSgsAeTTzNqOwIXd+vfSQHuyrlT629YTv19
         zq8A==
X-Gm-Message-State: AFuF++kBbi33KUeRh7BcevCIV0Px92fH+YbdBkmAL0cAoWPl6vlT/GEf
	WePCyPI1GhxDTkK2GWOfNFf7VlYPt9xK26f2h11GMgTFx0AwFSQqow0IDJaKxsCKo1f2wncyPXm
	m7oqqVSlPQyXnoh1Ej+8th6robsaMpPk=
X-Gm-Gg: AR+sD11pDKrq/5sRwO19n2BuSP8q07E6XaO0NFWMs4Mip+gWmOsNutK+CECvZ9TdDrX
	djDkDXBKmIm4rO0U0a7oG/qYGqlLL/mSXlMcJMRU0x5XIsF86+DESl/afq+watUsWeaw44DcXDQ
	brGcvh8VPmLuPffuXHr4FT9enaZ7VN3kxVkl0zSEnaAoHnr0Qtl8N6oDXKJ2y51o6LTQVPmL5LN
	0JoZXV+a6d/WaTIykgNytwykVxThUteeFm1aumYBk9GBqUU0YE6KdTmamr7dqpwAsDiYp12Aj6B
	pqZ45Cg+GMkft7c5Pn8OAt+zBN0xBcsVWHJEwe8chbSk
X-Received: by 2002:a05:6870:6b97:b0:456:772f:682d with SMTP id
 586e51a60fabf-4659b7c7f19mr11177361fac.19.1787775250964; Wed, 26 Aug 2026
 13:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825124629.84128-1-stephen.smalley.work@gmail.com> <CAP+JOzRDnS5KxRUVJGAk6bS+aHdZa71EtyxOO=HovpgPtJ6T2g@mail.gmail.com>
In-Reply-To: <CAP+JOzRDnS5KxRUVJGAk6bS+aHdZa71EtyxOO=HovpgPtJ6T2g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 26 Aug 2026 16:13:59 -0400
X-Gm-Features: AcwNN1V9mbLBgyVpQDoNK96b_be_9RjUZIl17s35s8txab27BUVfuTxMNdbvf9w
Message-ID: <CAEjxPJ498t758VMi6DiwpEsz43zCSKO+Ert1Zk5b4LUBimgsQg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: do not infer name-based bounds for attributes
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:28=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Tue, Aug 25, 2026 at 8:46=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > hierarchy_add_bounds() infers an implicit parent from a dotted name
> > for every entry in the type, role, and user symbol tables and stores
> > it in ->bounds. Type and role attributes live in the same symbol
> > tables as simple types, so an attribute with a dotted name whose
> > prefix names any existing entry has ->bounds set on it. For types this
> > produces a policydb that fails policydb_validate() on a TYPE_ATTRIB
> > with a non-zero bounds, which oss-fuzz hits via the checkpolicy
> > fuzzer's explicit call to hierarchy_check_constraints(). A minimal
> > reproducer is any policy containing:
> >
> > attribute A;
> >     attribute A.b;
> >
> > or:
> >
> >     type T;
> >     attribute T.b;
> >
> > Skip attributes when inferring name-based bounds, and treat an
> > attribute-named parent like a missing parent, mirroring the flavor
> > checks the explicit typebounds code path already does.
> >
> > Fixes: https://issues.oss-fuzz.com/issues/550672317
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
