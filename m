Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D833FBEB7
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161804; cv=pass; b=KfRzzoM6NlIGqVSOOBJN8jMyoOGCLd/WFvhcRBLNBFSfJbU7FQrBCN5pfTg3DUN0wTKgOzrLFVOQdd7Rji+miEXzajzzaknxdBKpGKPPF6vZTFPkfQCN+LFt+iiI+GhMFALfptlZV3xIVLTvedq4q1E6XJNA2O65yUm6kWjh3rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161804; c=relaxed/simple;
	bh=z+WBM1p4P4u/jxUglAfeiZsh6PVi7g1wPU6nYbXfqMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEP1roN8e7lgqMnLvWySsK1+/5QOfOM4E75wtLabB7HqTwD7A079rzekrUkqyLjleJTufLrVA5r7PNkF/h+eRd+6ZqgmcCOPckfq17LPs9MxniOJXhrZvp2m+CP1L7HNArCI3y8MBaJ725VY5z0ix+g/CMxRS3f4F0I9rERZuoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cChXz+j1; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cChXz+j1"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651d692e833so899820d50.3
        for <selinux@vger.kernel.org>; Thu, 07 May 2026 06:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778161801; cv=none;
        d=google.com; s=arc-20240605;
        b=D3fg4MF9aIMvQ5AOoplD4leb/PQi4+KZ8MvGuaovRgZFtR0vmXk9QLjnxs6jNv91Of
         /E7IPcJcr4zTKnRrMz2P+z07U21muQnq30yhng8XG5uc21z07NNNlNgn/xD8du1imOTG
         DdGWjAEc3RqcG+0tbrGE5o8dJtIsOD14P/3yRfD85TYyV91/mEYXbdz2EaQrAGdKm//R
         dHJSnieFCfNbPGOJtU5ZBI70sHVhM8UC6xhrXwEQzAk/2h9awXjw2X0uMvLXrqsTcBek
         FzMHTUB/2+AS01ghLxgn+QSrGEP/BYVV4uFsVch5LrF/ipiDDzHIZcuZYoP0L+C/P3c0
         IDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cqpFcR/rQTTqC/EYMMLzH4hqP3wvi9AlKUo5qigX+AU=;
        fh=5PmA0VN68TeM8KUKgIvMjrYEu0mBYbIu3rwsths/CuA=;
        b=ZYNVeX9J2yuT+XDby9WLmC+sRCss3HTRSQnRaWqz2nrs99AU3DpGvJktrjfFQv097v
         IkhijJgzg5RUMgt7FZfhieehzEZgtczCeHK5yljvBPg4qPxu3SBvq+XgFhkJjEsrPLej
         Xuj4oDPsJbnNHHlXEpTD2WHrPzlvBD6Lb7ZyqTrNperRPVPp2IWIHJ9eFoZUtzHxcAj/
         ZZjztdS3Kj9X6pWO4UD4/eN5zeWYbsndS/xDV+sAnFW8G6LZaNxSAnwUtoB9t9FflbPC
         C1YN8I3tZfpq+JEI6jYAP+5b3PgP2Z5nDTBA8yuIB9T6Y1H/cj/V52rIobMJYSHXIDJB
         cQSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161801; x=1778766601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqpFcR/rQTTqC/EYMMLzH4hqP3wvi9AlKUo5qigX+AU=;
        b=cChXz+j10B6uSvj9o2DYA3I//ca2FjGInIgFnB0T+2eEP4pW6tM9F5N1F8ZXaiViAN
         sLk348xaB7YqhOHpBDhz7AnJow5q4pidWkJ10BcopERCftRtKApqMU9Qw8uRmKIca/e4
         LPWEiCm1c5PZhXaw+kZCqsBMR3/IjBnxemIAq0I/EOX2vxicOcm52PYylwOrhaeTa760
         yaeGT1JmK87uEwWt8v0t929u8J2cWtkrJQZd0VhW5XWos4vSZbGH1Lxns8BqLj0Ktdtm
         DEIh+nWRyKfRV+S3NHPDV2YRzdC5f5bN6z0osQOHKc2VUTeMyouGa12AndChyXi3tn6F
         5mOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161801; x=1778766601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cqpFcR/rQTTqC/EYMMLzH4hqP3wvi9AlKUo5qigX+AU=;
        b=skhYnj6KdhzxkRZ82sdJubQ5hyAsuSOj8z5rrL2q+4KGD7ZRtfH+W1Agf3TY20gxm3
         JswZehci9GlLqZ0CLFCSnRRpMTvX7KD6esVClgWdKxhERpshwiH1vtDH0qIKu2cZcPMD
         QeCAYh9P8PbLqOBWLJuaLY5RD9B5PIqQyH3QYnhIPglEK9lRzHannQN8QA4vnLTOQNKh
         c9WTpiDuDi6XRuRoEna0Vw79vYGavz/B9q0wYwageEhmAbwuut94Pn8Cjl1Qnx73F6Po
         djdCOZb4yObXwj40sroF2TDoIU+q5suRcXYSiPQ1hXn2KI73M14bJ7f14BuQlnKZyBMH
         zivg==
