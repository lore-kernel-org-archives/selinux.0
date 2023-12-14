Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vkwg+Vam"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D989A116
	for <selinux@vger.kernel.org>; Thu, 14 Dec 2023 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702552377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f72MJnuN1/cm/Dev/0mlmhtD0XSLJacZaVRiLhnCUic=;
	b=Vkwg+VamJtASEHBtQqC077cMbWngakDFVEIzRqAZUz/wuR8cNnyr8ew5eRkJncXK03G+q0
	t2/a4rfWWY4ioXOPt+np3NJZ5+0tt79YNIH0XR/I2ImxKfAyuvB8ZiKMQeZYb/NmArPQda
	tv7pQaGtI+Y+b+9SOn/jQODvFJKoVFY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-tsqCLBVlPJ2xE66K7YCAZg-1; Thu, 14 Dec 2023 06:12:55 -0500
X-MC-Unique: tsqCLBVlPJ2xE66K7YCAZg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d0908565f8so5834557b3a.1
        for <selinux@vger.kernel.org>; Thu, 14 Dec 2023 03:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552374; x=1703157174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f72MJnuN1/cm/Dev/0mlmhtD0XSLJacZaVRiLhnCUic=;
        b=CIVripOAU4/Cg0384paC36LSyaauYQ3ihGq/YQzJFO87/NmxFA4mT1rQBplB22AtUn
         NHCivSb++GX8sIu5IAJ880tCuiMUMQ8yHPTTpwSLxJAjeZ0zxxRd+iMfLqu89dGaOUdA
         6xys9AuZufwT0LI3FXBRAMuMom8+zRPIQ3ARrKshzhpD7+aOYBPCPtae7tkYKV43Wxjg
         Brd5Bo5maao43IxMTsuizkuIu5QJSHh8mQwNC6K2xeU6VKyAQnMVg4FIJvO3Jcl10kCx
         GvY7nh5iB13UYCf34QNIJscgU9INR3eSMVmemzrVjJbFVwSJvyG4913iygCO4Ih3ZRp+
         7zUQ==
X-Gm-Message-State: AOJu0YzuR7jNmba95pvJPLfI312eJiRokC90Ipd+HnX5TSdS3O9tkaMb
	BWKwy/9KXnb01x6gzlS9Ti8R3iItTONfpDajrP3DhWAyYiU4SIu3g57skDX5+zPg/Lak1sJmUSv
	P+GaPvhASljbS2peSGLFUEGFhgpCsqXtZJQ==
X-Received: by 2002:a05:6a20:3d81:b0:190:c386:3eb6 with SMTP id s1-20020a056a203d8100b00190c3863eb6mr10338341pzi.101.1702552374622;
        Thu, 14 Dec 2023 03:12:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA1c/CMcEeS+1zDL88vvudKMYHgJepRndOV9p8crSqiGJQ3oKpXOe7sIBEPnt0dv284xrC4mnCFqnGWX5ErSY=
X-Received: by 2002:a05:6a20:3d81:b0:190:c386:3eb6 with SMTP id
 s1-20020a056a203d8100b00190c3863eb6mr10338334pzi.101.1702552374325; Thu, 14
 Dec 2023 03:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXrfBYLGiNXDKkJa@archie.me>
In-Reply-To: <ZXrfBYLGiNXDKkJa@archie.me>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 14 Dec 2023 12:12:43 +0100
Message-ID: <CAFqZXNvZVzBZhfOvquXDh_1i_ro05iXbEH+hZr3Ct1jDZ92P7A@mail.gmail.com>
Subject: Re: SELinux mprotect EACCES/execheap for memory segment directly
 adjacent to heap
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: SELinux Mailing List <selinux@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Paul Moore <paul@paul-moore.com>, David Hildenbrand <david@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, 
	Ilija Tovilo <ilija.tovilo@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:00=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> Hi all,
>
> I forward a Bugzilla report [1]. As you may know, many developers don't
> take a look on Bugzilla (especially linux-kernel@kernel-bugs.kernel.org
> as no one subscribes to the generic component).
>
> The original reporter (Ilija Tovilo) writes:
>
> > Hi! We're running into an issue with SELinux where mprotect will result=
 in a EACCES due to the execheap policy since Kernel 6.6. This happens when=
 the mmap-ed segment lies directly adjacent to the heap. I think this is ca=
used by the following patch:
> >
> > https://github.com/torvalds/linux/commit/68df1baf158fddc07b6f0333e4c81f=
e1ccecd6ff
<snip the details>

Hi,

this already has a fix pending in the mm tree:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
hotfixes-stable&id=3Dd3bb89ea9c13e5a98d2b7a0ba8e50a77893132cb

More context:
https://lore.kernel.org/selinux/CAFqZXNv0SVT0fkOK6neP9AXbj3nxJ61JAY4+zJzvxq=
JaeuhbFw@mail.gmail.com/
https://lore.kernel.org/all/20231207152525.2607420-1-wangkefeng.wang@huawei=
.com/T/

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

