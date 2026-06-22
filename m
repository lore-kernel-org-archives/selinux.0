Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A901AE877
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145106; cv=pass; b=YkaMG8qZe9UBzCD4Hm9PyMwINTijGBlY1TsQBH9R6kUJYOo7u+EVwgqcjvuStruB/WtqM8FbZ2dBCrsoSZIsHR7kGklG6KGikY4wrlYeG6/xgWiiNsjHiLvD786RxalTLsGPReUHfjWv61ckCvRzEBmr8X22k7unxKCN7AIshN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145106; c=relaxed/simple;
	bh=EnBVKTGqt2H0+hDXZxC4SVAvm6RJPGC3qpgYO1lDrjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbW3jzZcprTXed1z4broQg9KN+Fll04/WDGKfZpA3PoODGUyyfbKdbfk/wOI16wBSJx4DbWxsmYCPxvL2vGAve5EHptK2TRZgWYR9x+Y2c+tHyVda5Mzd2oD7DMzQxnyy4kVHxO+ZrdpwUzk6UbTb+9tShMBVEvYNN8zi58CRYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYQBeIAI; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYQBeIAI"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so2278198a91.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 09:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782145104; cv=none;
        d=google.com; s=arc-20240605;
        b=Qd4THAqu73jXmlfhffaWijuzppPS/AEhczPmpHauLtYeOE9nvmNJqUxhMb77Pj3X8e
         J6ovfyNuGdFCID0vDYEFBETaAttprjHhyJdsV9vQkN3dupZNoQYUjSh/dD6VezAaTbMx
         bCNNRxeyQNnPmqsWMzGm9h6c1P4CktZ/p1+6LUi0cXYYo218iWLki7eBZ/57+IvQ887g
         9QbXOgn1zo6Zw5LVq4CullFMrVcFzF+FLLkW+xdLvaIJ36IOtrilNAm0Dxrt2VJsAOXc
         Lt2fzAAh5zk/fpIPYkmZDon8T2nXgA0+tVcEfUdnK6DsZBAQN8R/oDjuY1OHObB4dxLx
         2bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cOpG9Fv08r3h2YzBnsFrginP5IO4O4QNnGuOJ6KvAjA=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=I4EXdsd4WP2SOTo0YfSIp9u1GLbXHewwRzYb1GjNbvv7fodDOij/h37UjJy9Jcklrs
         b95c1F5W6vGpCewnu1bf69RIigU0dgTp6prRpvHCsLY9B9RnS+8lduHI8kEcbS+rShO5
         19me2139fsTN+HCYR0xTdAZYhabxy1R/Mi0V+b/YwdFQyHzmHU8ylYNG776m9qGyfcVN
         i2Lv7xcXJrNUSdsacdJMutfxQ6I4ew/K3WzQcEaZc8Qd+CoMOs8PUXdoSwUh6YMCTcc6
         H78hd533C4VD+ee93qdF+VAIipgwAEW9JBclVo+tLsBqA8Sn1S68wLKCjJaWY1uZ72Ai
         N4YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782145104; x=1782749904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOpG9Fv08r3h2YzBnsFrginP5IO4O4QNnGuOJ6KvAjA=;
        b=hYQBeIAIq1jm1g//WBFr329MIaFyTgD0UomUZmkiCrdPaEXb5+x+6oA/y+oHvP8C9d
         9j5aTbxl9SnG0/3p8LP8qbZseT8yKYnMVm3eAtwhaXponF50viiu6WYpCZsHGJW8DQQr
         bHCPygHEzEs5XrP9uYEoKcthoiF0VDsqkFQciHj2xHc92KR105SGCNAsp6bbuJWtU2I8
         FjejcsN7O8U8GfSuuvORpCL3ZHHKm1R7REojKqFrjlCm4tFlzPkBUkNr/HGMu2tVF5Tn
         ADPRMlcP0cmXl1DG3zAUx5oy9+Qp8Utk6aCJ+5btBKo1PqftnPkK67QPFj1ROSsslxu0
         0sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782145104; x=1782749904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cOpG9Fv08r3h2YzBnsFrginP5IO4O4QNnGuOJ6KvAjA=;
        b=PMgnP719U3obzOo3e4sJDlh4NZwwbfcwOmq786hEQLBsJFMqjm5q7swOHqcv79uAf2
         KNCL4YOgC80kCAPYWVOp+v8PH7gfIV1gNUht6f+05XKqKhakXUcsz6TJVMRsyFBht651
         RG2FIH3d9zdF+7W1xbi9Oz2HFUILAuBrg/qCnvurHX0cuyThsKWM2+olAv4xjT+8Zgpg
         kKrXVNenLeV3JSxLxLxBWuBEON2qzxrxigYuV1cyvFq7rS/58Z4dFP2uCAwSYkCW7gUi
         IHXNMOyRQQZkXY4Qkk9xbHhVe4EzEiOOIasqdOWLFRJl15C1mMVCZMld+QynMPCX75n+
         sx2A==