X-Gm-Message-State: AOJu0YwH9mGlW9y7gugFrGHiU+rQUjubWH0M0l3u41uATy0chhaG9Dy+
	XuwE27v3MXK95HfY6Z2JHWf+zHhj0BwSOnXwBD2APKI068ErN2NUwYtchc1yx0rIkDjaE4xdqKZ
	a9ecTRfbdnBPjnQ5xa0Vfi+hd2TT8toxIEA==
X-Gm-Gg: Acq92OFrlixMtVaCOUQifpi0HLm4u7CV4Woy1cWSLYvRVe0vakAi9BBeMOjXR2r0Bis
	GGWobFzBk3BTdsHDVspbG0yjphnbkdg0TA8cpMiQFGJ+0KR8pRl+GUe1lj70IgbdygRBRDbDra2
	RezaRC+VBdPqWiPEZCOCdwnvQ8gtLeaQ6PvpKhGpy02FK9dZTph/zcYPuSYNrRwSEnqR/De1Qri
	TK3zGpMGTXIDa4EXHAZdgdMV9imAXdV99NDSyxdN3bHtHbLBfpuXm3aS2X1FWSflW1bVY3l8YNC
	G6p/6i6juuCLYHfBBZzpLThQ8YgL
X-Received: by 2002:a05:690e:1c1b:b0:651:ba22:fcc3 with SMTP id
 956f58d0204a3-65c79a29669mr8016345d50.61.1778161800816; Thu, 07 May 2026
 06:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320172446.96634-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260320172446.96634-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 7 May 2026 09:49:48 -0400
X-Gm-Features: AVHnY4JZd65u7-asxWnQ5nB7gkJLhJTiIalGYsA5RccrPJfgTxeD19TC6OdTfzE
Message-ID: <CAEjxPJ6QRisP9s2QBXvt73+s1KFAYcmtoLWMnOz=VPwDhT=Qug@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: correctly find partial matches
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
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
> child of the root node).  Non-partial lookups don't care about the "sys"
> child nodes "dev" and "devices" but partial lookup does.
>
> Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
> Reported-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>  - fix documentation of find_all parameter
>  - fix linked-list handling: always add at the end
>  - pass child to the root call of all_node_specs() not node
>  - continue on <<none>> context definitions in partial mode
>  - add Signed-off-by

Thiebaud - can you please confirm that this v2 patch fixes the issue
you reported?

> ---
>  libselinux/src/label_file.c | 162 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 154 insertions(+), 8 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index b785eab6..31f134f9 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1599,6 +1599,107 @@ FUZZ_EXTERN void free_lookup_result(struct lookup=
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
> + * @find_all:  Whether return all file context definitions or just any.
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
> +               struct lookup_result *r, *last;
> +
> +               r =3D all_node_specs(child, file_kind, find_all);
> +               if (!r)
> +                       continue;
> +
> +               if (!find_all)
> +                       return r;
> +
> +               last =3D r;
> +               while (last->next)
> +                       last =3D last->next;
> +
> +               *next =3D r;
> +               next =3D &last->next;
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
> @@ -1644,6 +1745,9 @@ static struct lookup_result *lookup_check_node(stru=
ct spec_node *node, const cha
>  #endif
>
>                                                 if (strcmp(lspec->lr.ctx_=
raw, "<<none>>") =3D=3D 0) {
> +                                                       if (partial)
> +                                                               continue;
> +
>                                                         errno =3D ENOENT;
>                                                         goto fail;
>                                                 }
> @@ -1712,6 +1816,9 @@ static struct lookup_result *lookup_check_node(stru=
ct spec_node *node, const cha
>                                 }
>
>                                 if (strcmp(rspec->lr.ctx_raw, "<<none>>")=
 =3D=3D 0) {
> +                                       if (partial)
> +                                               continue;
> +
>                                         errno =3D ENOENT;
>                                         goto fail;
>                                 }
> @@ -1808,32 +1915,41 @@ static struct spec_node* search_child_node(struct=
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
> @@ -1882,7 +1998,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct=
 selabel_handle *rec,
>         size_t len;
>         uint8_t file_kind =3D mode_to_file_kind(type);
>         char *clean_key =3D NULL;
> -       const char *prev_slash, *next_slash;
> +       const char *prev_slash, *next_slash, *rest_key;
>         unsigned int sofar =3D 0;
>         char *sub =3D NULL;
>
> @@ -1938,10 +2054,40 @@ FUZZ_EXTERN struct lookup_result *lookup_all(stru=
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
> +                       struct spec_node *child =3D &node->children[i];
> +                       struct lookup_result *r, *last;
> +
> +                       if (strncmp(child->stem, rest_key, strlen(rest_ke=
y)) !=3D 0)
> +                               continue;
> +
> +                       r =3D all_node_specs(child, file_kind, find_all);
> +                       if (!r)
> +                               continue;
> +
> +                       last =3D r;
> +                       while (last->next)
> +                               last =3D last->next;
> +
> +                       last->next =3D result;
> +                       result =3D r;
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
