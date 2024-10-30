Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC417579
	for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294178; cv=none; b=BddwGB0m8NPVefR+VQjlmPu3YtSMAf5g9MaLIoS4qIQBzzD4NhzzpkQZK2r7ltj9t9pIZElu2a5C1KEi9r4i92fB6lwfKePkX8l88ljZp8sjcGeKaSShHpBJ8v64vc3bIn1ePkLtOHtwNPEUE79eGVXtX2zGe+pJUfFQ6hnIVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294178; c=relaxed/simple;
	bh=L68giyXt7S2qQIrKmEqmJNdhI/bJ4uDNaXXarfbfvOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0zK6LMrgrYorAKQLxRJsI/CNypTwRFikuUzaX7PuBL3YN1svFXRlIJIk2x8ziH0KluRyxi1qtknNj2gbCDs9Ud5ajVidyFQV3TPuD/16ZoFBSBl8bYW0yVeIUaEEcr8+VpDlDBZFa5h5VH77Qr6IkdqxVWNRnONaXo/CxduGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljx9Z7PD; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljx9Z7PD"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-27d0e994ae3so2887391fac.3
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294176; x=1730898976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh9+YyFSPB/Cdu5xnKmA/NuGoRA6fJNTJkzPvVbcF6A=;
        b=ljx9Z7PDepfIQNbxd2w14AqX8Zw8vyf5k7rPjIgikztUE3BGvQhiirTCyqKd4BFct2
         8kpY6lvzWRgiUmxxpfX6vzXj82lPLwrQDqQB6Akk43TfEPXaMyEY0p5dFSmdYHL7N3R7
         wFUywgF/LCbrTFfQAulP/Fd7lzP9ifoSwPCjyeKgvz4jQRUfRYzmATN8ON+C8W3dCZ1V
         E8OCIryzk3ZKMWLytmW32S/NHpv45x4y7JUMDPLVQUtWP7xxVDiBdn6QARK1a4DEgURa
         eUldPwANToTT029XAk9pa9qHEFq60tzBaDgYnwNgP4E8yYfFe87bEhYme2Q/JmVLeovu
         6Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294176; x=1730898976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bh9+YyFSPB/Cdu5xnKmA/NuGoRA6fJNTJkzPvVbcF6A=;
        b=OCew0tEphaTy48QGi7soIR2h0zBu7EuHs9AZFZOWiUeZBhJ43Er5hlxi9cdCU8Fnf7
         1jMbaQza/zGJB+2J4YQqy0hClTpz9J1ZzJXK2s7bysdNJD1iHHRsuYfwRLndq/yvTwwo
         G/otwvd75d9hkhotZUMpiMi6o+L7X/HfNSgXfsvt22AUXWnAg0ucKB7oWZ+mhpY3mqe1
         Yl6h8OQiqsfbWrWG/PjjngfChHEhu4zHYb8nQLCazkRwT/vF5oTEIgUj/MiZL0cW9/45
         Zb84V6e+MMQ5pTPYI/eMtJuySu3QkwCecndLSsI7EMJN3EagNVgOPSe6N733R1EbXwAw
         byxA==
X-Gm-Message-State: AOJu0YzD72baTVc2ZjfFghDgnJqWJFZKYuSulK0a+4NaCvU/akp0kBsG
	/i6YE6KW6kFomqkJ9xysQ7hhyLNEajmwMdTIPeSp+960E/XBxmJZXPwBhWrDOtOBhfbkZhkhuBY
	rYiHjdyuYkaS51sE1Z/6mPxKQGMeIRQ==
X-Google-Smtp-Source: AGHT+IGnr5nqgTXHXYGLA61ZUVv5osiJ8JZtGRwfCHI9gpU3ReIl14c4vFzwr6zfme5Cym7qyl63htgL8Rr9//dCXlI=
X-Received: by 2002:a05:6358:787:b0:1c3:698:208f with SMTP id
 e5c5f4694b2df-1c3f9e839f6mr747945955d.8.1730294176086; Wed, 30 Oct 2024
 06:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025183014.1826149-1-vmojzis@redhat.com> <CAP+JOzRxvQM=2oUEcrcPn=2OU1oh=MTT3C1zQajo0CMsyE6=hg@mail.gmail.com>
In-Reply-To: <CAP+JOzRxvQM=2oUEcrcPn=2OU1oh=MTT3C1zQajo0CMsyE6=hg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 30 Oct 2024 09:16:05 -0400
Message-ID: <CAP+JOzRMOjjs6Ec1RRMLqO+MpZJF5+8=+FiRaDsHFPN5DSwkCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux/setexecfilecon: Remove useless rc check
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:15=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Oct 25, 2024 at 2:31=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> > Fixes:
> >  Error: IDENTICAL_BRANCHES (CWE-398):
> >  libselinux-3.6/src/setexecfilecon.c:45: implicit_else: The code from t=
he above if-then branch is identical to the code after the if statement.
> >  libselinux-3.6/src/setexecfilecon.c:43: identical_branches: The same c=
ode is executed when the condition "rc < 0" is true or false, because the c=
ode in the if-then branch and after the if statement is identical. Should t=
he if statement be removed?
> >  \#   41|
> >  \#   42|           rc =3D setexeccon(newcon);
> >  \#   43|->         if (rc < 0)
> >  \#   44|                   goto out;
> >  \#   45|         out:
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/setexecfilecon.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/libselinux/src/setexecfilecon.c b/libselinux/src/setexecfi=
lecon.c
> > index 2c6505a9..4b31e775 100644
> > --- a/libselinux/src/setexecfilecon.c
> > +++ b/libselinux/src/setexecfilecon.c
> > @@ -40,8 +40,6 @@ int setexecfilecon(const char *filename, const char *=
fallback_type)
> >         }
> >
> >         rc =3D setexeccon(newcon);
> > -       if (rc < 0)
> > -               goto out;
> >        out:
> >
> >         if (rc < 0 && security_getenforce() =3D=3D 0)
> > --
> > 2.47.0
> >
> >
