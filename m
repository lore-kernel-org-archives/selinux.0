Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3B40DB45
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826250; cv=pass; b=pF87/JOB8YxF8KgyxIq2YvJICpZxbD53lbPvjgbz0D5OoFpeXKqwLPfcbsGcj9lHRufPKURG5bLiQDv/FEtECzw2VoLjHJQi5peQAifCPOwxQOobj9+IkeqvUX8+oHDwVgmg5hZ/pPn9XVU/yn0trh8KtAkm0C3GML9jxf0PXDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826250; c=relaxed/simple;
	bh=GzcQWZAoyu2EaK5/t+8fY2QTwGeo/TIe0l/ZyAvdJf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWXmU4EFjfv9M8lnpTmPx2cBeC8OtpgNimydlaFVssPUIFUiAyeJh4EAWsWRJfGcdman1I/2662UpxGSgKo1IUxBo1qPrhId501HVdxhFqbli/29v+lSZ2vzNNH26FIvzeuRPPTH9Nv9rDvMjzIjjDRszWcK5C9iHxbMbaIa/Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqCRTv+b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIRTcBmd; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqCRTv+b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIRTcBmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785826247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQLsrMLUGP18h/QUpGPIMaEY/r0YXN0IU+NDINnAw04=;
	b=BqCRTv+bE9dKoB3dMIIV+6+7peKQ/c/lST+VeJBtw00w4cdI2fJPSyg0OyesbXcA7d5yH8
	KvQhyHEv1vDRnvNpK7sE54xaPznO/AYwg7Yzq4NFQRPzWVuDCUlFXv0f06M06ucU00V1VC
	Te7AXsn+MDXcORWPFfG2Q6C74Q+EXqw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-VGUnoJvANgaNIZWVDhxiDw-1; Tue, 04 Aug 2026 02:50:46 -0400
X-MC-Unique: VGUnoJvANgaNIZWVDhxiDw-1
X-Mimecast-MFC-AGG-ID: VGUnoJvANgaNIZWVDhxiDw_1785826245
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb687f82eso8394985ad.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 23:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785826245; cv=none;
        d=google.com; s=arc-20260327;
        b=kuk7X6YBnbbIi8OGqPujupyujayPb9CUDOhIMg71epoPEvYAgLV8MkVG1jJ/mzcbck
         hFyZj5UDDQe6aS9roODxUlrX0RbJrJ8YJFdWLz05cCjB16JDebj4wjOtikCQOgYHSpWd
         phoxfU61kZXlg/T6rOvzqDLVcMVIfcR5m6llLokCAgr2kj6Tu9QZuZ/t1nOUokOovZH/
         +6OdrfR6D6OQRaztH+OrVZOpXB/5kBsnqzS9vz5sc3e/GeJcYFDr7WBFPCp1OVRSA/nX
         SRokEItfQwfZGoPMj/9/kEkmmNowausHHg0ZraEOpmBZzGJyMtm+i2c7TVqWflc4rxqP
         XUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yQLsrMLUGP18h/QUpGPIMaEY/r0YXN0IU+NDINnAw04=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=iv/ioP7XvuFRYYr6T4imRL62xWVOkODDPcV5JBsdtin+C1NAwSvIEjsugHLHT756pd
         nyNPBffibeL29OMxYYwO8XuVQ/wbBiSnh5QarfGUgT2gmjrlDJdXoHbYMaUFS4/4CLqF
         1gid3k8DFCCzrN2lL5XDJXxZVshPxwtMzeEaE9uVVcy5gbkBQXw1po0cHDVEbjEY1lfA
         7hk35NGvCufEr4n0rhX8YbO8jtXPSkAYMgfkntKsbWQpgV9LoQgOv/drBEX7H0RloJcx
         Gn0WFKX/kLI6T/riHaLz+JxNxgQxTdOTqJljstQ3wp9U+xCQNSsBnE6Z4hx9bqr/tvO2
         wn3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785826245; x=1786431045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yQLsrMLUGP18h/QUpGPIMaEY/r0YXN0IU+NDINnAw04=;
        b=gIRTcBmdE/ltkXJBrZCgtDnKJa53pjp9I+bFXBqVwjUzbZDSLdYDs9/dSGgP/zni8S
         2D7i973VmkmoSBAbcILM7dLHJA/KaEU0XNXDUtWWm/SKl9iyhBdfFnNSe6UfkQDJKFMV
         cHqn6fdicSFzE2EFb7vu1X2qYQ6i8tf8Iq8aMd8AGxGlfYdX3/1OqLcSU7angUAVvkbn
         ste9a6154n7hr/bjsgvX3Tk1NOUZGRvIZctusatYXkSpqJ97UgOjo9dDBGP2hZV4kwRG
         X3LacdIzncVEg9CNN+mbrPoiP3MdQ10Fq+t/LxDOjCAoDWrn2eH72wtO+JbaKEZ6tY3y
         c+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785826245; x=1786431045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQLsrMLUGP18h/QUpGPIMaEY/r0YXN0IU+NDINnAw04=;
        b=fwdsd5cqLuHTwkrztg/v8kUBERD+HKw1dYRYyMQ6fzV8mh3MQ6cYQbIHw6X+SgmMh4
         CMktaxEashG4PyCLkkdYVmGjyAVKlinZev1FDQNOZyfUaCtT8AxglsWPW625O+LvOAjD
         cJBgQeFvOnUGLRQjSuhfRy35bf67hYIKcgYPanKgroFojHrT3WHSf/OvmZQISS1LiNDB
         Dm8VzyYhRFAw9dfL9EBX1in8Kbawi8b4QWfZi+koN3WAr8TCv+xDB9YlXp4jrMq099P8
         AgWaiygHlVuHMaZjYiap2tVHdak98OMRpHNaQ8Q0A9TThqDJ8FyPh2KwOMQ134kBjnE1
         26Vw==
