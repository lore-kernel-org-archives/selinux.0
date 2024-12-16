Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63A1D2B22
	for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390887; cv=none; b=T9j0BjF0yAHC4U/soaKQQrnk3WQs1peTZDOMAPFOpjvSJcY+rrTDsfJ3T2rKBYhmceY08aHWLL9CLLyxS69ugt5xbssy337y/8dSmn4s7KV2yecEaoIC+1up8gmHj1k9qRjij+1wskCEYvl4ADLsVwEONUpHmsusC6cSYaW7Ch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390887; c=relaxed/simple;
	bh=dxXQGSOjocMHrxvQ5XcEZUh2CN/gguzfR45jLnRlvBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxqZkEc9WrpTeqkiX+kF2wlB20IsVDRoAK9B2yFOSVxqkCk4Rxz6s2a7ujsvL3qrRRhpc1OWtDmTpTO2TQC/nD7IwwjLa5F9McYtrpclRfSzb2NL5f9VelR2CqDGxX08UaM1+VQNeJqNeEDcqSrDECXj8S8Adz0OGEOqOz7lQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dIQMJ8rG; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dIQMJ8rG"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3988fdb580so3625020276.2
        for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 15:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734390884; x=1734995684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ilc7kMfy20uqsQSbi1xo+essM7f8+CR9fCShYidt9C0=;
        b=dIQMJ8rGWmLCl2mc7I+1CzzLVh1yDDU/TlwqHTaWk6DbJY9evP2fuRDYuJdhQUTSkr
         diQOrfXXv3VXzbDQA4my769mEapmW8pEy1lYOjeZX2uPK3VPakrULoODDIgst5HN1YJU
         6u+io/VkFw3GGeCZBSMbQpmmYTTzbm8nM28ywEkQfIhKN2fL5/rvWBKZHuSKvMQ6BP1X
         loRm/Ivi7NzDxmBpK1RRmFOPN+/MfzUp2MM27p4nbhSAigEqTQrmE3uoEcFQdcFY2+0K
         XHFmyyhNi1fqHKs506LK1ZluQx+ga4L3q1dBJ3BYUqmKohLVfE+fe6mvO8B/KmEHlJ/V
         lvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390884; x=1734995684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ilc7kMfy20uqsQSbi1xo+essM7f8+CR9fCShYidt9C0=;
        b=oAdSo2C6pVmOpr3V2spac1dHdkzK0LAMVWXtduK8KDpMEtzj7zUKw4nHt0yTIXE9j2
         dVUJwQ8hRAxTIwWW8LBr4s7Zf9G1DSFtyiCsJQshQryVVBjt5DcnKII7yZ0rbmdoJUVV
         mf92dvMAtylZk3d0mbjkMFpEIZKeKsufDTFoeQwT9oui/302ltIJ8jsIcUjnRKhLcSpj
         HjF6fi6Gee9oeg0VrZhxDBS588ekSWno3zY9F0HuhbADvvmkDb7vnhAlg3LP03W9zMyx
         kGB0pZEar41GYIkdJDLzZ5y8ZDDmg63AtSSuQ7cOM2frFRq0hspIG0rIvskyClN7Eh/s
         iLig==
X-Forwarded-Encrypted: i=1; AJvYcCUoeizn8NWJyMLDX/+0EoIfNNJfYgq0cgW711D/mBFO5lFZxmvYSCGT7w9g9j4SvAkhVxIT26hF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6S06v8UTTpWj8LuG0DZY1C5GePUJG+XqjXQzsb3VmsLa+rfWU
	R4F3Oz8OQL3XjMCHd7+EpAK/cAxSat3uN0942AahrMDyJg3EF43kkhzNcCYsA1nOMfz1ALhO8dd
	EXtdk+Exqp881SMGAtAbvhB0s2dNPtLj9lHuC
X-Gm-Gg: ASbGnctTY+Zryw+BYoRR8I2cR6TX5WmGakIjGhEA2n+dbcWt6a8PSkSQXRSojeOepbP
	Xc5pSa8/yjGklxRP3RI5hpBr3A9vhPNwacmdX
X-Google-Smtp-Source: AGHT+IHb7qw3JRzAltBCgzgdVRhzJdusjr3zFhp2NvjDY2Ip12GcaPY3/kxDnDdtPmw/q+xKdMmobMgCiCJnwT/F8/8=
X-Received: by 2002:a05:6902:2010:b0:e4a:9ab:6ac8 with SMTP id
 3f1490d57ef6-e4a09ab714dmr7041055276.39.1734390884610; Mon, 16 Dec 2024
 15:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org>
 <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com> <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
 <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com> <CAH9xa6ecz_P+GwLQ_73_M==WF8cZt3bzD9NJz84U9B4mRdTOrA@mail.gmail.com>
In-Reply-To: <CAH9xa6ecz_P+GwLQ_73_M==WF8cZt3bzD9NJz84U9B4mRdTOrA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Dec 2024 18:14:34 -0500
Message-ID: <CAHC9VhTta96fojwPuf_JRTws92=BLqRPRcDc2sBTddH-50HxoQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Takaya Saeki <takayas@chromium.org>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:50=E2=80=AFAM Takaya Saeki <takayas@chromium.org>=
 wrote:
>
> > > Currently, genfscon rules perform prefix matching (e.g., `/sys/dev` m=
atches
> > > `/sys/devices`). Directly using `match_wildcard()` would not preserve=
 this
> > > behavior, as it does full match. To maintain compatibility with this =
existing
> > > prefix-matching behavior, the trailing '*' is added.
> >
> > Yes, the existing genfscon handling does prefix matching, likely as an
> > easy workaround for the lack of wildcard matching, so if we move to
> > properly supporting wildcard matching, and the policy explicitly opts
> > into using this new capability, I'd rather just see the policy do the
> > right thing with wildcards.  It might mean more work to convert the
> > policy, but this should be easier to understand and more consistent
> > than silently adding a '*' wildcard at the end of every path when the
> > path matching supports explicit wildcards anywhere in the path.
>
> Thanks for clarification. Backward incompatibility will make it challengi=
ng to
> enable the new wildcard feature for Android or any systems that allow use=
rs to
> define genfscon rules in addition to the system policy, since enabling it
> breaks existing user-defined policies. It would be nice we can keep the
> existing rules working.

On Mon, Dec 16, 2024 at 9:06=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> I think the problem with that approach is that it assumes that the
> entire policy can be updated at one time.

A policy capability applies to the entire loaded policy, not just a
portion.  If one is going to enable a new policy capability, there is
a certain responsibility to ensure that the entirety of the policy has
been updated and is correct.  If all that is required to convert older
policies is to add a '*' at the end of genfscon pathnames, that can be
easily done in userspace (and should be done in userspace).

We really shouldn't have compatibility hacks when enabling policy
capabilities, policy capabilities *are* the compatibility hack by
allowing systems to continue to operate in the legacy mode until such
time as the policy has been converted.

--=20
paul-moore.com
