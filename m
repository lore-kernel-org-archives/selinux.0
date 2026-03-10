Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D525F78F
	for <selinux@vger.kernel.org>; Tue, 10 Mar 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109262; cv=pass; b=FXtHlPbr7BkMboK2uxbcOp8Q8RQ2Av1Tn0/vIhfRqZHiKvB30I13WeABCB9OsqgK9dSfcmhq5KSN3OBjEegZgdisSSUCwN8/lLacOVYpjj6O5x3E6/6GV3zvOAzwGcYC4pi7ausuMQwgOdFnUOwUEeq9IUSMBUUgktmciK4LpBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109262; c=relaxed/simple;
	bh=0Kjoo2RSeaQ9CMoyoSASEaijl1/XI7h1BRgB9ik0MME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOe7zBezNpFo+/+FTGBOiyQt/5k45kme+UIiJqb1t9HQGUYRbs2eWbyG+IK0wjbADaOuN5XajwdoZ7Z+J32SQxvfyh4rkjOyrczAh9n0EZEeCp3Vjt4e2ZPDpB6E+FFMN9ltN3QWF33/dVSjldlkDN1Y+PrJzE5J7hZgauTpYKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1rdwN7J; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1rdwN7J"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50906a98ffeso293231cf.0
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2026 19:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773109259; cv=none;
        d=google.com; s=arc-20240605;
        b=OmabvwGys+9TLibouAH4kVzyWHxvzmxRPS0SyAn+1/85EpI88uQqQPrEqjh3wcKswo
         ONOMuOSlnOMzcKzl4565T1/cLgnIvAf5xKueJlnsqgEVYEB6ofjEDuyS3QdWTDCazxql
         jhSP0nlc4jHzKVVR5OO8IXimRGLGq9WPopcbU4LZI2AUhZkS/m9uSzYEA9EiVdqdFU81
         azKcwTlzNQvzHpQIfEh24k4W2WhBqE9IshNwuIzHG3fFNj72oLxmHYxdSEhAloKJigwy
         cm7luI9dD+SP7vDtlxh75DvpqKw7CqBpKMb/rne5MeljK4xKuPr3yLmLy9AV4jIP9nmB
         rZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5uCg7CNBTwZSgqaDHtIAWBqJVNMQNW16eT7st3/sz20=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=ZjVsmWq7sFSoo8EylTx7fS+S0AXzaj1VLZSRZyEM7ZxYFxiceqQR2uKq8Xb/G4LlOR
         dBR0jDEzmV2RaLyWXOvdyPKJSxIz6B5Lf06o9s7M+/6TBFgyWKtVyqBb9i7RciU4eLhS
         U9h0Ja2xlnh4xTiDGiJvM98dfL7ecE47JC8aLLZkzlnpl7S1JovutLyRRCV99oa8APG7
         KuYMKBDAglUW9BtTerjzM7ue29Mz/pHMbEOwrHMYXGKgWzTvqvuV7g2Ha7PifM6Q2+cx
         X2sL2JHmvLcbPsWdVckChpqhqUmIHNVBA0oUWoxJoNMs/ZpwV1XGwCIsqh40vZhitaXH
         LDsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773109259; x=1773714059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uCg7CNBTwZSgqaDHtIAWBqJVNMQNW16eT7st3/sz20=;
        b=H1rdwN7Jbr+Vyu2Nh55TlmBYKJvruyHhcI/W5n1dIRrDtLycvkCePfS8Mo6mOO+Epr
         S0uTGf4gTRfQHeF84qB+e/u1jC8xQ1Fcy8Q5+0kfhx5pGZ548C3VRFnX5St+yHnfxZiS
         eYSghz0Omd101nex+4AZGrkF+RUiVP/xQn+1msR6Ae8c16xGzJp/feMoEM4K8Wh9LHwh
         d9jpkOhI9O8o2wrp5tP1A4084hN+Vle3uWqvdKWx/w/7e8zNTSVw4j7m49fhEJ6d9AZ9
         oSxTkvbGRo8Vb8YDnY0Pzx3uCz74np0vHkBZog5pzVdFA6+9M1LP2sm0SfolHXsB9N2F
         Dh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773109259; x=1773714059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5uCg7CNBTwZSgqaDHtIAWBqJVNMQNW16eT7st3/sz20=;
        b=krW0JxxNrs+mqVWLv+dLiwqGH0DKVDpG6iPdhYIs1fRXsgr1LjVGnjPgBugqjDLLxQ
         RDTAGTFRSxqGc8okjqmN59Mg9VQDoSigPUHCNHB5QVBU5ieZM1BqdptQ35YaSGXSaaR0
         owGrrGC0YJfWXsjGi85MiYM/yPD3Ll/t6CTmemCqIfD4AMprpSIlU7WJ8s8bZXhDEU1B
         gH46w9Cmm3HysGNrhUascC8bIJcf0yLPRgZkD2IB+E2/dyJfzADMvCKZmrkHnYymVtAU
         bvLndYxDWgINDzwT1kqt+wTSeZGyRNsl2REf4CV0bYxGPVyyYV8JkbFsTkkwrjf3XvIE
         WjDw==
