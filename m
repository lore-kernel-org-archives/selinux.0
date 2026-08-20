Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69025B0AA
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239434; cv=pass; b=sqeobOyx1SQtlJn/lj2SclLI9omddtNvwpCOSrHvCZ26Sfc2fUYFCeJDeiIM8GCjOd3m+qLbRIM5+QFraWzvEkYCeZNnGCFsT0j2YYk0v1e0X17H0scFky7u8KObqEVXIDw1sqEHO0+Fc4soO9jBX+f9bW+f+u8l5eZ1j9i9+Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239434; c=relaxed/simple;
	bh=PQ0Uv3fFLVyIJEFAQf/e1k9Wz6QlYJWOA2A7cUy7gUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzMxmPOoc5XV4rFpojPUbn3HOFG2wPG4ya2RXWQt2gBbNqO4PFAiYMf0HAG+EBh/jkRwIn1UT7I3J1nouDnQdn6QcERpdEMmSPaThL3UPCPxJ8KTUSzWEPV/x6nCVS4xIB+YeiE2hcUjUSUEIutzj/jcA89J6P+64UjSTGvig/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noDFYPDe; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noDFYPDe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdf36f63dso71135ad.0
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 08:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787239433; cv=none;
        d=google.com; s=arc-20260327;
        b=Qvy+q2LlXctBjPlSgWK1/NyZLUuGutlAm4o+z8SgfOmCmQYWGL0g0EtWd7kfyc7IZV
         0ioQYkUJzLr2o7crAJ20cijfksO0KTYeUxmrdnuguwVAM2AZmF/A+zhZ4/vcVcb6RjS6
         fQnkerT6fqS94L4lJ1RK2QomlJOvgIg8FyugHBKhxICCIsFxFZScht1/lsXB3VqMo5Xq
         ozPD8Y8fexKULoIX/+3lNKPhM24ExExu2UL5h4lsHJt/SNJlMQjaPxcTvAkh8pQ1Aufd
         Yd6rQ67MdwJJpXr+K0/42vqrz2e2kXkU7U20u33TIyQD1qLW2RHXEVDn8xyIQuFvUQT7
         1A8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lma3KONpFpngSE5q14dN/Z1uVUgszHUnJkkI2Hjlr4Q=;
        fh=JWU1P8axNb6WILrebX06H6g+cbyJQZUGuYdzd4IZBWw=;
        b=a+emrqoKTSfzAjToFSCORbkjh/0si4B7ZKOW0mirpquWnd8hmYt2o5vuf5QyS5nGX2
         ZoOG1zmft05Dm6hD6ccAhi+C3xVz9hkg4qIXfQeQLgwaqWZfL50ILVIE7Yw4V0NTyVjE
         OrQnbMrE2i7HDGACP6XA0hgdtKZa5Sr65t7dt0iUEgKVX3hJ1QzxN/9HIHGs5sZnbWbz
         1r1k/buHgLwo/gizkE7f0feY0M1klNXjo8Tey1x1mGHrN2cjl1LSgIZHkR2dppBS+wYS
         KQrqFjmhh7ucI7OokW1HmujkZaGMZNynq/K6ohco8uGU4RE5EZCPvuEzvf1fVqXZ/Jth
         B5wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787239433; x=1787844233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lma3KONpFpngSE5q14dN/Z1uVUgszHUnJkkI2Hjlr4Q=;
        b=noDFYPDejiltH6Z5HYHHnoLKbKNvBxK/7X421zy0ZEtN9ZY48PRqsUlpy/CbFgtnDb
         GmL/oG6LeakrQ35Xl8ZBN7DHeQMTrKvW2XK7bvtzZ2pfJvTHsDNvHlc5gAseTiQAXsvo
         eeEKGH+09QXLquXcZ65M5eTTOctX2VPP0J55dk+isHR2ryvRq4Wuccl+C5B95XmKPAMb
         kcC7z8fKCLGwQIrvP37cse92VpoG2sQ/A0YnqS5MaO4aEndm1it0NThP6Cak6oANZnA6
         lkcnr1jT+yGHI5z6MDEUqsjq0iprveLmbKDGnMYqXuSUJo9UUnlX8Bv9oKYiiPrDqI/K
         QtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787239433; x=1787844233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lma3KONpFpngSE5q14dN/Z1uVUgszHUnJkkI2Hjlr4Q=;
        b=R0iRL2l7ldMbL0rusjXFJ8Ki4FcPtIVJyL5Fa5vOW+z0+4zAa59kueiYt4Ahwdbhk4
         BwGiZhsAqg1bWYNUheGSGdasdPRvGvnhe3+pt6OfWmy15TzQbxnTFC52vc+L60RBC1bY
         OXNgXOcQ1zz8BqXzfW3q0S37rIFW5bsqm0rrv8xTS0Ex8YQnTAvaUm3IHSxxFiMv959q
         WHQ6NwXOtjz4UcWIF1bm7Sk6/yRvBoi8++M5UpMjBsYw8+BpNQHlPaUURnkjnOfUYliC
         GA28GUo31ZnWWuytQaLtm0eSQNZ4KUC2Tb+HXK7W5tfe4Xv7l4SUSKF8pghZNzIdo6SU
         o8Sg==
