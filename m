Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47940D575
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427762; cv=pass; b=S/vkffk1T9XFkhiV5KS5rmRAlJG7oBgOHnBFlljH0yxqXvm+B0o5VixxxBJAfZVJz0RKUptbOL8vKiinUzQvfrtWgxHDw5NaKgPyemmVYt8SkzX9rZqrSGqx2ZunPII7jgPdccXSb0l4cudRnCzsEFHe5VUge/w9xXnJD4WtPOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427762; c=relaxed/simple;
	bh=DTo7IbvBZ1f00L+SoJNsu3HSSpPjMX6q8Ll3AI/7rcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uykd8VfmTFfUf/OXx02X1043r3lzd4UOuBtrXJ6o6fkpMyXBZz3ddYGZpo028mKlh/lFlTQ3U2smmmS9jNR1p8jDnBypkQ4WlY/QpUHtfiC8mp6Ki608bfv/hrrxXfrdf44lS30weWs5hq9uG8UPm3O8+1mUR90VMosy79Y9dg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bScJfoP4; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bScJfoP4"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84794e800f4so2420302b3a.0
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 05:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783427760; cv=none;
        d=google.com; s=arc-20260327;
        b=LiCtejnseE1xNaiXlvGhpi2QEfWWZX3FaOFWeDUUlgWr9bZjEnxb9ODXgIUE6lI3M9
         wx++10HCGdEMBuNSuH4gqo3JAjAXUWYaHHjXa2+RfWccE+h+14LivMrTcW3JHebXuWit
         DS7HLbyCfFXUGpTHHc3RFYwmb9/J0Ey0vk5JwqWdPjcyAo5qETZCKzjudveHvq6M2r8X
         M8C2q9sH1CWL9/zroxRz6GOWXWx5ilpYjOy9dzXTG6T5xjHzsmOQ2vaWpKYg1ynM55da
         3A7L/vSOMEjMQglJaMST+THm/G05JcSXFFs/FxCZSFqa8D5Ont6gUmLFFRmnZP+XHGcB
         CxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=00Qx5jSAEk2gLQtMvoRXDUELEn0srDbHIujcx3ylxqo=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=GeGraRXNTZ7B3q0LGBxUcfAu+KWtyZ+twRn57iLKNiNGEYzK0G3bq7imMQdoE6nQpb
         e6MUX5EpKRSceS8cOwrvZYR0LcewNw6ubaBfgs8DyaHl+sBXrLtWOTLe1fpfDx+xzkZ4
         Hox2NrMyc6MYniAz7hC4ucAb/b0m+9svqL7YibTgTkpjhHTC05uxkEU6tffg5OKKZi3+
         utOP7bINSx49k4SXCLjMXi1jCrb8w5KoQWu5E/SYpAahLplOIwA1RO/csqo1gvFbo9ha
         /LZ3R8nlAOdCXVlfJquR694xuPGzGlTv29DX7rA8+1RYqpfub4iDlR/TghVCaQObw22J
         06xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783427760; x=1784032560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=00Qx5jSAEk2gLQtMvoRXDUELEn0srDbHIujcx3ylxqo=;
        b=bScJfoP4Kn6J7S1IPG8ILEal+gnbwxY7YAsYayr/6Llj2YVkqFFnItrqvPEDv5xsO/
         kbdmsLRddQOuaPIkzrZL3jsh2/+2qayEdsNADydHNXHS9EHHM2h2pS2Xf9lPnrqB5lzU
         iZ3kNXRTghtEdWEEktZ69X3zlHbRYRr1BLuSF6zYWXhlFHXWQtQzO/gFrQPDnKFlF71a
         Ukz+xVkKmFQ9Ei+hOP5Oob3WvL84lbU9YWrLKQtRIojg5TIkF0wq67Y+ZmuYxLPqPYZn
         k8GstOFT2Cvf5CPxNEWerPna8akPYsnuyMiBTc9ijb0vhHXlleyKehJYTPA19kNYNSoR
         czow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783427760; x=1784032560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=00Qx5jSAEk2gLQtMvoRXDUELEn0srDbHIujcx3ylxqo=;
        b=ZSNoxqjKmQ34CJD79bHz1FpV0qafacvLakK5IbRndf/N2n+bmCLqZNXWmecI8kjWk6
         AlvbI6ZKa6TeydV/PQTiaxLaCNqPrihWDqtEsIy4eGFT++xs3fgpCdnpIeRO3WS1bve8
         X2/2cW0EZzd0u51kkm3swTzwq+rrtgwQeGqWhsGHetqYD0KJR/pnvi6G4dyorS8aTY0d
         SlwjNHj0TBChQfNby8IU6aCUpo+H9PIie5Kds+qgTcQ8llhSbK4QLS/erlMfJWYB7lJk
         YpnCVXsg6Cgzx6u+AeCZd+VmreubtE23TbBW5ot3Or5wOH2LQ56sD0Sb7K6PnHfOrT8r
         yxcQ==