X-Gm-Message-State: AOJu0YxEZzWVbu60K1qocYFIUBhi+J/F+UbY/ddKWHWZuiyWDimwtAl9
	PZPMWeyJDELex7bgXF+H3xuERQbKrHU64tSAzHPUlgjHduzDtSo1leDLrsG4y4x+NpGmyfE66jK
	fwzZlJbtfiUAN2yALtYx6pFKfaRns7zpagGFmB4J394kHo3wGk6LYETiQ
X-Gm-Gg: ATEYQzy04OIFVm1xEyUQsice+cKg1o60MF6dxmx+q4/SNY9yKK2m2E9qgQ1NlDyDCpN
	mhhHwGEggUSJXb9H/AEnwkmQeJUHTAapLUgmDzbC/AHVjRLxzzcsHUoxyrlzocnOXjvarR9eQZp
	z/tFJk1G7U4bmElZ8GlRKPoTKBJVneBfWVufJy3EQ8Tj2qnGmddSN/d2owYZPGLJu4oHPV55Jf5
	LXPj6DIrnwn2ukJNmoIgi7hCPzmCtyU2gI2NKLzMCtNum1eHAUSVDqZTpKCnnEy7OneZ8yMvilQ
	M5N1SQQ=
X-Received: by 2002:a05:622a:612:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-50927f49291mr4713121cf.3.1773109258376; Mon, 09 Mar 2026
 19:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306131941.106248-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260306131941.106248-1-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 10 Mar 2026 13:20:41 +1100
X-Gm-Features: AaiRm53twVMpLIxiQ49HwtzrbhgHxDWoOFGC0bf1QiHaiFyYPTEf6yUpaZQOpXE
Message-ID: <CA+zpnLd0awdRwt=MERAN-xuZBsYYbY1+YDHxN4TrWw_PrEMx7w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: correctly find partial matches
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 12:19=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The current lookup for file labels first searches for the deepest node
> matching the lookup-key.  Then all definitions of that node and its
> parents are considered.
> For partial lookups also consider child nodes matching the lookup-key
> portion that did not match any node-stem.
>

Thank you Christian for sending a fix so quickly!

> Example:
> The lookup-key "/sys/de" will result in the deepest node being "sys" (a
> parent of the root node).  Non-partial lookups don't care about the
> child nodes "dev" and "devices" but partial lookup does.
>
> Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
> Reported-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Tested-by: Thi=C3=A9baud Weksteen <tweek@google.com>

> ---
>  libselinux/src/label_file.c | 150 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 142 insertions(+), 8 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index b785eab6..24b2c765 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1599,6 +1599,103 @@ FUZZ_EXTERN void free_lookup_result(struct lookup=
_result *result)
>         }
>  }
>
> +/**
> + * all_node_specs() - Return all definitions in the given node and all t=
ransitive children.
> + * @node:      The top level node to return all definitions for.
> + * @file_kind: The kind of the file to look up (translated from file typ=
e into LABEL_FILE_KIND_*).
> + * @find_all:  Whether to find all file context definitions or just the =
most specific.

s/the most specific/any here? If I understand correctly, it returns
the first possible result. There could be a more specific regex in one
of the children, right?

+static struct lookup_result *all_node_specs(struct spec_node *node,
uint8_t file_kind, bool find_all)
+{
+       struct lookup_result *result =3D NULL;
+       struct lookup_result **next =3D &result;
+
+       for (uint32_t i =3D 0; i < node->literal_specs_num; i++) {
+               struct literal_spec *lspec =3D &node->literal_specs[i];
+               struct lookup_result *r;
+
+               if (file_kind !=3D LABEL_FILE_KIND_ALL &&
lspec->file_kind !=3D LABEL_FILE_KIND_ALL && lspec->file_kind !=3D
file_kind)
+                       continue;
+
+               if (strcmp(lspec->lr.ctx_raw, "<<none>>") =3D=3D 0)
+                       continue;
+
+               r =3D malloc(sizeof(*r));

Just a thought: for the selabel_partial_match case, we only care that
the result is not null. Could we optimize that path by skipping any
allocation which we know will be discarded shortly after? Or pass down
buf as an argument, similarly to what's done in lookup_check_node?
Thanks
