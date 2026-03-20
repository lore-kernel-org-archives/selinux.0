Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85663D1CAE
	for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026827; cv=pass; b=aZWFE9kVNyiUl2qy3o9D0qaRb6n5SkIGHq5YWTRc1tsTBB037nFDuLtdBX7APg5WX/tnaYTxp9kxuCRKD8mGy3HXNAjXiWxjtEjIgovRZUl7PNeenJWdjeAT0zmjJlUXo1BiagM92SnU57hna4X1rJr6zH/T+pz6OZQQi+JtCT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026827; c=relaxed/simple;
	bh=KGRwSx1IST1owe8mhV0iAQKBoEPPlHadyhU25NThoVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoEtdTQ9Hk5+q6bqD0RKnpO5pKPyDWr7nXrT2PVvcg79hUG84q56nZX44LwWoeCLIr7aHnwG6C9ScBQQnZOt4mG+emGT1Wg7lKLiO/DrR8og8GnP5zxQVTuKXCIW0hla7u9lH17q/XZMh0HkGyTq8E55Wui8jqor4K4eDKLFGXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MMYYueBq; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MMYYueBq"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad019bbd4so807288d50.0
        for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 10:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774026823; cv=none;
        d=google.com; s=arc-20240605;
        b=U2nw51tbXRidMoCfuhvrwbCNYt9ALjs1Vl+WLzgzKTD1R0g0EPus9Yk7DrMpaYl46n
         tL9t3fBQya2QuJODV+qX3isUOFgJtopC/ycXSRa9Gle07A4+0TF40nWxpJDPMM7tWqdR
         +NO30xM/yFchimjc2NV8C+aYfSLhakHxJhWkT3vVtzwBjzZJQ59hEzRKrIYB+5QNW1zI
         sPopsHhbjY+EuEzBgaORmDu3SX1y5aFecptteORuUk3Y5p9TvhGluctroYejIZGouGKP
         sObsr6uMscq0cscjRMxu8cESbs6oiIRlg/6akrIOSgH1rL1wUXjEx+6b/6n8Zccli1WM
         6PRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4IUQRQ7buQSZAOIhN8zLCHB4jEW325MZqs9FGqD9170=;
        fh=8+t9IPeQTqyGiWySCZ7zSKsVGC0IZExJx19zfd5jlQs=;
        b=YbQvIJal2yMaPXmP1dixYpVv6OaWOOoKMO/gb4yJpPfRWOn1jMvVlR6c9VuX3HgOz9
         rRy9kRH8c+WfBVSoBIxk1Y+cZBbqwgwsG6WWQfjZTfOSl32t2BN7/1ei5wRDvH4Acm2w
         D5OB9dQZrpfMCrW54x/dCE2+5EmrkhGBPmXahtmVnBV6rNLhMNNczbx58iH/892Howa8
         Q1WAuthIUOn7MoJnmYl83uz201I4sTT7/qb8VZwDQFTsy3PAeCOg65nt0AA5q17aNclJ
         OHZ3z3yAFBHZgjl9CF79juVAL0tWibgqcrShCiQLwHLOmPhAyXPjwEKs9f2oiIbxPqYC
         m6lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1774026823; x=1774631623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IUQRQ7buQSZAOIhN8zLCHB4jEW325MZqs9FGqD9170=;
        b=MMYYueBq31VW1arYne9U1kr7uJSN+xSBGe2Geg24oSe46G1AC9tbzVQ8L6WDcwwcz7
         X3hdMb0rvh6+c4TDzYAJ3gkFnm0wv8ieMuLMK5+qZz9pqaz3aFtVy/ewARGSKMGg81M9
         F2CVzRyLDKAVP1T8vJj3ixNKXYD8usPoYuMLeVF6/8gyVLSl1mDZVSctGrmQgYWA7kju
         e00rA3a05xD/UHmPjLKHR0eJbkPIt7vqy0u/nIXCaAuwQ1qfisYTRsFFo+7qXOnO22gf
         i29ZDp0eRo4Yutzk/k4omYn3p5EAM1uk25fbeVb5cwVCqIIuPrdqCW3Yv+ZgV6vwfC29
         0Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774026823; x=1774631623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4IUQRQ7buQSZAOIhN8zLCHB4jEW325MZqs9FGqD9170=;
        b=Y40MU2TQXhUvUNRG6omRu9NtGVapF4fEYhNSdj+BMraoh1eCMhVv9pAWrfnY2pHmLL
         7SGGfhv1lKVq+9X34hO2JotIPi4fE51QbPXkNs3E6RHMETjjUIkp/DtEI04JThk3OCGm
         VAM62ix64/rJiDVHPnOZvT7EgZUo5mPLnUOxSgo/q2onXmVNSIUgRl9dXNK/ngqKeftf
         5yb8kc9aQDm2HJLdyouw2ZqMy5BkNcD9QT3D5jaDH4N44xJyt96ij4HIEHmP9fz8rI99
         n6MpdZHJ0K3tyBvXMrPk0iIdi0rXY4slbly1jNpULeMSUXzhMc6UQeAdCznmnZvMsOno
         70wA==
