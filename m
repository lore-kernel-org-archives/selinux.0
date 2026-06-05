Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE13D567C
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686471; cv=pass; b=XDZ9nC1YRwknZe5PpLUgqL3oc5Yc8QADOWhfiad9Pl8Mki7JJEsOzmYd++/NLjNrTVzDFTQ7ivRIXdXjb9s/CyPQd0kYlCbMlYqK3IboOpSqxCnB2iHlt89WRqOEjBGf+eiGzy8ai4dNfqpf8xmZ4zJXZ873QKfAyw2WXYCF/xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686471; c=relaxed/simple;
	bh=8a/4dmqYFer3H2jOgQ4eCEgdZ5V1QLGeQW+yirc+UZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMDok+LOzkPmvvVvRpAkyFpMW8r9Hlgsyx5ceAYassdHg9aUTqpoBDDaSVRPAy6XCkLLEMPlVyxA/xQeXbKKx8FNyO3BW3/+73JWe0bPzlGqoa3zQUuBGhdcvdeWVeAD5vC673r2UWIbOm6T9vb3ZjnTNFrYTZeKCRp17bjHuPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXZX+Ftm; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXZX+Ftm"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so910520a12.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 12:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780686469; cv=none;
        d=google.com; s=arc-20240605;
        b=JJU/K14jYKz53NifYZXDvLz8DswvJWzJmDvZ6UKC52RsYNQRVMcao/9ArhrxFA/seJ
         Dsdv8mS3BqTNpSM4Rf7RXMsgHRxNAUz1ZssfvFRxA9IX/kE3PoN3OalwK6p8DM/XmtXk
         CGT5itXpUkdELZ+ckWCDn2vWrcy8/D+Dlg4MMtZZtcJSbKtkAbUBSCv5zWmVht03B+pS
         hwu4Xkvpo6ZAM3WRCleqldh4PO+u6HWDgIJrsGlU5mDIbYsPgiIPj4b96seqZfB19yso
         Mgi3gWMq+Lwcn1p866zYwqJjrQxSV5I3NJpt7QYP7znHlhVxmE/rw6PB5qmbU38O9R7r
         p24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aSPQronovPaTtw3w6roOViELCRDd31G2g8qCfu0zQ98=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=hmJGbdQr2EefOTeXW3SxwuDGMVbOOxAkmgj4dQaA8D2nWBHlHvw2h3BoZWglRHuWzg
         7CNo5RtLE4jPYPGLWhi2mV7l6yiFXQ21KiHCjbE0I+XygBhVsqlZ+wB6xTjq2NStLCQB
         4ef+3lAfifP4DgFXLMUnf0SvQeGm1m6tGHbbEorDnI/5FhWncysCq9/jDfGygAA8MzdR
         yj4JNecYa1l3+2az8NeldXXsamET9jL24/YD2VamP2VOpwfnef3U81NMafatVxTdBbxK
         1HiuzuEIeVrDhS3nw8VzK4py2ZYoO1MIu4jOcE9BAqwVVcd9/MwK/m9Sdrqi6q3I9kMU
         IeOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780686469; x=1781291269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSPQronovPaTtw3w6roOViELCRDd31G2g8qCfu0zQ98=;
        b=aXZX+Ftmk2asJDGwB3p6qdNn+67LqpI/FfKq3Gi2KZo/HKqju5jqQcCW0BuR4u/0GE
         n0J76/ZUw+KQndUd/vOoLieOdCfNqGAGGM6ntOd0oLsqVj+oxMOUkOLUl+6XsCu4VxRj
         kTgQSX0xD4q9SQ8NgF4n+9apoEPkVRx1bMNSnjFK0aJKHFN983MotLJC/mux9N1PiZGn
         K8yHgNqOUmX/T6tD4W9fRavp6oxP0ZOsSRhLKp65/HMimreYoI+GGTRViqHBYWo16P89
         nE+p7KGjy5Hq3kxBjaqzVgj6HrIWlIRQD5useb2otAPdpAGWgR2McoKC2FcJtZ0koKfB
         k6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686469; x=1781291269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aSPQronovPaTtw3w6roOViELCRDd31G2g8qCfu0zQ98=;
        b=DJVX0zaofrVa6qxqs6/NODLtWBYYK62LE4x/f4XCYpd/7flVkmbLZYJ0L0ZTr+NbW/
         et17XOLv12iJVepDgJa55Zu8V9mXCW30ac8y5Cd5ZSqxQZTo9NPtM0swur10VeITLMQh
         j2XvbzOq4etDPsngF+XKQxciXCNpMcavSunNkGO+Dr9+TWHZGyEwWpWDS+qFwyHuFd2Q
         +uQC1YGWn4FG3kXXRcDoeGYy3h/vvNLQgrmwwnPMB82S7wpMfLjPBOxbrOoPSO/zyxx8
         OAtDxeYTd0atJ9ISJbXJoYLOSTLlpyppIvX2NDF4EyFSuQKQn+py6M2F90SOi0uYavM4
         J1Pg==
