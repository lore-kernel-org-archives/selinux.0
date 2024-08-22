Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C03FC2
	for <selinux@vger.kernel.org>; Thu, 22 Aug 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724288214; cv=none; b=VZwQiQALRrHGa9AgBgc82aSvQ5agwZaUKPnx0k/enxzbC0HjMtcQIqGHmWn71zAmX++TrLI/Jf0jxAZ6ekGAosjPZI8EUuvAK8dOjhdnR25+DM4QmOfXSJA2qYSMj7jFAxyaxTPicu9bmvIz4N7kyVDJMPGbVGfUrfmg0+N22xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724288214; c=relaxed/simple;
	bh=C07SRHwKi0NnmrwLs8DevBlhiakawGsiAAbzAuOkIEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ki01DpGRF4Crj7OTk2bGox5YvRMM+lmee266GrBA35MLRjnHsvTHcuTkMGzrjBWqJKaTrkYqVB55CCkiSkEK3N6eX6EUyOYSz19WMAmCsZeNzKGlYakdOz1IQwbHLuRI/OqPrjy2QwHaHFeSYs0k7pyb0HzxOBNt9ZfYlLF5mnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dc9zDLx2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dc9zDLx2"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334491702cso1263e87.0
        for <selinux@vger.kernel.org>; Wed, 21 Aug 2024 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724288211; x=1724893011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcPFgTCw8NZitW6/dw5aalv/KFKt5PMzPABFcMmng8o=;
        b=dc9zDLx26VYcbZAdDfEBweVHty5LPD2jwKY38Ob93lvSnDhZxsEwKgUkuUG4clwenE
         ypyw9/e2oJ9VFkMG9nUhgEU/+BB3QBr+b6JwSYtD1n1fb7db1CF3GkDseji7jzp+n9WP
         rYw8Gzcs7uUMqFpMyhmCHyeTRtZa4YOqsAp452gIPvt4TjnKechjri/Ryk3lJ/Vw0fgv
         6HDYONPlDvR4Lv+Z/6Q/SF7daUFcOfi8TMimDIl+ixW40T3EDppvwoUBjJQX7pV/78ev
         k3iUUcogUosLcmD/r9mS4IUfgkUkMxERRDOnX9m4PsN25wfAxp74upYxIkyi6XuyLLUC
         FdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724288211; x=1724893011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcPFgTCw8NZitW6/dw5aalv/KFKt5PMzPABFcMmng8o=;
        b=A3D7I8+udjONBdv0WMJCZfiXFXjq0lIyJzNeLelSPyOcnWoZI3k3yOUMr0yEShN+0b
         Sif9MqLt5LZVThftnG7XRqZICtu6tpDzn9v6cYJQsR5BzbRwGh0x28PVT5eh9EAttC0T
         TCiTNREck7zDnaKIOFirVQC9/JpHeX3yGDgFFcQpQa84IWnEWYIGcHmJmFhIK0eTWAtt
         PKCLt0nh4N3WbDcOlpkFFPRAeu3M9/3LI3cbxu49KzcfLTtyrJn22N/3xrPt54ehzdjV
         Famkr3CcNqBd5owm7fm/aZpM4Xn4tqRMDKXQzOsACiiYfaXCF9qJP0V93iQSOiCRwvUX
         KyOw==
X-Forwarded-Encrypted: i=1; AJvYcCWCjRC29MQ59I4uIM9XXcqhp4fs+UW6T3Ek9AcmlB4X1alph1Ofe1YfzuP/H/G6XT3MzFWMmfUd@vger.kernel.org
X-Gm-Message-State: AOJu0YxCM7/o9dNi6/5ncWnXHV6sR9wNuFFGbHG4bU8HNfO6VwaeUOd6
	zYByY7TrmwPurzmeohCcC2kEBKaVjRYN3raG8Vn6ITnYNexdP/7g3iegALpZLOIuX0EBr4BDFe1
	9IHVmGTSESrYymsQSf1Hm7T+Q+zc4V+UCsMdC
X-Google-Smtp-Source: AGHT+IG5thIoG5zndNEj12T8UdoP7df8+mm+8knwVlEkTSzG4HBLPx+Q5jpTw1Wu7QkWmJ0ELY81pf5BOoxezEGObFE=
X-Received: by 2002:a05:6512:3e23:b0:52e:934c:1cc0 with SMTP id
 2adb3069b0e04-5334e9a9d92mr32622e87.7.1724288210069; Wed, 21 Aug 2024
 17:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820002723.1345639-1-tweek@google.com> <CAEjxPJ7Jg6vYOQXVr_tT9F4SZcDHN==7LfORxxOACqtn_SRKTw@mail.gmail.com>
 <CAHC9VhQU1oEaS=bB-Kc6Bfukb_MMFv+CrhpJ4F7L=tK8j_c8Ug@mail.gmail.com>
In-Reply-To: <CAHC9VhQU1oEaS=bB-Kc6Bfukb_MMFv+CrhpJ4F7L=tK8j_c8Ug@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 22 Aug 2024 10:56:33 +1000
Message-ID: <CA+zpnLeoz3yuVd5EUtct-CDi2zT9u7Y61edB3s4HbiEfxLOZNQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add netlink xperm support
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:54=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Aug 20, 2024 at 2:02=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>
> Thank you for reviving this patch.
> Do you have a corresponding userspace patch? And for extra credit, a
> selinux-testsuite patch?
>

Thank you for the quick response and initial feedback. I've just sent
the libsepol patches for userland on this mailing list.
For selinux-testsuite, an issue I came across while testing is that
the policy capabilities cannot be updated (that is, only the
capabilities from the original host policy are active). I am not sure
if I got that right or if there is any obvious solution (except
toggling on the new capability in Fedora).
I'm still hoping to get the extra credits by: updating the selinux
notebook documentation as well as updating setools (for sesearch
support). :) I will send pull requests if these patches get accepted.

> > On Mon, Aug 19, 2024 at 8:27=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@g=
oogle.com> wrote:
> > > ---
> > > diff --git a/security/selinux/include/classmap.h b/security/selinux/i=
nclude/classmap.h
> > > index 7229c9bf6c27..c95bf89c9ce5 100644
> > > --- a/security/selinux/include/classmap.h
> > > +++ b/security/selinux/include/classmap.h
> > > @@ -96,17 +96,17 @@ const struct security_class_mapping secclass_map[=
] =3D {
> > >         { "shm", { COMMON_IPC_PERMS, "lock", NULL } },
> > >         { "ipc", { COMMON_IPC_PERMS, NULL } },
> > >         { "netlink_route_socket",
> > > -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
> > > +         { COMMON_SOCK_PERMS, "nlmsg", "nlmsg_read", "nlmsg_write", =
NULL } },
> >
> > I would just add the "nlmsg" permission to the end of the list before
> > the NULL for each class.
> > Doesn't matter as much anymore since the dynamic class/perm mapping
> > support was added but generally we avoid perturbing the
> > class/permission bit assignments unless there is a good reason to do
> > so. Feel free to wait to see if Paul agrees since your code will work
> > as is.
>
> I haven't had a chance to look at the rest of the patch yet, but I
> agree with Stephen.  Generally speaking we should strive to only add
> new perms to the end of the list, I'd hate to hit some odd corner case
> on someone's system simply because we thought we'd tempt fate and
> something to the front of the list ;)
>

Ack, I'll fix that in the next version. I'll wait for a bit in case
you or someone else has more feedback.

Thanks
