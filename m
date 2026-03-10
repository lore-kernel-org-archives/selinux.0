Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7A3E8667
	for <selinux@vger.kernel.org>; Tue, 10 Mar 2026 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146795; cv=pass; b=K7XqHnjkdG3oUIAwLWaFMvPfCqSXIA/sxrEuDtSKTEKUI/Y2Fr9G0529sVlmurRKsWpmox/Jxdfh08eLVlj0CcCa5y8Qju85DmJhMxg60SmqZHKHhupe1RNf+ZnHhFHDcpIamo2vGkjXwsySoK0g+JHwGf17FUyv+205uulU3jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146795; c=relaxed/simple;
	bh=19Cint8Tx2wtLdGkzxhwTjX6VxpLdpiYmLlFFZnYTmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/OLwnojsAuQkZZPPBRG0OZHqiTHOe1gsNJ9qUOjmQLnidnnZY+QWp2S04Wae+XGDEddldYwS7S/F/RUXK3hxB8xr159z5vJYqxdKbvvWbRiuYmPoZOMQ+Jtsk9h4Mln75SgzFIjXNk5d7GwypUSyo2poIo0TGFkFT0Wfgf4V5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4O8rdcF; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4O8rdcF"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7393c6832bso1914380a12.2
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2026 05:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773146793; cv=none;
        d=google.com; s=arc-20240605;
        b=SXkRDxYlEXFNuo1pRVN91j5By/tdhgtrYvb6fdXJiHikSlrgqTIZ3MDx+MtwKRpGL9
         zzf+FpDKbmPAWYtu6HzLsQGHNOS6wsPn/BNGGPCSFimAviWxADRBLycTFzEZBL3wVpAZ
         cj27vzt3rVnGKKgWjUBCN9SnzjAzSeSLHmPyDXsqudnaSW8p/PNj4kNoebM0GECy4PZd
         eSJQPDAwRRSZWvaQ7vNdjTGgQzKtbO0S/kZy0sjwulY7PzVrOrH6bH356DpefRcc1WEA
         XGESWpHibBlIkPT+S175GwMUZ8OY777PpiELh+V03RNE2VGz62ILq4O+wbgCGz9t3pGP
         mpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhhnVOT6Yfy/MrapamZMClu7pRUxIPpRsCz1jRJapdo=;
        fh=5PmA0VN68TeM8KUKgIvMjrYEu0mBYbIu3rwsths/CuA=;
        b=O2AtkiwM3znSYLarCXnh+qa32OCiapjl4G3g98y8LCpTLCCU7p2CJF0KzGe+lw1uyv
         CnygpRLbQ5ug1P7J9t5Z3GXoXEF9cE8bU9okjdDCMRx+OuqTMsebMS8633yFA/eEZtdQ
         jKPojp8Wbb/UveyjuEzAlSrI7TrulycJu8ijU690qoXu0QSQ6KoIRx49RRIZqlLfvmfs
         8O3hHM9co4pX9OVWzSUwTyGrxlgVXutFint1BoZweeuFSx1bUzVjRB+nphQ/9QcbiZSZ
         h8WCrjW0xFJSHp6j6EYlMjxRdK3llL1MDRCh03m69O5ynx8IQCWl4K+P4sB/yBIGNFaz
         TFMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773146793; x=1773751593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhhnVOT6Yfy/MrapamZMClu7pRUxIPpRsCz1jRJapdo=;
        b=W4O8rdcFMhYY2rDls2Bt+5pszWcCbE0gneDCQFmKn7N7BJcgSHw28UFjC/ZfNRl8+h
         hwBDUAnrQmwlts5epN/DXDk4EKkZ6Be23UTGS4GW+w64RyW9VIQzyHgx3OkTLl5Bg3Hu
         qste0xS5ifhoD7djqVwd/QTJ6u+bcsesX+2nOJKdtMArzijrNFCGdtgMPjevWu58/aOk
         qqjGYZ+LBafaDOg0/dPNWsQ/BEx0FM8VQ+jGuoa5hwsNZLrfNXjSKqgnC7FugGf+ZK77
         KVKnIKi/xndpFAQlhbZf1rNAeocoPytJ572cIVsm8QIGRQSlvlHeGkppvyVHZMQSH9dJ
         rhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773146793; x=1773751593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhhnVOT6Yfy/MrapamZMClu7pRUxIPpRsCz1jRJapdo=;
        b=rpnczoOR4kNyHdce1nVW36YwnHuGLwVKcXZ5VIdCSK+nigSFczs97HwI/iKz+wJyP0
         BOhANUuk+w5n+ndsFcDpN/qFx3ZkZSegABet5mJwDVvxo9smrvzTAMTy++RMXp/iJPZM
         P64EQR9yVOSKhvp5qgnuLiokNgO4e7OG8hTal2h3e/XI6S7IH3CTVwm4CEUM30lLGTpq
         zEVqgKW2NJCBNqcAulfDEEjdFqW2R6F7sStNTOFIsNyEU3wwM5zfUv3mSEQIrPAdCzVD
         4so2T/uqny0fQg71H9UANXHRVjKXh/XhuoRLW5pLPcAK58pG/3ET4pT+r7FVmFheOGmi
         xmSA==
