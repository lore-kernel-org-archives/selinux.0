Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FC39C64E
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407479; cv=pass; b=hX+YkJV7KdI1QB9iXcRnT2MOzHYruWBEe2k4TMu0vKuqG9ELGWoMmNi4gyrdWLd1/uoMJ/Jk5rqgS3aM0DPV0pjob0BW5Q2mQBwy4ywjbLJ93WF+XxA5W9oFCngKWCdXIOvlTc+uFdYWx66Qkd8CcIipWP1N1npLjqPzspE+XdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407479; c=relaxed/simple;
	bh=UwkOudnym9A1Ruwwfp2czpUI4C1U8S5dr1Pq/sMJ6aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkwNfG4f0ooluM5Fg+q+i6Kcj+ob949AoapAPdoLTq5EcN2RrLuYCPfUqtR3/2xCMpBeOlctOp6Dr9HdcFQP+bSZdq1JTHJsjqwgCByQbYNmnhgS43++aRw+rw5ArRqxB43pUy1iztuOpMkiyxznuOB3i46NEE3mwuVkpfGKJoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIaH0V9L; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIaH0V9L"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516d6009380so1881cf.0
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 16:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779407473; cv=none;
        d=google.com; s=arc-20240605;
        b=KR2j7889jdBd/pjO9v/nyIsf2pKSP2xpd5MxjsLchmS48Ag7ShkrIaNmOprpxuHPTk
         04LuVNjgQREMPdNy89y5T2xRgWl68kWqk7cei+z7xcPruiOMvEVwr9V7043Cv2ws0du9
         x5pFgvXylpEpX11Wh2S/TWiIBcZe+4OnjhNwo4ikCDxcJRojDbR5icY4tbMXnOOAEUSJ
         co1y0AEr24umRvCysXqFRajaEI9qW43Qlt3W1viOAWLZQUo+Nv5kraoPB2eomhYm4x3o
         1ezl3cSHx+Xko+IOnpVFMP7db9BrB2n7zm3nZRegGqlneZedROJDCgUPchwha+tum8dF
         nKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTjldOBUKMAOCSxzqjEUPK/SMKKzChkT4q2/BGJiBrs=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=cLojcIwMIzqjczQsGEp9KldR3dNfUFeEaMEp/uia5ik0fXSuNtvEU6rHo8gW5oIjeE
         97pjbOJDd+emI7FJKV86/Mk9K8ylWYv/CRBXpETuhdA+9p2F4P3Ok22CP33HeZerf2PB
         RtveRGA2qYvWeEAVc0Rn0JaKobu7kdVFn7ww/orvBU/IC+VF/udXw8V8rI9O+NAgx3Ao
         uwV/+ulzWVFf0K+ebaYJK0MR+or0vAHT2Fh5zU4ll6D0sGHocEYWk+hiN+UbKcm0hOcD
         2ggBhhTH09X2Za7B0/8qzIq8Fud8ZJYtl+UM7kaDOFH7Q2falng+d4ocWPhVhKxWjSPD
         IKlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779407473; x=1780012273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTjldOBUKMAOCSxzqjEUPK/SMKKzChkT4q2/BGJiBrs=;
        b=PIaH0V9Ls8pWk9R9A/dcELRu73EmlGhp8uH1gu7UFcHj/d+hDKH5ArdMa5S7TYzy+9
         aBK7q9q9osbIEl8QJiee3IlO/bypiWIcv4wFyyrC4t4pq9cmTtUAP/wgDvdu/7Z0s+Sp
         2+JnT2ABcQo43uv3p6ma9EObPlvaZ7bfxo/XZ+oGxQjDEYog6V/TzIVuUBA1LtfKjFNQ
         epJMY5voyvmULJ1l//7Fm2xNbmnnUtWCpTRpaAv+mbaAQY0YjYIRJH1Q6wUWphozda3t
         tP+QkmB1jGsq9ikEHhX5kzCyzGMsVOJ7twtcD6gvWRuBkMXUqWRbh1TduZ/M0VeNtDW4
         s7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779407473; x=1780012273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTjldOBUKMAOCSxzqjEUPK/SMKKzChkT4q2/BGJiBrs=;
        b=mv4rkWsmwvSh2sU/lQbu/OBoq/QGH07OV1fXvAfHM6j6sQOXkBsrwZt6neGIsuRKfX
         VWb/6tmCMnZu3v7N4Rbd+YOv6yk0CvX/4+ioU0WnswGmg7OVnzQWrhHN71t2+lxGLqrc
         0DFV6dq2VzrrY7SH16mxxrtjZp7ThcYKDLY09sKtHQ5PBz8VFOQKI0Jp+H8uyOVrWcrK
         H4lO19dYYs1eRYWikzYcRkc7ErPe2niKT/uyqhQGnuOWfX3VhZqiXVuHB2WBxHa0GRB7
         S90Wm1tPB2yAQNBVVV8hXyGIOSQcADzRSzJ7ciy12Y0g7hlYOtfXq6OLTbbOUBzu83hQ
         n68w==
