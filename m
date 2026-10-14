Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44B5013A1
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982431; cv=pass; b=sPgL2BHALy6xtsoUIr1ByZuVKgTYl+T+1O3tzV/jEN9YUw6gjdiomvguBXFaxz5X+mi0c/iWx9WUJRgDIHZulZAlOYZPsCLGGqwUMsrIOUXIrZjBeK3PHHa/+KMDn3PqHH/wSX98ZAjfcdzjWA1UHq+6Kg2Ybd4CWX/V2JODv/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982431; c=relaxed/simple;
	bh=Fu/c1x12U/GRPvvmZ//u7a47hNtVOiHLzL63Z5TSGjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnyO69eHf5+IaQYrlTa9S7IOdFj74kw2B8Xiq39n6fncKbNgNG9VrelO+1ldSqeNSUdOMZGBrt9HMm/SrmAAnCQQkRzdcwc02LIwfmUFD+OMdsJtSWF4sVxeDGeQ7KRbKL3JYhwGx5ibA8CU7ja/SQIRXjaU/nSx8h6A6d3H/q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un+IAhS1; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un+IAhS1"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67699afea08so3203464d50.3
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 05:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982405; cv=none;
        d=google.com; s=arc-20260327;
        b=RIbkJX/XkGG5a81jvcpuJ6hs7os7O2lAXZ0izYiuyrCAaoxWWQvK2grplurnNETlpo
         Eyqt2y/PTpcCOHPuFaaHV0RkNxUyWtGxKnntocMOh7MdYhqhLV1+7wYq7lDZafaC+gou
         PQ6YmuvVN+nkyy5GAQ1TJAkuODO83mkm+Ndry3r7R/aMeaU4y0c0feBoK3l0tusRi1vd
         nXzTb6qgXGksjM5hjyqZA6KyZ9zA3c4nePUc3qxcETdnTcpicpPoOPtzRj8zvHec61HX
         Q9pxPGGXNP/gWpxx4QqCi2GBnKogo/QEAxEzsj1CJgDHlSHiD3LUNm+56k/nul6ijEWf
         z9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fu/c1x12U/GRPvvmZ//u7a47hNtVOiHLzL63Z5TSGjA=;
        fh=9CvfyTln6mlGi4sBe9JH0kMBicdx1bffQat4jneQZt8=;
        b=W7+LvMJzNcbQH6jF9PQarH9bagTiYgNwP62EJE22d+uT4zP5XgAOzKHpRxAtk/A9E9
         /W2rDpzIZJi87sQubapCkEnMYLQP4tS1ORL7545Cp+JBYvxnulEV0ObL08LqSkPiS73r
         fRUK5pdu+rkUfD85OgI73nicaLw8aDgdc7KabEvchMWqff22V/jAPXenhvJXYq1lNG7F
         /ka1lcBoLdRwUe71XhTwMqYzuRssSfuoW1o8/n9PNUck6pGXcp2OIfz+sPVfmFCfhBEG
         u4PX+py1P7sgk4iaiZLtq66ISTSIGQ3yia7pqXVR7IKPKtDIHuTaMASbSr0pl44BBziz
         woMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982405; x=1792587205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fu/c1x12U/GRPvvmZ//u7a47hNtVOiHLzL63Z5TSGjA=;
        b=Un+IAhS1TaKwoh0Pk+lRcDUtuRJ4G9JUPK0LKwZCyjDjiLGRDbKRUlzmDp8O9gTNtC
         5TnfZDAqA5hnelj1MSrtZM3VOJKBaeHpKm0oSeQd4XzpIF/APDESaU2FWdlA2Qf+I4hm
         lXfk2QBEO0i9YfJ+W0JkGrxUqiEouP2ii3YKm7ErE25AAQNPkJ7wKp0WolUdPLci38VF
         Gtv4frNg/sXJBcHj6zCYqZ1C6661EUpotp9Y5KvmhaoUQm6cmq5/LwM7iFxP04f0y//n
         nOzTRR3hKuxmy43ztybgoBP83Ma6nD3WPWFisjoZJAWK0loD9mifhc3znsuewN9r1NOf
         Ipgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982405; x=1792587205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fu/c1x12U/GRPvvmZ//u7a47hNtVOiHLzL63Z5TSGjA=;
        b=INo+aQUJQzgUs+/mP4vIBo0rJ5RiT6R+1HXjsRlWp8l8M2aapOlVMLzui17WO4ii3P
         auA/Gl7k3w8sXlFz46SkVjUBCB2QCDDi42SPAn9HxpCTSb9D3odcbWRJDKmlhYBy68h3
         mRZXNh1NySBiZHsncUslM064eBrCz3drvcuF2vOpbHPLE4jMFi4+pOuP7vB1zT84Xw+4
         3wuX9nStM8BjPwPG4YqIYr7RqkFtGoLXOML/qJ7DS4S5Wgrwn0R/v/IT7euGEl7nsrO5
         XmTkPqM7D1djXwwKsLMMXjmJlM5jBksAI7S+GLQJff7B1ggz6N6o3wzAEu1tBozTeynv
         iVJw==
