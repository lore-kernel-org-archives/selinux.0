Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C07442F
	for <selinux@vger.kernel.org>; Thu,  4 Apr 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235615; cv=none; b=rzneSLDeAdOof2zIQfnWhjCyxMqNeBy6UAL0qA32F4VGqDoHBqg/N71D8W2IdiwFZIxz8G3n7GUXJFskU76aYO6OjsgRY6JszvriNIniG3mmSil/8qa2xzJ42NaMdgfNnZy/5C8Jhw6WeLunli+3c9O8QQViB2M+hiLGS0zrqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235615; c=relaxed/simple;
	bh=66Q/o6J5YMXvMiPRZzIoBojWcHEUtSX7xhvQJAT3yTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBv4PRwnpCOpOjT+Vulh+qUsWqVrQw+8ZLHMQ/xHoV74uWZO5wlArkArQdlPJokTqxlUYlbFIm98id4jkKqQPTVZmiZIo7jyQJEcuorGd8yOaYUgO+RPg4VUD3BIiB6gY4iHXdl+QijzrjrxpkjmHvcaTuuOpqdfvx9PUSD6HUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwnPf/zl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwnPf/zl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712235613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJkpvdgkFTj2qXCxr5vKH7jDGmMVs/rKWRhLLKkfGPg=;
	b=KwnPf/zl4SmW3IiecWEjGn8ubI/VMo5ZcXEsI1TbtMiUn3f38evOzVdXEHtcHxNf6Uwx9m
	NxQMfBUQdx5z3POiu5UVM7g2YIzv2PJNhdXvBXTsvWQtc7GQimjgZvwB+1zIAGHO/mnqLM
	baUvfiF1NslaEzQbMq9wKUgJxQbXmrY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-imfJ0-GKNVm0EF82_ipYMw-1; Thu, 04 Apr 2024 09:00:11 -0400
X-MC-Unique: imfJ0-GKNVm0EF82_ipYMw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so879276a12.3
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2024 06:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712235610; x=1712840410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJkpvdgkFTj2qXCxr5vKH7jDGmMVs/rKWRhLLKkfGPg=;
        b=eJb7XdMbk1f+NHf4caSBTetUog3KKqxvNQtwTBqd0H9ZUGpelD5aLmNlGUj6AiECqe
         xKMgIRXkuI+OzxoS3MdUTTiep0OH4DnoNvohVvAMkqEIA08kFtx4FfAvw57WLiebl2f7
         nevE+O19B4sBQCxanQVlT0BkC2H7edhUXGqeN06XC2mQUpUHXykbg7stOmf2Ep2pQvij
         AcOfJ6cq6xCd88sGw24XFxKI1O46oWOl8lcODa9PKIKKmqIZWehkPwbMIPNMvTYSNd1P
         bS+OGwuDihuZEaXS6acAACnRAR4K5kCrnxaDCPfUtYB7EEaGuUx0LMPFQBPX+eRgzqrw
         z5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4qbEVrlsnR/WjkksQbHahvnTwK9oBxw4Jgb6qKbLX08IfpeAzHbJtqM5cPsOyvKDptPJCz6HzPnkeRqGFIcdmz4EOv4wuQg==
X-Gm-Message-State: AOJu0YxWzMGUxU/4glppYnKs6+NjkepX9XSCAtq71hzq8J/TuFIlh+VC
	sQ/2h+6QwMOYq237jQEaPy1smCpg142GkJr3qAH/xsBE97PL+caV9lr5bsWC/ThJOYbf+qwx0I0
	EWNGoeQOJeTDInaDGfDYQXth9V2qNxq8O0hHhVe3TP/XEsqF1hFBSaoy0Dq2/jiNNtAkO1SiJ+s
	xF+LmARqNu56N+R+stPeqKeqIh0obx8VU7amolKvdq
X-Received: by 2002:a05:6a21:1506:b0:1a5:6bfd:6bdd with SMTP id nq6-20020a056a21150600b001a56bfd6bddmr2818470pzb.50.1712235606688;
        Thu, 04 Apr 2024 06:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIwf6AuTpKrth5bCw/jYQJ7YX6plk7AFxTlPGbXFSgSqfWM4ZyT164EcujHQBQ4hoc0VXJb90EWEwtOiK2Xmo=
