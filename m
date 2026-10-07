Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DFA49483D
	for <selinux@vger.kernel.org>; Wed,  7 Oct 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401740; cv=pass; b=aIQpJULvJ+wqVn6/cofmP6mJCKYyJbf9rNkfEge9zeEDbeYjbyZB/JqWpk5mqcN44EElQLeVVvyOb524OxUOyU4Z7NrRgzPir6LulbVv44eGQV9SjYb6uKnqB2u2XosSt5tOAxXiPSDYok2nMgmNDqGHVpC8S+bvHkFExufzDXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401740; c=relaxed/simple;
	bh=th2bAnZ14glgJ/JnBzkB7HGXbhkvQlh5wWTRQDicgtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTUp7NRsdnZ51RHgeU3jrr8r3sxZzSrdZ40UYWS541mUPRdlqJt/LceX32LyMPkOqawzrLZ0TXvQkKGSEgVx2lIqE/8Vq/caWd7yBmkFw7WRP0IGCwZk72+WQl9JuYKgFPoaqwqOdCB0G5nU7ZcBYnDN2zg4PPCuMUIZbp5ebV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUmJP2xc; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUmJP2xc"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6767d92cde6so2126684d50.0
        for <selinux@vger.kernel.org>; Wed, 07 Oct 2026 12:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791401738; cv=none;
        d=google.com; s=arc-20260327;
        b=muCrswagprvxwk42E/MrFn+lwz62wfq5i3QHZMqq9IHqn0ksAJG7Ls7PHTc07WUGdz
         L//IXy21QwPgHVWjnXklRYE7WHCYVmSz95cxncduiCInpWBTJU3yi5yw+m5XfDr2HzXW
         jRupnMmoPjMG6v0h3IGR3VrMXTS1KODf5+xk7Td1ssw42kysoAKGYo/E9+Kanm8Dou1G
         0hMLTvl9lbiGV8lz1ScU9Fvp4xKEOLdvBGDxWom6iiAtxwU+ULUJAVoFDG/fURRugbgK
         wYGuTvMj00ELgGs9uE34OPZ+UiSzhpas1BXZ3NXS4ehSTDMNUWjPmABktJbxV8mbYAmb
         RjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PWyE4eBTNsU0nHG7+wptwr1GgqQAQ/6/OPaBh8GJliM=;
        fh=+Yf2QF/i/Su7M8iAKzXhL9jwXdPzO3LHtNjXyBmL4QA=;
        b=DPXwpuNid2KNSh+1IXSdni4clv4qiY3iSIT0a7PKEYg5EgzHLPEv56FMV4Gpzi4BpG
         A8BQV6yvDuQDgGQYTxMDS9b2OeT0h5EIXaa1O1H0NAvc2fDkhYF9I6ZBqocsFeMz3h9A
         SgNXRSo2mlRfB/x+cYrMCvB8zA3EhGiaGV8/jLciN2H8RODBD9KLJr1EGNwXDeJlrRaF
         loPWQ4BsW1jffcx08EkhwxQdUN8KLVdUBdAM8lfW6SovqGICU78ubS9/di52EEv3tEDF
         YxBiIyxaRkuICbyz/Cegt3GNHkITGMyYb9Sq3bklpPA5YyIY8RvKHcPspRrsocei2fRS
         oH1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791401738; x=1792006538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWyE4eBTNsU0nHG7+wptwr1GgqQAQ/6/OPaBh8GJliM=;
        b=YUmJP2xcakYxKZLRTunEG8gIZvo9jUU3ycztdcbBT5BpmLLBF2p4qWBN8rSmiGdpxG
         HVQnBXsbFaEzDx1cLpv6v8eo7XidF5of2IQsblCtg7WnQ0xFHj+tIheNMFpMzXuqhiJb
         Xxs6jtv/FrcqHeubCP+Wql3OsYAQScVXulo1tSWe0426JnmRFwKtAlqsWEsVst984InV
         hmar9GrjdNE1hcyENMmutGTYAcNCzyiwyMq4yYZxvQl03pKsgPiv0zNc0qHdDswNEis7
         ER1NmNIPF6snDevNCygLwBpw10m0YoNSa//24N+5KZOhiDaREJqoZJX/0KYQ3fmhMSj4
         /qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791401738; x=1792006538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWyE4eBTNsU0nHG7+wptwr1GgqQAQ/6/OPaBh8GJliM=;
        b=Uupow/YZaFr8mx1sSg3zpGdOuG6OVt55wtpeqOA5xwCa8bIARB6K1f42BPLIEx7EEQ
         pNTwBf2WaWqXbTu0YDlspMDwy7OxbokYNE0IpbMe8LiyIjbnjRnyMRO323GVuixYfMLw
         JYZhDVm4tHczUDNgGlJOSMVblLjql4J0jjkq2bHvZJBBSDQv6KfJRSfDh4k4EZ8litLk
         dSHcNugEFbqRA+R/zD+uudOriaaPBXNpx1HFTKXLpEOL3TCTguEdN3Oi/G947DCa9+Oq
         lCUXFn0Kyjq044rposWo6Dkhg1/8flbukzU6BBMfYo7qXYFvcmQFaDgX7kDCfEWPQxGk
         pc6A==