X-Gm-Message-State: AOJu0YyHqsLIdco/Gbqfl8/6MzxQhtT9LVA/vflDvSdeOpeTkebNmDIX
	VhApZSF9ibpAmbplFRHJ/E9DlB9pYYlZLBrasl5C2dy7vfrLB/doFAX7X/HGvThRg7KPSpylvAk
	7OzvEiEL+Eb783hm+vpijwZt/1LZGa7iF1UF30ZCBwpIpwMs12dQ2Hj3H5R74CV650EcgSwOFVQ
	fXd7ZFlA/j0EI4swmhSVvU8h37xzebtS36A7dnzqg5A+4p
X-Gm-Gg: AR+sD12XtFzwp0or5NAyvGpsEYbi0KJl3buDC203zRHDgYa/sU+udm87YFZ7lNzm0k+
	zux4JOGOfzKztEVU62ZAXapHyxfq7o6H5DBOXTt5xE+jvW8CBwaZV4GOUW0eZbZHm2fty47JRVp
	LJSeL+W6uB+0oMJe1ltYqSS5f8MlLIGDLgyWJywVdAnsYr/uOtJI5Icfd3
X-Received: by 2002:a17:902:ce8a:b0:2cf:47c4:3d1a with SMTP id d9443c01a7336-2d05221f97amr131330405ad.3.1785826245266;
        Mon, 03 Aug 2026 23:50:45 -0700 (PDT)
X-Received: by 2002:a17:902:ce8a:b0:2cf:47c4:3d1a with SMTP id
 d9443c01a7336-2d05221f97amr131330175ad.3.1785826244860; Mon, 03 Aug 2026
 23:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803090152.1456176-1-omosnace@redhat.com> <CAEjxPJ4ny0BcpcYT03xwy6JKdj3sd1y8GgBa9-Fbur1jD3BJ_A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ny0BcpcYT03xwy6JKdj3sd1y8GgBa9-Fbur1jD3BJ_A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 4 Aug 2026 08:50:31 +0200
X-Gm-Features: AUfX_mzmd30r4tLck5rdXYcQaDqkqPuB8wJbM7wOjfpSZPuY44MaH5qnPoGOPkM
Message-ID: <CAFqZXNtSWbBTNPZG6uG5g4UNNnYrO2wYhMHO7ZAvbgTnv3X3_A@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket/connect.c: add missing
 include for bool
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 2:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 3, 2026 at 5:11=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > The below commit added a usage of the bool type to
> > tests/inet_socket/connect.c, but didn't add the corresponding stdlib
> > include (<stdbool.h>). This problem seems to be masked on Fedora (likel=
y
> > some other header file includes <stdbool.h> internally), but for exampl=
e
> > on CentOS 10 or 9 the compilation fails because of it.
> >
> > Fix it by adding the missing include.
> >
> > Fixes: 433c597a6a9a ("tests/inet_socket: add tests for TCP Fast Open")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> > ---
> >  tests/inet_socket/connect.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/inet_socket/connect.c b/tests/inet_socket/connect.c
> > index 067d196..89e85ef 100644
> > --- a/tests/inet_socket/connect.c
> > +++ b/tests/inet_socket/connect.c
> > @@ -3,6 +3,7 @@
> >  #include <netinet/in.h>
> >  #include <arpa/inet.h>
> >  #include <stdlib.h>
> > +#include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stddef.h>
> >  #include <string.h>
> > --
> > 2.55.0
> >
> >
>

Applied: https://github.com/SELinuxProject/selinux-testsuite/commit/665bcda=
2e11f18c342653b0f497eee0444962d4b

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

