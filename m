Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B41BCA19
	for <selinux@vger.kernel.org>; Tue,  1 Oct 2024 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809914; cv=none; b=AqjuCYn647i/CT2j4zG5CVgSHFejgqHYJ7zNfpLRTVH9CF0Gdetm6M9pg+bX/uwdP2VUG27+IsGQeaN3glQLgIE4nqowP5jA+V1Vmg3Te7KkThasrB9/E98niqcxtPV08GCh/qnSogjtRNfte+fjjwdbLtklrwlgW6bGCgw3e2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809914; c=relaxed/simple;
	bh=vXY12pBnrT7T+7TWxD/RY7fBO0DWnlfXUFUsKSAzgxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXEnzQkGdsFs9pXotI6cvdjdrjMOfZ5l+1XIBhyta8X9xXDRiQcRURe2/UWDXiFipYJFdG46giZ2yNNkJf9c/yMx+iQmvGKR5ZYgV1O1eGET2mNXK5QlcaQFtjhj+VssQN4UKCuDHytDo/ulndvb0L+ntN/hslh9yWDrCMmixtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK0KIFjl; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK0KIFjl"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4464622a12.2
        for <selinux@vger.kernel.org>; Tue, 01 Oct 2024 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727809912; x=1728414712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXY12pBnrT7T+7TWxD/RY7fBO0DWnlfXUFUsKSAzgxY=;
        b=EK0KIFjllgX/ly5GHU5usnWG/M9IYOQbWUozXEdpVLRSZBl5+XnY+xt6sYRL2dh+IX
         TbFrifnDEO4sMGgu6mEdNiEDV9+0L5NPIQBF6M7y7GKVPV5w2Wop2XKqiS+jm7vHiKuL
         djai5OjxYxsb/QcenWMpxthJ60TylfyJX+SfWSiu7fX9fOEIVUC22aoot8G6KE6taLdS
         CZfkExt7zlHHwpCWwN8rIfk0bpbb9MXCQVCfjj1/IjumjPJmhv4dz7xfncGlqa2gV5/R
         fruaemHCgo77+Q8CPiqrBJd2ZRQ8uAdp9HCwnwyq4d7UmsjPpQXZNRXomLIN/siowZPN
         jBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727809912; x=1728414712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXY12pBnrT7T+7TWxD/RY7fBO0DWnlfXUFUsKSAzgxY=;
        b=ZQ/jof8d5bxiFDWXTHZa+YlIxlXbsC8snL/GR2QsWPFbUvXMfCV/Sj82++Iv8aI1IU
         6PYl6wZ37XxpjIwcYYAq8DgAOgl2djyB2H0PQoKIu3Y4RNp4tgk3Nx8bWZJJtJgr+xct
         M1sfz9kzOJMyILKdG40/pr/24y3srOgQl60BF4mr5UKyV2cPg7RDmvKO/R10Lgp5lVyU
         rpWholpVg6lt69EIpim16ToxvBW/EGWyf3eraT/qi1IqrfXI5Wof7vSuoK8/YfGptd1n
         9uzGZMD+tp3giqHT61OGNtRU5G69/RejCh5t7OgDSaewXZP9vHskvAYioBTq4Jw3hJ7T
         Q4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUVDr+ZIn/OtbSvIK3y4W3QvGTtm9C99RSZ42eLKoiZot48rBEwtxOLxlhEZnRRoexmTEpdXFq4@vger.kernel.org
X-Gm-Message-State: AOJu0YyklF2mQrsXS0VUuVFiGk2gtgc/7BCj3gJVn3HzN8JYOHM0o4WQ
	dttsT/OsRj10Lm5gLq5TbP93T90vGjxJx9QPlm9i0FrpPgnL9Vp1mpAu8yHBCmBm9U7oT178OzC
	9So/E8UL3Lcp+smAybSjoRZ+NCtE=