X-Gm-Message-State: AOJu0YzC7pTCNQfAey+tg+3HZKvWWxgzbKGYAnrW2UEI3ex/taL/ZQk5
	ZNBPpm/wr/q5K1ncsjVheq7sL7fg7vFxkxe8GrGE+xbXVyFdFmuQBv6G+S29MLdInVaAM90D9EF
	jKak5xUeAwuU8Nc/rKT6/ph7eVwKjLIayGw==
X-Gm-Gg: ATEYQzzBtQNUCVY2X873lKLJo2Lf+rp3bApN41q02wJ8HcAgFlWZUAPEpOK1evs8yGT
	vdfDwgmxvELfASbNZzbFrgg8oxojGKbkSrBWnH2Sh2uCt8cb45RHEpOdTqp6IyZ35F7Bc9G7jpj
	SrtHb0nIOGSM0gd2C0mRCdk6zC4K2Bn4ffHs/lvsnH5XRC6nDv4GifFOnwFPE/5Y3f/XVsa5a2M
	tUnjpmXvETJ3y6lw6d54jFZ7DgIiixA/Ebmbc/vG8ilNMNyVnZN2J33SLagxvyBSffTbIFMXN+E
	8m9nBEk=
X-Received: by 2002:a05:6a21:48d:b0:398:8c87:eb8b with SMTP id
 adf61e73a8af0-3988c973069mr7522665637.64.1773146793352; Tue, 10 Mar 2026
 05:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306131941.106248-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260306131941.106248-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Mar 2026 08:46:22 -0400