X-Forwarded-Encrypted: i=1; AHgh+Ro731lH80Bot5f2NTr/jtupg6PpFB+16pFlSv+4VocUCeZlTSxoiDzNfGRF/QOi6QiPUimsznkv@vger.kernel.org
X-Gm-Message-State: AFuF++l++uvKtEIto/m8UdE7hxJyMsYheV6JPaa1jfHMGGHwYil4daRk
	hJaHHO/6Xta/NsbpfUeGY4KZ1DrNs7Bou6Ef4Hz7rBlD8sUNtB1RZggzko9cg+ELLWJugzkLymj
	WCdRXw092hE8UaQ8iXtJNBleLCPDxRlr8+EPWrQAP
X-Gm-Gg: AR+sD11hZwgal7W82mGmIY6C9/VJlLjnjlifBt43pnd1x6CRduozYN2UbC/xWKYkX8C
	02J3Pzy23Q1cFmoUUT1gEcTeF/qzHGEKwosN9U2LApzDiIwXDWoONan3F9naxlI5qlvZNjCsXcJ
	td4B4+mgHJjErKeGY7asRRx/hG9IENGXDfBW3fd3aOacCmp7jFXJVlgMHZXxo76f6PSr5nV4twC
	P4MsCs57aPuEVMTjWbrhiuVgAn8hv0CCASO8ozQVMfMvtNaE/QuVpmWKBZChHXUd5TDs0Sk/Nsc
	1xSqMmjriQ0qlo4AJLy8nJEjKITOeYGWvTgeQorBtMf/1g9gp89DT2Cg7PNoMZ3AVCeLsW3kRuo
	1NVRqKKUEttude4iTBbdaArM1gEwdYw==
X-Received: by 2002:a17:902:fd8b:b0:2d5:db38:8013 with SMTP id
 d9443c01a7336-2d61eaf0bdfmr8352105ad.18.1787239432253; Thu, 20 Aug 2026
 08:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 20 Aug 2026 17:23:15 +0200
X-Gm-Features: AcwNN1WfGO0jtM01Prl7T2bhwvtOuD_4x4w_Hjk9Mm13CRcqjZxrghBAfwYQIPw
Message-ID: <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process=
 can
> > only create anonymous executable memory via /proc/self/mem if it has on=
e
> > of:
> >
> >  - EXECMEM (like for other methods of creating anonymous executable pag=
es)
> >  - PTRACE (like when using /proc/$pid/mem of another process)
>
> Allowing it if _either_ permission is allowed is unusual in SELinux
> and seems prone to errors.
> Is there a reason to not just require PTRACE always?

Hmm, that might work.

My two concerns about that approach are:

1. This is an operation where a process acts on itself, while PTRACE
is normally for acting on another process. It feels to me like those
are different types of privilege.
2. I feel like blocking this operation even for a process with EXECMEM
privilege increases the risk of breaking existing configurations.

I think if we want to gate it on PTRACE, we might need to put this
behind a policy capability and let policy authors figure this out?
But I'm no expert on how new security hooks are normally added, or
what SELinux policies outside Android look like, so if you think it
would be fine to just check for PTRACE, I'd be happy to go with that.

(I've caused stable regressions several times at this point and am
trying to avoid causing more...)