X-Gm-Message-State: AOJu0Yw4Xelh1l3FRwU8xlJ8kizPIfJLiWj4bAvFDKSEh+kxme6W3se5
	giXZcqFq2EtP+P6Z2cqzJI4ZDmrRBkV+q7QoGqpUdIAvYEtRVWyKJtPbGJGu7aaAKReFMJE7mcN
	y7DNNeXPNtiVIT8LyW0hFIFBebI14914=
X-Gm-Gg: AfdE7cldbYXyaEkWWqb4b1ZjjI/6KQGKSoDMRHxWz80ZszxrZ/gCDuOxZTS0ZkFQhIS
	NJuNfE/JoARi3BHexIAh3+2CVkLatbRL4ZaCxATFw9Ra5AW1+o8nNIJXCJMGDxR64ozGQoZ7dtF
	0Dhs6NjVJ0MflZqoHPiT+5L7/3gQ8SS6zock1YnAS0O3qLubdAOIa9uG6dHahRbJprV/Her6gKE
	iGVVOxrc+e79HYtZqV2fy/MGLk9x2jAYhhIdUSefEhI2gPs54BPZyRXojOEWSEOSHWHkxuR
X-Received: by 2002:a05:6a00:4b4c:b0:847:84a1:9782 with SMTP id
 d2e1a72fcca58-84826c32238mr4808006b3a.26.1783427760064; Tue, 07 Jul 2026
 05:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
 <20260623134215.98273-24-cgoettsche@seltendoof.de> <CAEjxPJ7S4de3KVoMnC_Dv1uQ_MxzTEuZJrBx4rYJ3Ha=_g6uEw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7S4de3KVoMnC_Dv1uQ_MxzTEuZJrBx4rYJ3Ha=_g6uEw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Jul 2026 08:35:48 -0400
X-Gm-Features: AVVi8CeWPiPODPwnAdvi5NhDO6F3SC2WHWVoaB4eZqTFl1K_Bt_c7FDd0fYxXWk
Message-ID: <CAEjxPJ6CwTqRM4PHH+ZeCtrAAN-kKny2e3_-z_FW9yhzmd07tg@mail.gmail.com>
Subject: Re: [PATCH 01/24] libselinux/include: fix man page grammar, wording
 and consistency nits
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:52=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 23, 2026 at 9:44=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Drop a duplicated "and" in the avc_add_callback() header comment.
> >
> > The selabel_handle pointer parameter was named inconsistently across th=
e
> > public headers (handle, rec, hndl) and the man pages used hnd.
> > Standardize on "handle" in the headers; selabel_cmp keeps h1/h2 as it
> > compares two handles.
> >
> > Reword "allows to run/use" phrasing.
> >
> > Correct the selabel_cmp() @h2 kernel-doc (second, not first handle) and
> > the grammar of the selinux_set_mapping() comment.
> >
> > Fix RGB triple count in selinux_raw_context_to_color() comment; the
> > comment claimed "ten ten hex RGB triples" (a duplicated word and the
> > wrong count). The function returns eight triples: foreground and
> > background for each of the user, role, type and range components,
> > matching selinux_raw_context_to_color(3).
> >
> > Assisted-by: Claude:claude-4.8-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Note that you didn't make the corresponding changes to the .c files,
> but that's not necessarily a problem.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

With the exception of the patches for audit2why that call free_bools()
(used before being defined) and any subsequent patches that would no
longer apply, this series has been merged.
In particular, patches 19, 20, 21, 22, and 23 were NOT applied for
this reason but feel free to re-submit once you resolve the ordering
issue.

