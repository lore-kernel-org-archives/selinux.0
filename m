Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377CF3D413C
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226393; cv=pass; b=PI8yo6Bn09GQA6oZoZkuH5QHiClBsfKmDZ26sX4MhTEb0zY6SDpgyoUiQgCU+CbgepwJsLoeV3xt0PAmoyKFqFvW89IFdqKaASNQpfkRo3v8eKFZNWW/swMykQgoNCOaTlBv3M43/I4OPCzhPE7Hk1s4jFOirodBN9BdayFUOfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226393; c=relaxed/simple;
	bh=hn/lpVMIJK66Ca83RkYNrGVr5dJeKpeJO7ETa+CG+7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIXIdlPna8FC9nd5r8aI2iIoo6vpDUwDAjJvegeU1Q14X2j8auv6amMCBsdkz+fpbfWf6dRVnuKLVysPkknfUSSFfFZ/5ow+we23xlDd0BuaDSaD21uSyriYqgRQAhsW9HFTP9zFCgQfei8+U16nxYSOCUDYMIVQK4jGTk/SKQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwbW4tn2; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwbW4tn2"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84232e83ca9so1817b3a.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226391; cv=none;
        d=google.com; s=arc-20240605;
        b=kn/hnDj6MyWX5943NVgils5F/2/ePNF1aU6Gvb2Axd6XLmHhSQdO4V79x2hlj8XY0A
         QwaqExtNw8PlNA2yiGRgcUfSIE7v+9tLT0s59i5Y4NItp2G5hYxPjj/H69YT3/DNwWdF
         +M15JQ8VYT7IxqgzGR7N6KEju2SDbtaA6zsn6km/2xqplFKqR/mGE1EANM2UIct8ELpn
         BK8ZshgTPt0+0VQcJBEDS1cjBSAh+uFutnY+yx3FysZP4svtmfBzIAC+ruPcAuePeYMB
         q0keKAGiswzV2XzAL5Ja4zvbRXBb5MPotEqMsVDyw+AdbnTy2RHtgNYK/3HBamy/KDTL
         QV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1fmwOSstOZ8YuGYt2mzDmrxKaDn7iiXuSMRtO8buIdc=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=BhKs7dUbpKfIwCqAhCFrvUQXkeEuEFYT0gvj60IE1qpXFHhKha5qDkdab2w9HjJ0QH
         CjrOkm7GdeSF0f76Nvl7PfPMda+YMqOs0HBhatKOApPSgeigFANOQPLRCgAvOSggMBZB
         JYpqzKi+KNlmNug82teeaRNU3EpCHp0cgC3GFIwzenZrdgR5WXOtfEenZP+uPJg4q321
         aQKYuQn4AAlaeetKii472ZdEOfZHWgKGOF0zlb2f54kdlPj8vMdNRozttnMVawxIvFgi
         32zewJLGbrBG7h+lRxs33pSrOG9aPSEXaKh89pToyKXrWQhUy+T3sHwyGakEVOOr2h7l
         Ji+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226391; x=1782831191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fmwOSstOZ8YuGYt2mzDmrxKaDn7iiXuSMRtO8buIdc=;
        b=OwbW4tn28oHHlIuVxBTd1uH1V6DgLn+0XYMd0k2aRlHkQYjq046ZBVv85OuMMdbwEl
         fi0/KgCaRCbzhfwNQvUmkYa5HDfW7ItQkKLDCHHaoL8LjDeW+J1hzgvLLga2lOxa8kAg
         RyaAHuectAIDYaUfNGivHRm3oH1o8vq2M0U39zgz1xF+wFUnEHGPYoYhgAHGfGifL3Mz
         qaml9x/WPja1iDFr3NrUMMPBXERHQpdiI49iC4ZxrdvTsaEayJQoVyE5Ha6Cn33ul3Wl
         X4ac/vQxyIqyH97eIhkg2fHPP+uBsNZY/pWHJ7xiUdU96jnvrn/hvivK1O8ggnI5ix4o
         3FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226391; x=1782831191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1fmwOSstOZ8YuGYt2mzDmrxKaDn7iiXuSMRtO8buIdc=;
        b=ee2nWakl7e65UT1TdNgBMIBPMoaBphIeBWt9W9ekiX85qCRCnVov6UWRreyIQBSnks
         OwJPO8lpshYPdzQFfHSf5O8YN6soAZmhlCDS2jGyWzDgCrL+urXZHf7nYyBO3id6G7ur
         /f7VVCKrxADb44233Jp4Pds+sxnayYOEjG1h/dzXmLwIQ2F31pNOuqdQ88KYleLqkqiR
         B57w5/VfAALnCdJJEe7UHI/UPFVAWbFwiKg/8jBC2WyoBA42lBvwMoNpLGrif9LWWDPj
         cpMqO5edjZY0vklUsfCnkpChU/woYKEl4WHLfKBkpbTQQxEqZZnIMiFcuYnsWorzpx2/
         NUMA==
