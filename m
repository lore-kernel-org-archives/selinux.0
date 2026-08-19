Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3BE48422B
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157845; cv=pass; b=tVt9DuSx51JaN2S1iKh9T1INnE78hiZ1ol850pLGEBhjXCUGiEP4mtn5l4ehd3ecONeBfG9LkPzcjVlRjr9j9PncgAkJ8HdeUYMh08npYg+F8NALG/ohLU3giMgNNk9QH9Z/83G5H/ok+hLl5ZdyJQG/Axje8NDtGQt5uOOOM9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157845; c=relaxed/simple;
	bh=Km4Uqbgm+V20ya1WSRjETqVOQtniRSkpm6rtkoHoyrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIqPXxdPXxfCwYhbteEaXfAKj32lNZbHNwy9qA10AE0vHfi1jXv1YV2XDazZczmN09+5Lidyl8DP3gLYnkzsX3hCRRYVU4rnxt+psPNLSs0AoQlLsUcrKanAstPlTATunCJGt6iaVqfiGbWCiwNZSQMLo4ScfwiIpS5WDnezIx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pd0XenbJ; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pd0XenbJ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39dbe684115so782661fa.1
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 09:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787157842; cv=none;
        d=google.com; s=arc-20260327;
        b=kVoOLq2GiegiV370CWa8mTZJ6xrLFmEkuKxj0xVouJeeqefyXyR4IggTjjxTsX29na
         qBnLLhBMOmV7/nhb3L242du3q14LKie6+EmBr8wetxUGOrMrwl7fvIrRTRzsKOL+CKTg
         YwckQbongaebaMSDdGM/HAJNQjgi/MRgP+iCgZgqfFqRMFOeQ7ZN+iJfQ7S00Iy6BkSS
         QzS/jonQ1gVajMMtCWcl0UZl3UBxOl5jmEU1Kh3CG52p2jbx/dE3N8wyPWGDapZbYObF
         1DdhGPViUT8E5Ll9b48DpfmFrjygDjDZKKRRGMNzaWVNPcOfAU8Fy1S5/RUkE+Z00Qmy
         Xl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YffEvYFOulb0O1z0YthpXPAzJifJ9PyXCtFjEYghysQ=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=gtFUp839RXM73/Ab0dkIaMYCPWhnFqQQzxXL2Len5htXaCYAetOdnyoCjy41UIvc29
         8pchH9RGWKZXo7WwAncGiD8yHOzYRpGhPGc3G46YDhTAclccCJhvecdP7weAeM1MN1XU
         9ugIPBsHLmmjUU5iVvczOQQlP8+ssPeDOFwWTd0S8jgVSdChPed1Oaxq7BTjusR/3YOn
         BCa71q70UHfgbGtlrNd5tOy4J6OR3xTHGk+mHhZTMp+KYnGarRNS82fZCnvJgANkWqrp
         QHhYpT/c95DPs6d6a8WUfW6VhhLdggxuPT4j7YGPTW4Uf0kLhWnXhuovxOpjpW0Tvrsl
         tG9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787157842; x=1787762642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YffEvYFOulb0O1z0YthpXPAzJifJ9PyXCtFjEYghysQ=;
        b=pd0XenbJBWMpkgfO3ddhB+4rKX3TvdZFcjB25pkKvwh96IqNe8Cal9+oflIxrZeCWn
         BQRRM1udAOS85J8fB/XaCAOCCCU330JBY49fLAbNFsnCDETm1oXnDqC/adHBSzQyv4sz
         Kr7w6xlR7eztHpaVsEaf9d63ROBoV/SGW0RUD2XGPuumwvNOrM4pflskk+Qn1Q+ZLOpM
         HnvKNRLGaN3v09pnYwHxOCPb8DHpW21i/Lz9h2QMtsqmixOHUBjVQrJxlOPtlTxGO/El
         /QXm4JU8bJF3G7lihB20FnNigs7n3cmSlT5uBvRcCeg+/Y1INSQ/1OQ0p1D85zkIOM/q
         e/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157842; x=1787762642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YffEvYFOulb0O1z0YthpXPAzJifJ9PyXCtFjEYghysQ=;
        b=dhX4tH4CI+F3muPw0JY15XjFZ8moUXjMN1jn/VqDRQo788HLelg9qwzeuyLd7zz5Rj
         mZHGLwwH/tzefO8Z7Q/O/JceWZJDPFoo+uCVpmRAKpN8IBUiLwTyJBBCjf/QpaXh/MVS
         9Lbyx65o5U9QZNnA4fnE2AN6siXxNPf5v768PgbCicLidR6SmLc5Nd/tuVX8Xgp9VLey
         eV3bVh4lw60uVurbpBYu82FZOUGcEVP8yogJMv7e4IG6Kpk5epGqvg5/o48gmVwg3EC7
         +v6zryH1tb/PXIrwsoFsnRqVHiiFSPhyi7AZeAOdSXWi+LrBms+D8jq43Pbv/7P8f2Px
         fZEw==