X-Gm-Features: AaiRm523uU6mHPPMeCEUnSpGZo1_tvm5dVBgUSvcHgQaUFM_FgrHD84NuIif8aM
Message-ID: <CAEjxPJ5woS1uBHPE_69rcootf3Z3ZRjnZijAk2PWnNzHNYx_jg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: correctly find partial matches
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 8:39=E2=80=AFAM Christian G=C3=B6ttsche
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
> Example:
> The lookup-key "/sys/de" will result in the deepest node being "sys" (a
> parent of the root node).  Non-partial lookups don't care about the
> child nodes "dev" and "devices" but partial lookup does.
>
> Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
> Reported-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Where was this reported?
And can we get a test for the selinux-testsuite to demonstrate the
before and after behavior of this patch, possibly on top of tweek's
other patch?

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
> + *
> + * Return: A linked list of all file context definitions if a match was =
found.
> + *         NULL is returned in case of no match found, or an allocation =
failure.
> + */
> +static struct lookup_result *all_node_specs(struct spec_node *node, uint=
8_t file_kind, bool find_all)
> +{
> +       struct lookup_result *result =3D NULL;
> +       struct lookup_result **next =3D &result;
> +
> +       for (uint32_t i =3D 0; i < node->literal_specs_num; i++) {
> +               struct literal_spec *lspec =3D &node->literal_specs[i];
> +               struct lookup_result *r;
> +
> +               if (file_kind !=3D LABEL_FILE_KIND_ALL && lspec->file_kin=
d !=3D LABEL_FILE_KIND_ALL && lspec->file_kind !=3D file_kind)
> +                       continue;
> +
> +               if (strcmp(lspec->lr.ctx_raw, "<<none>>") =3D=3D 0)
> +                       continue;
> +
> +               r =3D malloc(sizeof(*r));
> +               if (!r)
> +                       goto fail;
> +
> +               *r =3D (struct lookup_result) {
> +                       .regex_str =3D lspec->regex_str,
> +                       .prefix_len =3D lspec->prefix_len,
> +                       .file_kind =3D lspec->file_kind,
> +                       .lr =3D &lspec->lr,
> +                       .has_meta_chars =3D false,
> +                       .next =3D NULL,
> +               };
> +
> +               if (!find_all)
> +                       return r;
> +
> +               *next =3D r;
> +               next =3D &r->next;
> +       }
> +
> +       for (uint32_t i =3D 0; i < node->regex_specs_num; i++) {
> +               struct regex_spec *rspec =3D &node->regex_specs[i];
> +               struct lookup_result *r;
> +
> +               if (file_kind !=3D LABEL_FILE_KIND_ALL && rspec->file_kin=
d !=3D LABEL_FILE_KIND_ALL && file_kind !=3D rspec->file_kind)
> +                       continue;
> +
> +               if (strcmp(rspec->lr.ctx_raw, "<<none>>") =3D=3D 0)
> +                       continue;
> +
> +               r =3D malloc(sizeof(*r));
> +               if (!r)
> +                       goto fail;
> +
> +               *r =3D (struct lookup_result) {
> +                       .regex_str =3D rspec->regex_str,
> +                       .prefix_len =3D rspec->prefix_len,
> +                       .file_kind =3D rspec->file_kind,
> +                       .lr =3D &rspec->lr,
> +                       .has_meta_chars =3D true,
> +                       .next =3D NULL,
> +               };
> +
> +               if (!find_all)
> +                       return r;
> +
> +               *next =3D r;
> +               next =3D &r->next;
> +       }
> +
> +       for (uint32_t i =3D 0; i < node->children_num; i++) {
> +               struct spec_node *child =3D &node->children[i];
> +               struct lookup_result *r;
> +
> +               r =3D all_node_specs(child, file_kind, find_all);
> +               if (!r)
> +                       continue;
> +
> +               if (!find_all)
> +                       return r;
> +
> +               *next =3D r;
> +               next =3D &r->next;
> +       }
> +
> +       return result;
> +
> +fail:
> +       free_lookup_result(result);
> +
> +       return NULL;
> +}
> +
>  /**
>   * lookup_check_node() - Try to find a file context definition in the gi=
ven node or parents.
>   * @node:      The deepest specification node to match against. Parent n=
odes are successively
> @@ -1808,32 +1905,41 @@ static struct spec_node* search_child_node(struct=
 spec_node *array, uint32_t siz
>         return NULL;
>  }
>
> -static struct spec_node* lookup_find_deepest_node(struct spec_node *node=
, const char *key)
> +static struct spec_node* lookup_find_deepest_node(struct spec_node *node=
, const char *key, const char **rest_key)
>  {
>         /* Find the node matching the deepest stem */
>
>         struct spec_node *n =3D node;
>         const char *p =3D key;
>
> +       *rest_key =3D NULL;
> +
>         while (true) {
>                 struct spec_node *child;
>                 size_t length;
>                 const char *q;
>
> -               if (*p !=3D '/')
> +               if (unlikely(*p !=3D '/'))
>                         break;
>
>                 q =3D strchr(p + 1, '/');
> -               if (q =3D=3D NULL)
> +               if (q =3D=3D NULL) {
> +                       *rest_key =3D (p + 1);
>                         break;
> +               }
>
>                 length =3D q - p - 1;
> -               if (length =3D=3D 0)
> -                       break;
> +               if (unlikely(length =3D=3D 0)) {
> +                       /* double slash */
> +                       p =3D q;
> +                       continue;
> +               }
>
>                 child =3D search_child_node(n->children, n->children_num,=
 p + 1, length);
> -               if (!child)
> +               if (!child) {
> +                       *rest_key =3D (p + 1);
>                         break;
> +               }
>
>                 n =3D child;
>                 p =3D q;
> @@ -1882,7 +1988,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct=
 selabel_handle *rec,
>         size_t len;
>         uint8_t file_kind =3D mode_to_file_kind(type);
>         char *clean_key =3D NULL;
> -       const char *prev_slash, *next_slash;
> +       const char *prev_slash, *next_slash, *rest_key;
>         unsigned int sofar =3D 0;
>         char *sub =3D NULL;
>
> @@ -1938,10 +2044,38 @@ FUZZ_EXTERN struct lookup_result *lookup_all(stru=
ct selabel_handle *rec,
>         if (sub)
>                 key =3D sub;
>
> -       node =3D lookup_find_deepest_node(data->root, key);
> +       node =3D lookup_find_deepest_node(data->root, key, &rest_key);
>
>         result =3D lookup_check_node(node, key, file_kind, partial, find_=
all, buf);
>
> +       /* For partial lookup if the key matches a child node, recursivel=
y add all specs */
> +       if (partial && rest_key) {
> +               if (!find_all && result !=3D NULL) {
> +                       /* found already a result, and only one result is=
 wanted */
> +                       goto finish;
> +               }
> +
> +               for (uint32_t i =3D 0; i < node->children_num; i++) {
> +                       const struct spec_node *child =3D &node->children=
[i];
> +                       struct lookup_result *r;
> +
> +                       if (strncmp(child->stem, rest_key, strlen(rest_ke=
y)) !=3D 0)
> +                               continue;
> +
> +                       r =3D all_node_specs(node, file_kind, find_all);
> +                       if (!r)
> +                               continue;
> +
> +                       if (result !=3D NULL)
> +                               result->next =3D r;
> +                       else
> +                               result =3D r;
> +
> +                       if (!find_all)
> +                               break;
> +               }
> +       }
> +
>  finish:
>         free(clean_key);
>         free(sub);
> --
> 2.53.0
>
>