X-Gm-Message-State: AOJu0Yz9E8USaKXP3gIWmlbNDg/XZlq+b4Z3Cm9SnJvZkVStycooHrv1
	rNpy90ED1edyZBkWk4YuMpvDC6d4alVuEBXeE69aH7+hI1lI6YiihrHvWxrJsjpz03Upl66OPWT
	4yN66+El4NWox8P0koLftH/wyzGs+karCeg==
X-Gm-Gg: AfdE7cner5d+yqItreR0W0fvsEllm4o5sWpni4xvgmZt932ESmpVXwDkuTFZx5Q/9xi
	RxsW3gHr+Fo3yIsOcc0OzFZl60qjxQ4Mbnf/D9UdgVCkW0BO4Meb5jB3LbT5OSf7dswF1rApK1H
	5eLA457jORG32h/mEXKNo8Uhxlj9oRhIgl2henwyaVf2udLOnshqHTkManY0GKE0HGdLXVC8GBV
	G1bvy/7mHa4RRqWKNeXlnUmajOIhWnaq2zdN4QgaQ+++MpsbH4x35/j7H8Eq0cqGbPeAJWX
X-Received: by 2002:a05:6a00:c8b:b0:845:32c8:e77d with SMTP id
 d2e1a72fcca58-845953268f9mr3806320b3a.34.1782226390631; Tue, 23 Jun 2026
 07:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-24-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-24-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 10:52:59 -0400