>
> > ---
> >  libselinux/include/selinux/avc.h        |  2 +-
> >  libselinux/include/selinux/label.h      | 23 +++++++++++------------
> >  libselinux/include/selinux/restorecon.h |  6 +++---
> >  libselinux/include/selinux/selinux.h    |  6 +++---
> >  4 files changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/seli=
nux/avc.h
> > index 1fefbf4e..6d728ce0 100644
> > --- a/libselinux/include/selinux/avc.h
> > +++ b/libselinux/include/selinux/avc.h
> > @@ -379,7 +379,7 @@ extern int avc_compute_member(security_id_t ssid, s=
ecurity_id_t tsid,
> >   *
> >   * Register a callback function for events in the set @events
> >   * related to the SID pair (@ssid, @tsid) and
> > - * and the permissions @perms, interpreting
> > + * the permissions @perms, interpreting
> >   * @perms based on @tclass.  Returns %0 on success or
> >   * -%1 if insufficient memory exists to add the callback.
> >   */
> > diff --git a/libselinux/include/selinux/label.h b/libselinux/include/se=
linux/label.h
> > index 05e1fd56..748b0db0 100644
> > --- a/libselinux/include/selinux/label.h
> > +++ b/libselinux/include/selinux/label.h
> > @@ -107,20 +107,19 @@ extern int selabel_lookup_raw(struct selabel_hand=
le *handle, char **con,
> >  extern bool selabel_partial_match(struct selabel_handle *handle,
> >                                   const char *key);
> >
> > -extern bool selabel_get_digests_all_partial_matches(struct selabel_han=
dle *rec,
> > -                                                   const char *key,
> > -                                                   uint8_t **calculate=
d_digest,
> > -                                                   uint8_t **xattr_dig=
est,
> > -                                                   size_t *digest_len)=
;
> > -extern bool selabel_hash_all_partial_matches(struct selabel_handle *re=
c,
> > +extern bool selabel_get_digests_all_partial_matches(
> > +       struct selabel_handle *handle, const char *key,
> > +       uint8_t **calculated_digest, uint8_t **xattr_digest,
> > +       size_t *digest_len);
> > +extern bool selabel_hash_all_partial_matches(struct selabel_handle *ha=
ndle,
> >                                              const char *key, uint8_t *=
digest);
> >
> > -extern int selabel_lookup_best_match(struct selabel_handle *rec, char =
**con,
> > +extern int selabel_lookup_best_match(struct selabel_handle *handle, ch=
ar **con,
> >                                      const char *key, const char **alia=
ses,
> >                                      int type);
> > -extern int selabel_lookup_best_match_raw(struct selabel_handle *rec, c=
har **con,
> > -                                        const char *key, const char **=
aliases,
> > -                                        int type);
> > +extern int selabel_lookup_best_match_raw(struct selabel_handle *handle=
,
> > +                                        char **con, const char *key,
> > +                                        const char **aliases, int type=
);
> >
> >  /**
> >   * selabel_digest - Retrieve the SHA1 digest and the list of specfiles=
 used to
> > @@ -135,7 +134,7 @@ extern int selabel_lookup_best_match_raw(struct sel=
abel_handle *rec, char **con,
> >   *
> >   * Return %0 on success, -%1 with @errno set on failure.
> >   */
> > -extern int selabel_digest(struct selabel_handle *rec, unsigned char **=
digest,
> > +extern int selabel_digest(struct selabel_handle *handle, unsigned char=
 **digest,
> >                           size_t *digest_len, char ***specfiles,
> >                           size_t *num_specfiles);
> >
> > @@ -149,7 +148,7 @@ enum selabel_cmp_result {
> >  /**
> >   * selabel_cmp - Compare two label configurations.
> >   * @h1: handle for the first label configuration
> > - * @h2: handle for the first label configuration
> > + * @h2: handle for the second label configuration
> >   *
> >   * Compare two label configurations.
> >   * Return %SELABEL_SUBSET if @h1 is a subset of @h2, %SELABEL_EQUAL
> > diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/inclu=
de/selinux/restorecon.h
> > index 6680589e..34ba0f43 100644
> > --- a/libselinux/include/selinux/restorecon.h
> > +++ b/libselinux/include/selinux/restorecon.h
> > @@ -33,7 +33,7 @@ extern int selinux_restorecon(const char *pathname,
> >   * @nthreads: specifies the number of threads to use (0 =3D use number=
 of CPUs
> >   *            currently online)
> >   *
> > - * Same as selinux_restorecon(3), but allows to use multiple threads t=
o do
> > + * Same as selinux_restorecon(3), but allows the use of multiple threa=
ds to do
> >   * the work.
> >   */
> >  extern int selinux_restorecon_parallel(const char *pathname,
> > @@ -146,13 +146,13 @@ extern int selinux_restorecon_parallel(const char=
 *pathname,
> >
> >  /**
> >   * selinux_restorecon_set_sehandle - Set the global fc handle.
> > - * @hndl: specifies handle to set as the global fc handle.
> > + * @handle: specifies handle to set as the global fc handle.
> >   *
> >   * Called by a process that has already called selabel_open(3) with it=
s
> >   * required parameters, or if selinux_restorecon_default_handle(3) has=
 been
> >   * called to set the default selabel_open(3) parameters.
> >   */
> > -extern void selinux_restorecon_set_sehandle(struct selabel_handle *hnd=
l);
> > +extern void selinux_restorecon_set_sehandle(struct selabel_handle *han=
dle);
> >
> >  /**
> >   * selinux_restorecon_default_handle - Sets default selabel_open(3) pa=
rameters
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index de56b727..364f955d 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -387,7 +387,7 @@ struct security_class_mapping {
> >   * offsets for a particular policy.  However, that strongly ties the b=
uild of the userspace components to a particular policy.
> >   *
> >   * By using this function to map between integer offsets and security
> > - * class names, it's possible to replace a system policies that have
> > + * class names, it's possible to replace a system policy with one that=
 has
> >   * at least the same set of security class names as used by the
> >   * userspace object managers.
> >   *
> > @@ -689,8 +689,8 @@ extern int selinux_trans_to_raw_context(const char =
*trans, char **rawp);
> >  extern int selinux_raw_to_trans_context(const char *raw, char **transp=
);
> >
> >  /* Perform context translation between security contexts
> > -   and display colors.  Returns a space-separated list of ten
> > -   ten hex RGB triples prefixed by hash marks, e.g. "#ff0000".
> > +   and display colors.  Returns a space-separated list of eight
> > +   hex RGB triples prefixed by hash marks, e.g. "#ff0000".
> >     Caller must free the resulting string via free.
> >     Returns -1 upon an error or 0 otherwise. */
> >  extern int selinux_raw_context_to_color(const char *raw, char **color_=
str);
> > --
> > 2.53.0
> >
> >