X-Gm-Message-State: AOJu0Yz2kFZsFcylP65yB6PNSleXjufrDoGbuqyH7CDZPqdMasATF/Ng
	9a635izcv7/hG4WMYHOB4AcawwOH8eWQx9Mn1I0IowO0asPQr/B49wweB0oHI//pF8BEHlQkNKm
	IFIEaETxCB7Elg8hFQ0KosgTmQaCwLfI=
X-Gm-Gg: AR+sD130o9IZ8DqHPMsDZB6Q3HUAiL3j1ZeZ/yc0fIvx69etAXvV/z1NaQTOjtJjXPh
	f+URW0PnD6os2Z+57hPAzL2vCwAij+NcjjDqU22bN91Wl/YvRVZg1aezaEARupQh3ykExcjm62X
	Mp5HYSAG+JlD/t+utsKncdIdBAHgYKyS4Oydv+sv8mksUokBtoHS4Es3DS6SICkcduf7XwekoGH
	UzhSuoN601Y/t4amZanhf6cOCwQ2ulOEDpMxH+/zgJdFdHBR69wWMfO8fVybBTOTdujy2bWxq5R
	DBsy7MUZfPvjoZQ/8TIC8sdDhmCFQvIm6K2RXxp7dw==
X-Received: by 2002:a05:651c:c91:b0:39f:6001:824a with SMTP id
 38308e7fff4ca-3a19697e16cmr1374441fa.6.1787157841497; Wed, 19 Aug 2026
 09:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819145702.71314-1-jwcart2@gmail.com> <CAEjxPJ4gbhbrGR=o3HKf7KA=0X4XhzDpNByEvWzLUhntAckL+Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4gbhbrGR=o3HKf7KA=0X4XhzDpNByEvWzLUhntAckL+Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 19 Aug 2026 12:43:50 -0400
X-Gm-Features: AcwNN1Xg9JWBEHrhtSafuQTiwna_mvDJQ04fHFTJEdg1scRT2ZHHSQEGCBf_Dag
Message-ID: <CAP+JOzQhyXZCpc-vy=32pdGnmNmeHQ6HTWZ1BcxrZtiUeP3q4w@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Check all the permissions in sepol_check_access()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:09=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 19, 2026 at 10:57=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > The program sepol_check_access() takes five arguments: a path to
>
> Can fix on merge but both on the line above and the subject line it still=
 has ()
> as if it was a function whereas it is a program/utility.
>

Merged with fixed (again) commit message.
Thanks,
Jim

> > a policy, a source context string, a target context string, a
> > security class string, and a comma-separated list of permissions.
> > It calls functions to turn all the strings into values that can
> > be passed to sepol_compute_av_reason_buffer(). Unfortunately, as
> > each permission in the permission list is converted to an access
> > vector, the previous access vector value is overwritten, so only
> > the last permission is used in the access check.
> >
> > Use a temporary access vector when converting each permission
> > string to an access vector and "or" it to the final access
> > vector before processing the next permission string.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2: Fix commit message based on Stephen's suggestions
> >
> >  libsepol/utils/sepol_check_access.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/utils/sepol_check_access.c b/libsepol/utils/sepol=
_check_access.c
> > index fb3b7edd..e80d6464 100644
> > --- a/libsepol/utils/sepol_check_access.c
> > +++ b/libsepol/utils/sepol_check_access.c
> > @@ -12,7 +12,7 @@ int main(int argc, char *argv[])
> >         sepol_security_id_t ssid, tsid;
> >         sepol_security_class_t tclass;
> >         const char *permlist;
> > -       sepol_access_vector_t av;
> > +       sepol_access_vector_t av =3D 0;
> >         struct sepol_av_decision avd;
> >         unsigned int reason;
> >         char *reason_buf;
> > @@ -58,6 +58,7 @@ int main(int argc, char *argv[])
> >                 char *tmp =3D NULL;
> >                 const char *perm;
> >                 const char *delim =3D strchr(permlist, ',');
> > +               sepol_access_vector_t perm_av;
> >
> >                 if (delim) {
> >                         tmp =3D strndup(permlist, delim - permlist);
> > @@ -71,7 +72,7 @@ int main(int argc, char *argv[])
> >
> >                 perm =3D tmp ? tmp : permlist;
> >
> > -               if (sepol_string_to_av_perm(tclass, perm, &av) < 0) {
> > +               if (sepol_string_to_av_perm(tclass, perm, &perm_av) < 0=
) {
> >                         fprintf(stderr,
> >                                 "Invalid permission %s for security cla=
ss %s:  %s\n",
> >                                 perm, argv[4], strerror(errno));
> > @@ -79,6 +80,8 @@ int main(int argc, char *argv[])
> >                         return 1;
> >                 }
> >
> > +               av |=3D perm_av;
> > +
> >                 free(tmp);
> >
> >                 permlist =3D strchr(permlist, ',');
> > --
> > 2.55.0
> >