X-Gm-Features: AVVi8CcMKaRGCJEJfItrs1lw96k0785UKT57nhWignkw876hKPHkGOwYCnpDPXg
Message-ID: <CAEjxPJ7S4de3KVoMnC_Dv1uQ_MxzTEuZJrBx4rYJ3Ha=_g6uEw@mail.gmail.com>
Subject: Re: [PATCH 01/24] libselinux/include: fix man page grammar, wording
 and consistency nits
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:44=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Drop a duplicated "and" in the avc_add_callback() header comment.
>
> The selabel_handle pointer parameter was named inconsistently across the
> public headers (handle, rec, hndl) and the man pages used hnd.
> Standardize on "handle" in the headers; selabel_cmp keeps h1/h2 as it
> compares two handles.
>
> Reword "allows to run/use" phrasing.
>
> Correct the selabel_cmp() @h2 kernel-doc (second, not first handle) and
> the grammar of the selinux_set_mapping() comment.
>
> Fix RGB triple count in selinux_raw_context_to_color() comment; the
> comment claimed "ten ten hex RGB triples" (a duplicated word and the
> wrong count). The function returns eight triples: foreground and
> background for each of the user, role, type and range components,
> matching selinux_raw_context_to_color(3).
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Note that you didn't make the corresponding changes to the .c files,
but that's not necessarily a problem.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/include/selinux/avc.h        |  2 +-
>  libselinux/include/selinux/label.h      | 23 +++++++++++------------
>  libselinux/include/selinux/restorecon.h |  6 +++---
>  libselinux/include/selinux/selinux.h    |  6 +++---
>  4 files changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinu=
x/avc.h
> index 1fefbf4e..6d728ce0 100644
> --- a/libselinux/include/selinux/avc.h
> +++ b/libselinux/include/selinux/avc.h
> @@ -379,7 +379,7 @@ extern int avc_compute_member(security_id_t ssid, sec=
urity_id_t tsid,
>   *
>   * Register a callback function for events in the set @events
>   * related to the SID pair (@ssid, @tsid) and
> - * and the permissions @perms, interpreting
> + * the permissions @perms, interpreting
>   * @perms based on @tclass.  Returns %0 on success or
>   * -%1 if insufficient memory exists to add the callback.
>   */
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/seli=
nux/label.h
> index 05e1fd56..748b0db0 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -107,20 +107,19 @@ extern int selabel_lookup_raw(struct selabel_handle=
 *handle, char **con,
>  extern bool selabel_partial_match(struct selabel_handle *handle,
>                                   const char *key);
>
> -extern bool selabel_get_digests_all_partial_matches(struct selabel_handl=
e *rec,
> -                                                   const char *key,
> -                                                   uint8_t **calculated_=
digest,
> -                                                   uint8_t **xattr_diges=
t,
> -                                                   size_t *digest_len);
> -extern bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
> +extern bool selabel_get_digests_all_partial_matches(
> +       struct selabel_handle *handle, const char *key,
> +       uint8_t **calculated_digest, uint8_t **xattr_digest,
> +       size_t *digest_len);
> +extern bool selabel_hash_all_partial_matches(struct selabel_handle *hand=
le,
>                                              const char *key, uint8_t *di=
gest);
>
> -extern int selabel_lookup_best_match(struct selabel_handle *rec, char **=
con,
> +extern int selabel_lookup_best_match(struct selabel_handle *handle, char=
 **con,
>                                      const char *key, const char **aliase=
s,
>                                      int type);
> -extern int selabel_lookup_best_match_raw(struct selabel_handle *rec, cha=
r **con,
> -                                        const char *key, const char **al=
iases,
> -                                        int type);
> +extern int selabel_lookup_best_match_raw(struct selabel_handle *handle,
> +                                        char **con, const char *key,
> +                                        const char **aliases, int type);
>
>  /**
>   * selabel_digest - Retrieve the SHA1 digest and the list of specfiles u=
sed to
> @@ -135,7 +134,7 @@ extern int selabel_lookup_best_match_raw(struct selab=
el_handle *rec, char **con,
>   *
>   * Return %0 on success, -%1 with @errno set on failure.
>   */
> -extern int selabel_digest(struct selabel_handle *rec, unsigned char **di=
gest,
> +extern int selabel_digest(struct selabel_handle *handle, unsigned char *=
*digest,
>                           size_t *digest_len, char ***specfiles,
>                           size_t *num_specfiles);
>
> @@ -149,7 +148,7 @@ enum selabel_cmp_result {
>  /**
>   * selabel_cmp - Compare two label configurations.
>   * @h1: handle for the first label configuration
> - * @h2: handle for the first label configuration
> + * @h2: handle for the second label configuration
>   *
>   * Compare two label configurations.
>   * Return %SELABEL_SUBSET if @h1 is a subset of @h2, %SELABEL_EQUAL
> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include=
/selinux/restorecon.h
> index 6680589e..34ba0f43 100644
> --- a/libselinux/include/selinux/restorecon.h
> +++ b/libselinux/include/selinux/restorecon.h
> @@ -33,7 +33,7 @@ extern int selinux_restorecon(const char *pathname,
>   * @nthreads: specifies the number of threads to use (0 =3D use number o=
f CPUs
>   *            currently online)
>   *
> - * Same as selinux_restorecon(3), but allows to use multiple threads to =
do
> + * Same as selinux_restorecon(3), but allows the use of multiple threads=
 to do
>   * the work.
>   */
>  extern int selinux_restorecon_parallel(const char *pathname,
> @@ -146,13 +146,13 @@ extern int selinux_restorecon_parallel(const char *=
pathname,
>
>  /**
>   * selinux_restorecon_set_sehandle - Set the global fc handle.
> - * @hndl: specifies handle to set as the global fc handle.
> + * @handle: specifies handle to set as the global fc handle.
>   *
>   * Called by a process that has already called selabel_open(3) with its
>   * required parameters, or if selinux_restorecon_default_handle(3) has b=
een
>   * called to set the default selabel_open(3) parameters.
>   */
> -extern void selinux_restorecon_set_sehandle(struct selabel_handle *hndl)=
;
> +extern void selinux_restorecon_set_sehandle(struct selabel_handle *handl=
e);
>
>  /**
>   * selinux_restorecon_default_handle - Sets default selabel_open(3) para=
meters
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index de56b727..364f955d 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -387,7 +387,7 @@ struct security_class_mapping {
>   * offsets for a particular policy.  However, that strongly ties the bui=
ld of the userspace components to a particular policy.
>   *
>   * By using this function to map between integer offsets and security
> - * class names, it's possible to replace a system policies that have
> + * class names, it's possible to replace a system policy with one that h=
as
>   * at least the same set of security class names as used by the
>   * userspace object managers.
>   *
> @@ -689,8 +689,8 @@ extern int selinux_trans_to_raw_context(const char *t=
rans, char **rawp);
>  extern int selinux_raw_to_trans_context(const char *raw, char **transp);
>
>  /* Perform context translation between security contexts
> -   and display colors.  Returns a space-separated list of ten
> -   ten hex RGB triples prefixed by hash marks, e.g. "#ff0000".
> +   and display colors.  Returns a space-separated list of eight
> +   hex RGB triples prefixed by hash marks, e.g. "#ff0000".
>     Caller must free the resulting string via free.
>     Returns -1 upon an error or 0 otherwise. */
>  extern int selinux_raw_context_to_color(const char *raw, char **color_st=
r);
> --
> 2.53.0
>
>