X-Google-Smtp-Source: AGHT+IE5nKuPQXHDEcePNcY35DnzuqyvOCj9aS+gAKq1MvqOFdnxo77yCrIka6U726D1vkFj0YXwvHSMDTYPaiGbUeQ=
X-Received: by 2002:a17:90b:1195:b0:2e0:8740:26d0 with SMTP id
 98e67ed59e1d1-2e18451d6a6mr920634a91.2.1727809912419; Tue, 01 Oct 2024
 12:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
 <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
 <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
 <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
 <CAHC9VhRDF0DBAWM-=ynks1=Zm5LcQYq0_4xfQy4pKvHfW6FoBg@mail.gmail.com>
 <9aa53afd-efd8-4552-8239-14f99ff7a1b1@schaufler-ca.com> <CAEjxPJ6vyDjmwxEpwnb+JYKiWXYFo5g_suZiUZb6L+aepHxZiA@mail.gmail.com>
 <CAEjxPJ4nbCuntgTvrGk4LHs+ZYjm95ZwwSwwAycWWzS9dt9Tyw@mail.gmail.com>
 <CAEjxPJ76MdNwgXtGTgVYGKE87=7GmZywQ1GJn5Vz8jjCdVATWA@mail.gmail.com>
 <CAEjxPJ7Qp9Q4RUYH8vb-xQOe0=YsN=nbyM-4FV6hvYzZwKX5Og@mail.gmail.com>
 <CAEjxPJ4Opxv+HU6cbAfKNT=ZXnUZ=0Ac8ZM5fQj=wnO_JPy-zw@mail.gmail.com>
 <CAEjxPJ7Zpw9i6OXZ-Kz=WXVuCaas5TOtxCAmK-rxGDhm1-zwDg@mail.gmail.com>
 <CAEjxPJ4UsFbFvuigZ+WZD0zuPQ-mY9MRQ-3+SYp_bDwBE_1z0Q@mail.gmail.com>
 <8992e65f-b1f6-4376-918d-c7c81a649c53@gmail.com> <CAEjxPJ4+uju2phxNB0JPA00tYSsHM67y-TNRS-UxG7VpXKe35g@mail.gmail.com>
In-Reply-To: <CAEjxPJ4+uju2phxNB0JPA00tYSsHM67y-TNRS-UxG7VpXKe35g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 1 Oct 2024 15:11:41 -0400
Message-ID: <CAEjxPJ5bZPY8EEz-yTsPs3FLFVsEusnyJsuq0emiDt=o0T5UAA@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Topi Miettinen <toiwoton@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:06=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 30, 2024 at 2:12=E2=80=AFPM Topi Miettinen <toiwoton@gmail.co=
m> wrote:
> >
> > Hi,
> >
> > I wonder if SELinux namespaces could be used for sandboxing,
> > specifically with systemd. When enabled for a service with a directive
> > (something like NamespacedSELinuxPolicy=3Dpath), PID1 could load a serv=
ice
> > specific namespaced policy and apply it to the service as it starts.
> > These kind of policies could be extremely minimal and hardened when
> > optimized.
> >
> > The implementation should avoid interfering with other sandboxing
> > activities and also avoid AVC pollution from them, so preferably there
> > should be a way to set up the namespacing and load the policy in a way
> > that these will only take effect at next execve() call, much like
> > setexeccon(). However, errors should be returned as early as possible
> > though so that the error can be associated with the loading. Also it
> > should be possible to enable SELinux namespacing independently to other
> > namespacing options as they are controlled by other directives.
> >
> > Would this be an interesting use case? Would it need major design
> > changes? Systemd already loads a SELinux policy at boot so there's some
> > infrastructure in place.
>
> I don't think there is anything in the current implementation that
> would preclude such usage, but I'm not sure that's a major use case
> for the SELinux namespace support - sounds more like you want to apply
> Landlock or similar sandboxing via systemd configuration.
>
> At present, the unshare operation is not deferred to the next
> execve(), no different than any of the other namespace unshare
> operations, but that's easy to do if it is necessary for some reason.
> The current sequence as I've sketched in this email thread is to
> unshare the SELinux namespace, mount your own private selinuxfs
> instance that only affects your policy, load a policy, set enforcing
> mode, and switch to an appropriate security context in the child -
> either via setcon(3) or execve(). The policy and AVC are private to
> your namespace. Permissions are checked against the current namespace
> and all ancestors (for the checks that I have converted thus far,
> still WIP). The process context in the child is separate/independent
> of the context in the parent, but bounded in permissions by it.

Also, to be clear, the usage model above is optimal for use when you
want to essentially run a SELinux container with its own policy on a
host OS that either does not itself load a SELinux policy at all or
loads its own different policy. Then you'd just unshare the SELinux
namespace (along with at least the mount and network namespaces for
reasons previously described), umount the old /sys/fs/selinux that
refers to the host OS policy from your mount namespace, and then run
systemd/init and have it do what it normally does (i.e. mount its own
selinuxfs, load a policy, set enforcing mode, switch contexts).