X-Gm-Message-State: AOJu0YxVSlCnuRmuIuRtb/NrR0Z/5bqc3EsPugGZUEeRmC9MZa3mPrh1
	H4ryi6+XZ7FJmJI+AW9C3iJK80QdhRXdfkg1YKmmkK+pony4g7XVWMs9HUa/V4yP8wbTR9ekbN+
	++AkQy2J4TZwZCYvhNi1ma5la+BvoOryZsnyu4qTa
X-Gm-Gg: Acq92OHDZ1wQeP0oQQZOuwcJGsv2oPglukQfTHDXJr6kt0jS7hPH31ms+TNpBD+ELRr
	+WcrnZ74oGJ9EPonbvGRPXCQM+8hqj2dq9VsO0lvysebIJk+135jba61YYivkADOYzSZABLzN1G
	t4zRkPoZroTtDETifklCJHreBsx6sJjY2Eh72Cpxcl906OnBVGnYkt9nzdIDmnIi3a/snpqR7sS
	BZx46rua1C/FDvwlAWfJXXiiUikGBysOoTYtqOZobMEK+0FIR6Ye5ssJX8vNm07iyWOA0sVHTLJ
	cLn/BGiE/LD+gXlE1jriTVXuc+jrxeRwkJZ+Ro8zbBx9cv4AJ20bFSVLvJQ68ULy7pbVOAeZCHy
	tdcK06bBNnpPi
X-Received: by 2002:ac8:57c5:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-516d7b9a3e6mr512601cf.1.1779407472290; Thu, 21 May 2026
 16:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427195546.91395-1-jwcart2@gmail.com> <20260427195546.91395-2-jwcart2@gmail.com>
In-Reply-To: <20260427195546.91395-2-jwcart2@gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 22 May 2026 09:50:55 +1000
X-Gm-Features: AVHnY4IQO73HXSra33c6D6YJwQR4MUYEtOA2fZox8nsCyV3u2vLJCJuDSpxE1Lc
Message-ID: <CA+zpnLe1e61K4s+7dQV3Qxo9WWgPLNEr-biMGWatmrdM8V-oBA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] libsepol: Add a function to output CIL
 declarations from a binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 5:56=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Add the function sepol_kernel_policydb_decls_to_cil() that takes a
> binary policy as input and outputs the declarations in CIL format.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/include/sepol/kernel_to_cil.h |  3 +-
>  libsepol/src/kernel_to_cil.c           | 92 ++++++++++++++++++++++++++
>  libsepol/src/libsepol.map.in           |  1 +
>  3 files changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/include/sepol/kernel_to_cil.h b/libsepol/include/se=
pol/kernel_to_cil.h
> index 60346ad1..1db0383a 100644
> --- a/libsepol/include/sepol/kernel_to_cil.h
> +++ b/libsepol/include/sepol/kernel_to_cil.h
> @@ -2,4 +2,5 @@
>
>  #include <sepol/policydb/policydb.h>
>
> -int sepol_kernel_policydb_to_cil(FILE *fp, struct policydb *pdb);
> +int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb);
> +int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb);
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 06cf4498..9ad7d443 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -3533,3 +3533,95 @@ exit:
>
>         return rc;
>  }
> +
> +int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb)

It looks like this duplicates a bunch of code from the existing
sepol_kernel_policydb_to_cil. Could both functions be refactored to
share the same logic? Thanks.

> +{
> +       int rc =3D 0;
> +
> +       if (pdb =3D=3D NULL) {
> +               ERR(NULL, "No policy");
> +               rc =3D -1;
> +               goto exit;
> +       }
> +
> +       if (pdb->policy_type !=3D SEPOL_POLICY_KERN) {
> +               ERR(NULL, "Policy is not a kernel policy");
> +               rc =3D -1;
> +               goto exit;
> +       }
> +
> +       if (pdb->policyvers >=3D POLICYDB_VERSION_AVTAB && pdb->policyver=
s <=3D POLICYDB_VERSION_PERMISSIVE) {
> +               /*
> +                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> +                * but only in the type_attr_map. This means that there a=
re gaps in both
> +                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> +                * can refer to those gaps.
> +                */
> +               ERR(NULL, "Writing policy versions between 20 and 23 as C=
IL is not supported");
> +               rc =3D -1;
> +               goto exit;
> +       }
> +
> +       rc =3D write_class_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_sid_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_mls_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_attributes_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_role_attributes_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_boolean_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_alias_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_bounds_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_attribute_sets_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_role_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_user_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +exit:
> +       return rc;
> +}
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index 2b103993..8785cff1 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -297,5 +297,6 @@ LIBSEPOL_3.6 {
>
>  LIBSEPOL_3.11 {
>    global:
> +       sepol_kernel_policydb_decls_to_cil;
>         cil_check_neverallows_against_pdb;
>  } LIBSEPOL_3.6;
> --
> 2.53.0
>
