Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177571E32D5
	for <selinux@vger.kernel.org>; Wed, 23 Apr 2025 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745447841; cv=none; b=hVfagYFM8a22cgcmnipgHSZ+CdhwKD8eaU5pEnjDuqyQ+ZQRIFB41BdkWLII7Reu9Y0bFgkCez2Q/2GSLN+bDzuf3g+53oUoOIv8R270rf58BAxee/VFeA9VHcx4ylfuL6Q19KIkZfTdqRXLTNI+kmry9qp5urW4+IWqx34gaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745447841; c=relaxed/simple;
	bh=avtUqeBmY5B3skqwdkmCu6mdcQHoN1VWs8TnxC010nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aH/3OE4Jki8EOpP9KkfK7b2jmrsoQZHFIBdMlTCi1AyZIsfYlHQ0ufyVzJVVKf4E187UcimH7vLN0IH6J6JfO07cEQU20TAwEC3k0yMn4jmy8pw4g8FneFnev1Ds1w2c31EXP/zTOY/+aFE9NYYKgzBcaakYO7m9FFNWnQhfMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WYCim+GQ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WYCim+GQ"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e6df4507690so350232276.0
        for <selinux@vger.kernel.org>; Wed, 23 Apr 2025 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745447839; x=1746052639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uQGDRvOs7kS2meHW1UGgn4K/w+HgRMl9V4mIgw6iMA=;
        b=WYCim+GQ48VqwDYCxIBcd+Zmnu2w+Yn8KE2YgmHpvQJBLY9f3rsBZImk6RPGIDKxs9
         xhjC5j7kG9FVj8REHQ1oADuD7HFF0jw/QwZ7Ahz8jlhBE8IlUd9xrx7eUYbTqngDfgAI
         XEP5RWPHid6FU/UoptvIUP+Nac2RUW0VsEdb3O+DigNgYYC3KvZoQ8BPplr/oMoSrI3W
         kpDdXBx6E+1ZO9Cxnuw+8gLNhfTZTVZl99Keog59ZPrhPYDv1g8lt/EPCqo9LOHf90yF
         iQCBbzp6lxvKoYy0dkhokYypXosC/FYBRzkmXRWVlB8GX3vRqUE4BTAxQeEd2j/eBlUM
         TzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745447839; x=1746052639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uQGDRvOs7kS2meHW1UGgn4K/w+HgRMl9V4mIgw6iMA=;
        b=T565rN7fWwEw1nQSu1Q3gNRjpdAd6BZaK05q4+Dq9oK2VXDujt6EJUh82TFs1Qd0xR
         jEN6pd8TPVpnd2H9y8i9C0BEQrdA4S1P225je3+TGMgPzwxRsLOGmy41wEv7H1jps1Rr
         1wOKMlq15T/cUXzASkb+7i/A4J8erc21E05r4ZDrxxoYmhO4Pl9dAgXJhWMJ/0ohp389
         QQh+d1OHBa6zEYI827IEgO0srTm0cvY4j8/q19CgyCNjSIgGA5SPUbjR0tWmjOz3659o
         zw+oFB/nUdL2aGdoIpffei4tQMh/HB0+CFHO5uBs91o3d9nWLw17QpN4xHT3zUI/j3VW
         VU/A==
X-Forwarded-Encrypted: i=1; AJvYcCUNkcv55DQVk1y7tztGVZUtbJ9plRZ36lEntv7aD0TKeeMuHMK/LJF1ZXytyHs/eLfZWVy1uFA4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35mlhU/hQ77Y7qcqdpsKjI2wM1ucCnXD8+yWKz1iNhDJpxU3z
	X8CFwymCCjoynnQMAGMJoSMOGFzUG6C6i8A2a4j5iNu2T7G43HPrhzsJ2cq/SBjJu/8MoB0MRQ6
	PTThl+KZWLITlqSxYBjNuNRSTD6LUkSpQ/FsONgzle8CQKEc=
X-Gm-Gg: ASbGncu8E9HeMnGwJWDDbeybwHJqIcIeodLZyxh8W5J30t3GJvOocWp/tG3ensDDPtb
	2XkjT+ocF+YZn2wCBxi9oMnDDP6YDaJZIuBsAOPTknPSUD/pIhMd8oMF8FDrhJU0uRwKGTbCoaQ
	zo+Ruom8DB+zYt2Jg+8Th7FQ==
X-Google-Smtp-Source: AGHT+IEYPphP/GjGtUQdGVsgnpITGNVwg9SNmBgcEQxsTr53pRzJWzJ7q2ivYR6poOsXyj9RWdYjfkIpYuRFjJCdf/0=
X-Received: by 2002:a05:6902:1a45:b0:e60:9cf6:ad89 with SMTP id
 3f1490d57ef6-e73052240famr124195276.20.1745447839018; Wed, 23 Apr 2025
 15:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com> <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
In-Reply-To: <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Apr 2025 18:37:08 -0400
X-Gm-Features: ATxdqUGKbiLeWnXDTEO_j0C8Cq43E25eLHb3LpReaRyeWUtSGVz5buJp9FHUbSw
Message-ID: <CAHC9VhTMc0kJo3Fh-CPPMz9WghANRGB6NpZARgvN-srDJeeXFQ@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, SElinux list <selinux@vger.kernel.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 5:22=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Apr 15, 2025 at 10:06=E2=80=AFAM Li Lingfeng <lilingfeng3@huawei.=
com> wrote:
> >
> > Hi,
> > Thank you for reporting this issue and sharing the detailed reproducer.
> > Apologies for the gap in my knowledge regarding security_label.
> > Would need some time to study its implementation in the security subsys=
tem.
> >
> > To begin validating the problem, I attempted to run the reproducer on
> > Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't observ=
e
> > the reported mislabeling of the root directory.
>
> Hm... Fedora 26 is *very* outdated and not maintained any more - I'd
> recommend using 41, which is the current latest stable release. Hard
> to say if it affects the reproducibility of this bug, but it's always
> possible that userspace is also somehow involved.
>
> >
> > The modifications introduced by commit fc2a169c56de specifically affect
> > scenarios where the /proc/net/rpc/xxx/flush interface is frequently
> > invoked within a 1-second window. During the reproducer execution, I
> > indeed observed repeated calls to this flush interface, though I'm
> > currently uncertain about its precise impact on the security_label
> > mechanism.
> > [  124.108016][ T2754] call write_flush
> > [  124.108878][ T2754] call write_flush
> > [  124.147886][ T2757] call write_flush
> > [  124.148604][ T2757] call write_flush
> > [  124.149258][ T2757] call write_flush
> > [  124.149911][ T2757] call write_flush
> >
> > Once I have a solid understanding of the security_label mechanism, I wi=
ll
> > conduct a more thorough analysis.
>
> I'm not sure how the two affect each other either... It almost looks
> like the last mount command somehow ends up mounting the "old" export
> without security_label in some cases, even though the exportfs
> commands that re-export the dir without security_label had completed
> successfully by that time.
>
> Thank you for looking into it!

I just wanted to check and see how things were progressing?  I haven't
noticed any failures lately on my Fedora Rawhide + patches kernel
builds, but I wasn't sure if the problem had been fixed or if I've
just been really lucky :)

--=20
paul-moore.com