X-Gm-Message-State: AOJu0Yyd+lXyV8X5JR4pNnrvE0EtjDDMOpCxAQQpBunfJhnRZtv8AmGy
	h8OPVufnaTV7odGodZOCPm65K/w2BUkxnsrfML0zDb95OOvjhTBgsOsrb93GdUb42UFnLwIT28V
	KaMHf21d5f+JmgewE5gPhxrIxVN07eUAVaeI2
X-Gm-Gg: ATEYQzwglEfD4Ph1UV69KzN+VWEvriS8zRq9+pTSgmUCnhxlTJrwZbMWH4rE6L1u63d
	Ez2C9+t5SKXmQg7GmqLEzYrBnPXxLXyglMXbvaMz/WG+iJtGoE0fgBSasyIfp3khKFOv74OFgGK
	uuC+bI8tu49kNS7Qbr9h5GW6GSa1tWQbXTfNbBdgxPtM0Qwcu6z8LzRgLnLf9ba7lx5VgCzUPS+
	JTC0hcy2INXXVWRIx8Rqk2Yf4J33P2FVqW2C1pmM5G/zRAmVFNEgey8TDMyhHXmtUUnId126DX4
	4Xg=
X-Received: by 2002:a05:690e:1a98:b0:64e:7a54:89ea with SMTP id
 956f58d0204a3-64eaa6a008amr2915205d50.9.1774026823567; Fri, 20 Mar 2026
 10:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306131941.106248-1-cgoettsche@seltendoof.de> <CA+zpnLd0awdRwt=MERAN-xuZBsYYbY1+YDHxN4TrWw_PrEMx7w@mail.gmail.com>
In-Reply-To: <CA+zpnLd0awdRwt=MERAN-xuZBsYYbY1+YDHxN4TrWw_PrEMx7w@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 20 Mar 2026 18:13:32 +0100
X-Gm-Features: AaiRm53VWAuakEc-XBjjF3pAFUPRYZZQt4hCR7Ub0G8o9tCyddUe3y3ROW1H4Cs
Message-ID: <CAJ2a_DcOYVcREmxXaReiWX1d5Zt-2aeU=m=goyvjisKNsY4KCA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: correctly find partial matches
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2026 at 03:20, Thi=C3=A9baud Weksteen <tweek@google.com> wro=
te:
>
> On Sat, Mar 7, 2026 at 12:19=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The current lookup for file labels first searches for the deepest node
> > matching the lookup-key.  Then all definitions of that node and its
> > parents are considered.
> > For partial lookups also consider child nodes matching the lookup-key
> > portion that did not match any node-stem.
> >
>
> Thank you Christian for sending a fix so quickly!
>
> > Example:
> > The lookup-key "/sys/de" will result in the deepest node being "sys" (a
> > parent of the root node).  Non-partial lookups don't care about the
> > child nodes "dev" and "devices" but partial lookup does.
> >
> > Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
> > Reported-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Tested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> > ---
> >  libselinux/src/label_file.c | 150 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 142 insertions(+), 8 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index b785eab6..24b2c765 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -1599,6 +1599,103 @@ FUZZ_EXTERN void free_lookup_result(struct look=
up_result *result)
> >         }
> >  }
> >
> > +/**
> > + * all_node_specs() - Return all definitions in the given node and all=
 transitive children.
> > + * @node:      The top level node to return all definitions for.
> > + * @file_kind: The kind of the file to look up (translated from file t=
ype into LABEL_FILE_KIND_*).
> > + * @find_all:  Whether to find all file context definitions or just th=
e most specific.
>
> s/the most specific/any here? If I understand correctly, it returns
> the first possible result. There could be a more specific regex in one
> of the children, right?

True, thanks for the hint.

> +static struct lookup_result *all_node_specs(struct spec_node *node,
> uint8_t file_kind, bool find_all)
> +{
> +       struct lookup_result *result =3D NULL;
> +       struct lookup_result **next =3D &result;
> +
> +       for (uint32_t i =3D 0; i < node->literal_specs_num; i++) {
> +               struct literal_spec *lspec =3D &node->literal_specs[i];
> +               struct lookup_result *r;
> +
> +               if (file_kind !=3D LABEL_FILE_KIND_ALL &&
> lspec->file_kind !=3D LABEL_FILE_KIND_ALL && lspec->file_kind !=3D
> file_kind)
> +                       continue;
> +
> +               if (strcmp(lspec->lr.ctx_raw, "<<none>>") =3D=3D 0)
> +                       continue;
> +
> +               r =3D malloc(sizeof(*r));
>
> Just a thought: for the selabel_partial_match case, we only care that
> the result is not null. Could we optimize that path by skipping any
> allocation which we know will be discarded shortly after? Or pass down
> buf as an argument, similarly to what's done in lookup_check_node?

Does android have a context definition of `/.+` or `/.*`?
Then that definition would be returned from lookup_check_node() with a
provided static buffer for the result and since find_all is false,
all_node_specs() will never be called.

> Thanks