X-Gm-Message-State: AFq9FYIVqe1OvBJBwQv3GXhhgTRqP/m2sOm4ySC0psiWm3Q3ZjDPlnNA
	ptAbeLPr8u2G3iSavdmAa83eWzdmGsi8h8TTgXiSX67/vzPGvDYfBx6W9X63J2QDPzg3juDbpZy
	bmoHTLsRLivweLexjvkOjs3qWO/VdMA7DqOJMgBE=
X-Gm-Gg: AYBFou22jCCLEuR20Z3RJrO9YBBp1dmrf+2jmDH4kr0bkX9Abg67a3iT4H/NMwCoE5Y
	X5Kea20+sh4dqLZtmtcSN6sTDppcEYQRWu7QmAK4152PVefeAECXuRQGgcXoZIxaBwnSlTw06EX
	ZHsnfgycxzaSkdXdEhspZtxvLaqRww3fNpee4mqnCIwn5SQwEFizuO3GuZpu4uPVPsEn3Ka89o3
	M3CBnP5yyAXUXNZyfrCUT9GCdIj0O0wR27oEA7y6tzIMW0yfozAFDKPCpeEDS14MxAjzIAE+r1B
	WbtZyzUtmFfBTV66kRqGtVBg4z2rWp7x9NYju9WtOM1p4SkSu8Unj2CTNH8oGQoSEg==
X-Received: by 2002:a05:690e:1343:b0:677:d849:d989 with SMTP id
 956f58d0204a3-67935f1c62bmr4622102d50.18.1791982404451; Wed, 14 Oct 2026
 05:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013153210.218423-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20261013153210.218423-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 Oct 2026 08:53:13 -0400
X-Gm-Features: AclHuK9gIK4LFE3wXcGa21mkmXqJPgfwDcWDkYcG15JYH3FL26Ja4NoNamyRG9w
Message-ID: <CAEjxPJ7CqoGHs2pPoRLmcQjvjXE3q1cL-4PVASqjf4A5jGMzMg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] checkpolicy: validate policydb before writing
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:34=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> checkpolicy does not currently validate the policydb with
> policydb_validate() before writing it, which could consequently
> generate a policy file that can't be consumed by the readers.
> Validate and reject it before writing.
>
> Only validate when the output policydb is a kernel policy. On the
> source -> CIL path (-C without -b) policydbp points at the POLICY_BASE
> parse_policy, which is parser-shaped rather than read-side-shaped:
> classes with no access_vectors entry have a NULL permissions.table,
> initial SIDs with no assigned context carry a zero context, and
> policyvers is a kernel-range value. policydb_validate() assumes
> read-side invariants and would reject or crash on these; the parser is
> authoritative on source input.
>
> For -b input policydb_read() has already run policydb_validate(), so
> this is only new coverage for the expand_module() output and for
> re-validation after -O or a -c version downgrade.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
