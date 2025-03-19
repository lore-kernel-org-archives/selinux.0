Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD823AD
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390188; cv=none; b=mGFTubS3Yi8PX0BlPuTTo+3cgjpRIzl6mdAm0GGaaRz02x/kRamlJTXejA842bKe5ZGIV8b1v2j8BYHaoNkZj0oGNITU92foH5EKMzdTWsUQmz/5EiwGuffMe8ScQbF7Kl1srrhKnle7pGZ7tU9J0+YlJ6CO0xpQXzNZBq0hgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390188; c=relaxed/simple;
	bh=XjvWqfayuQaTFAiNTJ1nRGZz1jmLlmwbhc8nz2bTn/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyCDrMGIl4+KQLh428qSM8VEd0S394Qf1sn45j3DrdQhMoHaJf/nAeeC1LoKWSAih9YavA9jaBzXbClOFGIu5kPjusOUf7/ZGZaeA+YH/by5s/6q6XlGqOaeppwOXSElO+cug2SvWL7zarya+3duKw5NXOaJbdqZOn19SQlkpZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndsXZ35f; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndsXZ35f"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso8262819a91.1
        for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742390185; x=1742994985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjvWqfayuQaTFAiNTJ1nRGZz1jmLlmwbhc8nz2bTn/8=;
        b=ndsXZ35fkqbsgee5FW/ryHJzh28E+Jd7EtfceTmRAkhknM6+gVQIASUCRamAfqMxbO
         iGcd7GCFsYjCvjYKnr3JgLm6STe7G76PE1wHvjUIq/d1mjiHQ5PUr4AO4kImM4669RXZ
         zO8MswQnRDf2SzIsPHf9qRID26o8VhKm+L6kEa2O6rBL1LHMJYgFiDTF5qs8eNg8cXcQ
         p736Q+ov+JpEXAhrGgudS0owja2o9HOfbfM69Cr2PDC+cNh9ZMD83x/WelaNk5gsb9DM
         LBCmUhpa6TTO04Moej9jYWRi+pJqFtC5PJKKHEtxrNVLgDAdQ7WKPgBV0y054MXXj3kb
         txiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390185; x=1742994985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjvWqfayuQaTFAiNTJ1nRGZz1jmLlmwbhc8nz2bTn/8=;
        b=B8lxmr4n0W/ZToo9n3bGEHmvaV89kkO7Ij4e3H8f79wyoolvCEyU9jq6786dd8RcVW
         eDAaYTdYT+bqo+dL1UjL9VXaly/24Dpq/TNQEgIuEw2otAYML49AdhlYBHBp/H/vCIvd
         vh/NTjxHrVhVArhs5tICFeJREVko+cjBJkyzUOXW2H6aSL0MY3f3vpspKHAUvHNl3m5Y
         uo2bhvTEuQYvACoPVnf+xF3/lMTyiXnRei/Nnio5vTeFWrI4oet/47vHBEABZciy1VxV
         XiogQUVl21ku0yPqwrzVC4J5OzG4ZzkNGeXETL8l+pwaac86z+uybBc22dYRDjQEFosP
         Q8Jg==
X-Gm-Message-State: AOJu0YyN/34DMTPVSwJnZ4l8tOd/DGtsfrF1RASh4bHtoFZ2R0OBV+eJ
	bo6sd8T9Y9qXBCGdz+YOBeyUDAjABeS4RVxdfJMR4xn4Z0qM4zgOcyL1vA24wdfQkVESBulGlHe
	3+fBxv6VUBiUFHa8wixjhK4RMU2c=
X-Gm-Gg: ASbGnctKAjMwmTJgVPNQ4MOD/rzBzkLEkWRZE/sxwSo8pSV+oliVnNGTM8OesUZa1tU
	iLqLiu1OaopCYWyIpVLdf9U9h2VPPLZrR51hzY4PxDNgOy3UHG+/k1dZbv4/qSZWcjtQnj86jsB
	q4CTaZ3ku+FfI6qw4lge5v1FqmEw==
X-Google-Smtp-Source: AGHT+IGoZnI02u9bcfGhpQafq9Ch46olmZ/PFOAtAqLutT48vJaRkCNLCS5eMs68rLAZ3EjyfKuvpjy7Ex2ULWjEhiE=
X-Received: by 2002:a17:90b:384e:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-301be21990fmr3595592a91.35.1742390184900; Wed, 19 Mar 2025
 06:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de> <87senb7mt4.fsf@redhat.com>
 <8ca3a1ed-0f53-4da9-a86b-75699f306f8c@suse.de> <87plif7egm.fsf@redhat.com>
 <CAEjxPJ4DZs_1dPuO87UPpuvQL-PEq6zq9KA64SQvzsT1Mq8CqQ@mail.gmail.com> <87msdi7acy.fsf@redhat.com>
In-Reply-To: <87msdi7acy.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Mar 2025 09:16:13 -0400
X-Gm-Features: AQ5f1Jrp6WQay2PK9BZz0FDdj5EkR4XSSHiE-EWtnZqa9G70dOHg0I0gw26V740
Message-ID: <CAEjxPJ7Q8y+3S-kR6bKmRc8HW+ArDJb1z9D-=sRnWe+zYEW1eg@mail.gmail.com>
Subject: Re: Question regarding restorecon and btrfs read-only snapshots
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Cathy Hu <cahu@suse.de>, fvogt@suse.com, selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 9:11=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Mon, Mar 17, 2025 at 1:32=E2=80=AFPM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
> >>
> >> Cathy Hu <cahu@suse.de> writes:
> >>
> >> > On 17.03.25 15:29, Petr Lautrbach wrote:
> >> >>
> >> >> You could use `-e <directory>` to exclude read only subdirectories.
> >> >>
> >> >
> >> > Yes that is possible, but also requires a manual change by the user =
to set
> >> > this up together with the snapshot (same as telling them to add <<no=
ne>>),
> >> > which we would like to avoid.
> >>
> >> Your -relabel.service's are generated and so can be restorecon options
> >> there.
> >>
> >> Fedora uses fixfiles -
> >> https://github.com/SELinuxProject/selinux/blob/main/policycoreutils/sc=
ripts/fixfiles
> >> - which detects ro filesystems and skip them.
> >
> > We already have logic in libselinux/src/selinux_restorecon.c to
> > exclude filesystems that lack seclabel support; should we augment this
> > to also exclude read-only filesystems to avoid the need to work around
> > this in all callers?
> >
>
> https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinu=
x_restorecon.c#L238
>
> You're right, I didn't know about that.
>
> I think it would make sense to exclude also `ro` mount points.

I think the tricky part is the case where the caller deliberately
passed those mount points to restorecon/setfiles. The current
exclusion logic IIRC won't exclude any explicitly passed directories
to avoid silently failing. But skipping read-only mounts on a
traversal of a subdirectory would make sense IMHO.

>
> >>
> >>
> >>
> >> > Is there a reason why these r-o subvolumes are not skipped by defaul=
t?
> >> > Could they be skipped without a problem and it is just missing the i=
mplementation?
> >> >
> >> > Thanks :)
> >> >
> >> > Kind regards,
> >> > Cathy
> >> >
>