X-Gm-Message-State: AOJu0YxDec7hOMEwQsch0WauYF9NNibKvUmLqRqcDw7uvBWB1yg/lIct
	ibLmMB4z97XGYWBPqFC23BAan260j6qX5ck6SFooJiwYVMpMFW2Wj4VVjT4cptHEiXzGxEh81zA
	tiVw87WnKniJw+NA1cnfj54C+BNRASYe2LA==
X-Gm-Gg: AfdE7cn24doq5kv+AwZBl3UNzOFF2XQGTfWmyddyrDg6c+/fhWh6RzlReJzDeGq4CKg
	JbSrHPtlg3LRi31DWdthtwh/9YdIE4krVCt+BK9DP1o0vjEWoC2YlAxWYWxw1XMizRYtn8bZHmF
	hJjCC1+kJhO5KIPIhEGYa9kmbrZRqsZCwS6Vuf3QTNsXeM/tYghFmKDMu6k4faEINn63lFFUPHQ
	gerrCTd3NyzTdzde1J9lWwG0dY6gMbYV53P5hxmpWz5R6cMNEd97QUM5rBS/BHSFJ68Zlqi
X-Received: by 2002:a17:90b:4b43:b0:373:c536:6fc2 with SMTP id
 98e67ed59e1d1-37d15eaef85mr16479698a91.22.1782145104272; Mon, 22 Jun 2026
 09:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617013838.82900-1-kalevi@kolttonen.fi>
In-Reply-To: <20260617013838.82900-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 12:18:12 -0400
X-Gm-Features: AVVi8Cf1d3ly7goW2R5F4eIkOv86Pxu1S_Iu-pS0RleSK79QakETsWUzfPfwnGA
Message-ID: <CAEjxPJ6t=NgjCEPG=1sgvPPx0ib=0bWayZq4h7w3ZGoBSFRm-w@mail.gmail.com>
Subject: Re: [PATCH] selinux: use bool instead of int in ss/services.c
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:38=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Generally we prefer some kind of description in the body of the
message as well, e.g.
Updated security_sid_to_context_core(),
security_context_to_sid_core(), and their callers to
pass boolean flags via bool rather than int. No functional change.

> ---
>  security/selinux/ss/services.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index e8e7ccbd1e44..2bc522ad88a3 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1354,8 +1354,8 @@ const char *security_get_initial_sid_context(u32 si=
d)
>  }
>
>  static int security_sid_to_context_core(u32 sid, char **scontext,
> -                                       u32 *scontext_len, int force,
> -                                       int only_invalid)
> +                                       u32 *scontext_len, bool force,
> +                                       bool only_invalid)
>  {
>         struct selinux_policy *policy;
>         struct policydb *policydb;
> @@ -1438,14 +1438,14 @@ static int security_sid_to_context_core(u32 sid, =
char **scontext,
>  int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
>  {
>         return security_sid_to_context_core(sid, scontext,
> -                                           scontext_len, 0, 0);
> +                                           scontext_len, false, false);
>  }
>
>  int security_sid_to_context_force(u32 sid,
>                                   char **scontext, u32 *scontext_len)
>  {
>         return security_sid_to_context_core(sid, scontext,
> -                                           scontext_len, 1, 0);
> +                                           scontext_len, true, false);
>  }
>
>  /**
> @@ -1465,7 +1465,7 @@ int security_sid_to_context_inval(u32 sid,
>                                   char **scontext, u32 *scontext_len)
>  {
>         return security_sid_to_context_core(sid, scontext,
> -                                           scontext_len, 1, 1);
> +                                           scontext_len, true, true);
>  }
>
>  /*
> @@ -1551,7 +1551,7 @@ static int string_to_context_struct(struct policydb=
 *pol,
>
>  static int security_context_to_sid_core(const char *scontext, u32 sconte=
xt_len,
>                                         u32 *sid, u32 def_sid, gfp_t gfp_=
flags,
> -                                       int force)
> +                                       bool force)
>  {
>         struct selinux_policy *policy;
>         struct policydb *policydb;
> @@ -1640,7 +1640,7 @@ int security_context_to_sid(const char *scontext, u=
32 scontext_len, u32 *sid,
>                             gfp_t gfp)
>  {
>         return security_context_to_sid_core(scontext, scontext_len,
> -                                           sid, SECSID_NULL, gfp, 0);
> +                                           sid, SECSID_NULL, gfp, false)=
;
>  }
>
>  int security_context_str_to_sid(const char *scontext, u32 *sid, gfp_t gf=
p)
> @@ -1672,14 +1672,14 @@ int security_context_to_sid_default(const char *s=
context, u32 scontext_len,
>                                     u32 *sid, u32 def_sid, gfp_t gfp_flag=
s)
>  {
>         return security_context_to_sid_core(scontext, scontext_len,
> -                                           sid, def_sid, gfp_flags, 1);
> +                                           sid, def_sid, gfp_flags, true=
);
>  }
>
>  int security_context_to_sid_force(const char *scontext, u32 scontext_len=
,
>                                   u32 *sid)
>  {
>         return security_context_to_sid_core(scontext, scontext_len,
> -                                           sid, SECSID_NULL, GFP_KERNEL,=
 1);
> +                                           sid, SECSID_NULL, GFP_KERNEL,=
 true);
>  }
>
>  static int compute_sid_handle_invalid_context(
> --
> 2.54.0
>
>