X-Gm-Message-State: AOJu0YzP8KknCBg0eRxKQq5Iy6O4dalLZmdYTDhaO3BanM9w1gu9/sc+
	mg7bLpoCf3Iy9eRZk9hF7In6T1FKxDLqP8fjOHgQGBCzs4ld8SqqufyfGNwpf/L7K0XUZu0Zkol
	Ke6vASAG6zWg/ZZYJkgkgp112YFVtM5c=
X-Gm-Gg: Acq92OGVklVdoUzgjaXXv+ZbJdI0tOJD2PwZ0yLOB/+oBRJ4xxCTsBX2iVS3tTes1YC
	y8Xyyrs25804NMfyslhl7LiNyqlK95Ll5/yAU1tkx0II2XrmAindPcoq7U8EuJNjZ96OyKvQyyX
	6ghwM/YgCPL4hj0TFaiHTyZV5im5tf0nm1XIlK8LD54Jb5J1pp8Pidq0kHr5dp7vW3oxibzqumu
	/MzvsaQytXfYdRjRutNLsXN2deVfI3xpdPc0i1Pp9Bq8M8UcGekkI3q4gbd7vi0w6HtqKPGE1BY
	ysgriv9QeBt0d9w+8Q==
X-Received: by 2002:a05:6a21:9d4c:b0:3b4:8f2c:6805 with SMTP id
 adf61e73a8af0-3b4cd0801d5mr6035123637.42.1780686469170; Fri, 05 Jun 2026
 12:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605155259.112585-1-jwcart2@gmail.com> <CAEjxPJ4z-iLUAC3J5X6_FKNCxfNpG7jHFMDkG3ctdCD9sNPbCw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4z-iLUAC3J5X6_FKNCxfNpG7jHFMDkG3ctdCD9sNPbCw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 15:07:37 -0400
X-Gm-Features: AVHnY4Jp8tJsZ-vetVYojKcSqTvf26NApkbVGTV7Pv3mT2YjxycyjBXx8iUoKq0
Message-ID: <CAEjxPJ6fVPO9Bssw9qJhAw9bCRWW9HCk3uSiDgWQDZUfut8Dbw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Need to add to the length rather assigning it
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2026 at 12:11=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > When writing a policy.conf constrain expression from a CIL policy
> > all user attributes need to be expanded. This includes lists
> > containing users and user attributes. When trying to determine the
> > length of such a list the calculated length of the users in an
> > attribute was being assigned as the length rather than added to the
> > length.
> >
> > Add to the length in this case instead of merely assigning it.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> >  libsepol/cil/src/cil_policy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_polic=
y.c
> > index 7f20b7b7..85c01050 100644
> > --- a/libsepol/cil/src/cil_policy.c
> > +++ b/libsepol/cil/src/cil_policy.c
> > @@ -384,7 +384,7 @@ static size_t __cil_cons_leaf_operand_len(struct ci=
l_db *db,
> >                 cil_list_for_each(i1, (struct cil_list *)operand->data)=
 {
> >                         struct cil_tree_node *node =3D NODE(i1->data);
> >                         if (node->flavor =3D=3D CIL_USERATTRIBUTE) {
> > -                               len =3D __cil_userattribute_len(db, nod=
e->data);
> > +                               len +=3D __cil_userattribute_len(db, no=
de->data);
> >                         } else {
> >                                 len +=3D strlen(DATUM(node->data)->fqn)=
;
> >                                 len++; /* " " or "}" */
> > --
> > 2.54.0
> >
> >