X-Received: by 2002:a05:6a21:1506:b0:1a5:6bfd:6bdd with SMTP id
 nq6-20020a056a21150600b001a56bfd6bddmr2818413pzb.50.1712235605878; Thu, 04
 Apr 2024 06:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <722b90c4-1f4b-42ff-a6c2-108ea262bd10@moroto.mountain> <CAHC9VhRU2OC2EWNAsiLKXAqH_QHYiD9Sytu1rPObcQmofCL+Gg@mail.gmail.com>
In-Reply-To: <CAHC9VhRU2OC2EWNAsiLKXAqH_QHYiD9Sytu1rPObcQmofCL+Gg@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 4 Apr 2024 14:59:54 +0200
Message-ID: <CAFqZXNstaBpRAPqtLDa9vurVSGGv0-XYw7ded85+84g94Lo3xA@mail.gmail.com>
Subject: Re: [bug report] selinux: optimize storage of filename transitions
To: Paul Moore <paul@paul-moore.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 8:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Apr 3, 2024 at 4:38=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
> >
> > Hello Ondrej Mosnacek,
> >
> > Commit c3a276111ea2 ("selinux: optimize storage of filename
> > transitions") from Feb 18, 2020 (linux-next), leads to the following
> > Smatch static checker warning:
> >
> >         security/selinux/ss/policydb.c:1953 filename_trans_read_helper_=
compat()
> >         warn: missing error code 'rc'
> >
> > security/selinux/ss/policydb.c
> >     1916 static int filename_trans_read_helper_compat(struct policydb *=
p, void *fp)
> >     1917 {
> >     1918         struct filename_trans_key key, *ft =3D NULL;
> >     1919         struct filename_trans_datum *last, *datum =3D NULL;
> >     1920         char *name =3D NULL;
> >     1921         u32 len, stype, otype;
> >     1922         __le32 buf[4];
> >     1923         int rc;
> >     1924
> >     1925         /* length of the path component string */
> >     1926         rc =3D next_entry(buf, fp, sizeof(u32));
> >     1927         if (rc)
> >     1928                 return rc;
> >     1929         len =3D le32_to_cpu(buf[0]);
> >     1930
> >     1931         /* path component string */
> >     1932         rc =3D str_read(&name, GFP_KERNEL, fp, len);
> >     1933         if (rc)
> >     1934                 return rc;
> >     1935
> >     1936         rc =3D next_entry(buf, fp, sizeof(u32) * 4);
> >     1937         if (rc)
> >     1938                 goto out;
> >     1939
> >     1940         stype =3D le32_to_cpu(buf[0]);
> >     1941         key.ttype =3D le32_to_cpu(buf[1]);
> >     1942         key.tclass =3D le32_to_cpu(buf[2]);
> >     1943         key.name =3D name;
> >     1944
> >     1945         otype =3D le32_to_cpu(buf[3]);
> >     1946
> >     1947         last =3D NULL;
> >     1948         datum =3D policydb_filenametr_search(p, &key);
> >     1949         while (datum) {
> >     1950                 if (unlikely(ebitmap_get_bit(&datum->stypes, s=
type - 1))) {
> >     1951                         /* conflicting/duplicate rules are ign=
ored */
> >     1952                         datum =3D NULL;
> > --> 1953                         goto out;
> >
> > It's not clear just from looking at this, if it should return zero or a=
n
> > error code.  The way to silence these warnings in smatch is to add a
> > "rc =3D 0;" within 5 lines of the goto.  Or a comment would also help
> > reviewers.
>
> Thanks Dan,
>
> Based on the comment and rest of the function I believe the right
> choice is to set @rc to zero before the 'goto'.  However, let's give
> Ondrej a chance to comment and submit a patch.

Yes, it should be set to zero in that path (and already happens to be
as a result of lines 1936-1937). I will send a patch to set it
explicitly just before the goto to make it clear and less error-prone.

Thank you for the report!

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