X-Gm-Message-State: AFq9FYLWaWRgUxgATyyxExHuBmY/MqdCJYyLhJqsmBnrpM+beaiyzdV0
	9DyC1fO8SwEHcCKsmOE93ivb/HSHs5QEJAgyS8GJ8f9NHFccMWZouVXLCKphVfjjrfECU/hn10r
	B9DeynpXKYH2U/DSS3uEN1cSRcurYcd4=
X-Gm-Gg: AYBFou0tdFfzTybFCH0K04TSUuNTtgD3yMl0NaNo0Cgr0MChfaz9wDegXhCbwFmWgIn
	KC4DUWopFe1I1wUbLYkd78gr9o3/AMuHxRjvwUuTowXhrVUWqWG6SDUEDAaIOYU4BIZw/huOFrE
	WnN95wP7zs9OtWjt+8sir+yFCf74GtQ6V7D5eqXpiumAmGthqonKeH7YChHECGb2rxRTifS1HXu
	N9h/1oxXK3o8Api/1Ic4dQvQmwDicUuGmArsj7dhfissjQVeHTa8FBhv8xpTA94sWfVH9+kotQY
	BBRrb1k9HERtPElmQJOSG+Gj3D3N8+tn0ixOUekn1aPOU7g0/9VbjkNvh2s/QkZhNA==
X-Received: by 2002:a05:690e:445f:b0:677:cc34:2f4b with SMTP id
 956f58d0204a3-6790a283797mr1379871d50.22.1791401738467; Wed, 07 Oct 2026
 12:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006130215.128405-1-jjanasek@redhat.com> <20261006130215.128405-8-jjanasek@redhat.com>
In-Reply-To: <20261006130215.128405-8-jjanasek@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 7 Oct 2026 15:35:27 -0400
X-Gm-Features: AclHuK-fsXgI9UzymIkHLwl5wjN2WX0dAZ-tzEs2z7yb0-TMnHmy5fA3OpYwLuE
Message-ID: <CAEjxPJ6SegOgbbxMJiaKAzfAn6+CmxW5A3w0Pook_z-t81cyPw@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 07/17] libsepol: add public class record structure
To: jan janasek <jjanasek@redhat.com>
Cc: selinux@vger.kernel.org, Juraj Marcin <juraj@jurajmarcin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:04=E2=80=AFAM jan janasek <jjanasek@redhat.com> wr=
ote:
>
> Introduce sepol_class_t with getter/setter API for class name, value,
> common, permissions, constraints, and validatetrans expressions,
> without exposing internal class_datum_t or constraint_node_t.
>
> Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> Assisted-by: LLM Cursor
> Signed-off-by: Jan Janasek <jjanasek@redhat.com>
> ---
>

> diff --git a/libsepol/src/class_record.c b/libsepol/src/class_record.c
> new file mode 100644
> index 00000000..8acf7edd
> --- /dev/null
> +++ b/libsepol/src/class_record.c
<snip>
> +struct sepol_constraint_expr {
> +       uint32_t expr_type;
> +       uint32_t attr;
> +       uint32_t op;
> +       char **names;
> +       uint32_t num_names;
> +};

This structure carries only the positive name list for CEXPR_TYPE. On
a kernel policy that is complete; on a module/base policy a constraint
written with ~ or * silently loses the negset or flags info. Either
extend to expose the negset and flags info or prevent use on
non-kernel policy or at least document the limitation please.

> +int sepol_constraint_expr_set_op(sepol_handle_t *handle,
> +                                sepol_constraint_expr_t *expr, uint32_t =
op)

What is the intended usage of this and other sepol_constraint_*()
setters since they have no path back into a policydb since there is no
sepol_class_modify()?
If it's intended for round-tripping through sepol_class_clone(), fine;
otherwise it's a lot of API for data that's effectively read-only.
