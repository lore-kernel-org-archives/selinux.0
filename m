Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8632ED58
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761069; cv=pass; b=WUE8sLC9qaFX/X3QbT5c99W8mMQPSiliQahE0W+cEQukFNDKRAnCEQxxo/tivmlmU6DyTEp8j3E2jnPLXrxkIbvF5uJztNeIYVx6fnMbb7QFvjh5ScHg3fnZfohel1n9rQhIBee5KydGST8YA3B7e4x4PGKt/FXRWv1qTBNStEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761069; c=relaxed/simple;
	bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAjqBncCKCul+1eB0YFNlsQJG5dA+5YkdRBLYJX+hozqo55PmPwhH37BNsIrkzsjtcIIpAqqMX62L1slAlBYHrwxYcEINlH5ICu7HWlfeI2SId1qysxF707AOyxkn2NeeVpjmgPQHueRr05gxxC7gqy9814iL1RhEGQjdw7Z8QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4QhHqXc; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4QhHqXc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cede6375caso143885ad.0
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 09:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787761067; cv=none;
        d=google.com; s=arc-20260327;
        b=j+QLNkzIXA5qYTfr8iY/6KlalfG0Ii2ZWQD+IKykI/dmGYTpgG2HJandgrO6DonKBA
         NfwIMSIDxnmXLf35ldpq9SeICms+C8IjZlmoJTy3JAHcLwLpwmCYsE7lX8SMEwx8cv1H
         k4gPQbibKe6qSrLsN5Yd38ugpQCrNGfONXUUET+CpXK7YNKKN3neBF7lZRwI8NAychsV
         CWOKIQ/5VsOqOQK1p02nrR/6cJroQDnhlHc5XbUJ5gytlv8KMGWmqd+OrztvWMzE9eWD
         FDi6LZlf5rG1/ZuA7kQEERVOlZyR38mbooP5SifVgwEO/bbBiK30dhVH+qr43R1XTTax
         n/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
        fh=IJCZ+qUkbYL86gHfE427h+bPGWVeJ4pwcNebAks+W78=;
        b=G43xM1NIWaiiOVoPEwE9UJdPuLNemQaE0cdAKH8Mv3CBYBC4JT11nRCxcfpm83ldVq
         88uctmjci6CCfrUijRv3uMdlp9EHAIIZzcu2temKhS7+nnuiBY1e9/I9SeX65spkToTZ
         IsDhNLBe0GUn55qbAIi/Uo3lqXGNrQiNl0tIQYI5VOtHvIy5mFvdmqGQdKtBeFunOlVi
         +Ke0fImXcBXCm85DeUD7NeEYn5UDnB1+d6MD+ru2K88EfyelM4BNtV0VMvVN1EBORXyC
         YAEJXdPXWs2wSW8uy9RYPR+abdYEVWXIleG9EnTRg4DXYkP88lbJyJrbwjqzXti85n8D
         2hyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787761067; x=1788365867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
        b=a4QhHqXct0MduGzVvbw1MsWUUPpJFSF/I8Ms5YisVYGeSN9NfyA8AtB89KL4nhOoZj
         x/Uo8PTJ1pwKE5XHih44zVuP9NPAbjo6iQjan9/tq7zLQSUjSaQKBfzyerxUdFyFbVCv
         furBmExqjQkZNJYqx18G2+HvJixKoRKLG/ttfW+T+WyJ7gGoc7yR8EhfhMHKmc1K1GV0
         QWaEyY2m+ie898e/TtQ6mDD8E4I9CLXdFiLEYVHuJ/2ECB/xAKM0Kesw1FQmKnQUJBBR
         RtuLM2mxblQGWognI6/k8wF3kCdlvn2LDCo6pFLLq1/0wobE2KjgUhJnC5GvaOw37NAa
         2tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787761067; x=1788365867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
        b=cXZMpad8rEafbQLPpsdPH97IPTgKz3zR7QwsekzCsBrHiwaICtiyMyUramQkS0J3XW
         803h9U/20aKTlLWAIPtpmSIbbob9ktj5FH2SSXpcqOa+ULWCjRo/GPNf5cbTfHbUv37s
         ey/a0pgyAs3o7hoS45byo3yIqKEQmfxFrHU/awpacTWrLQna5Xs3YTCQXqhZr0TBNUeH
         3vYrEBHssZelBy5X3PB1QauKup5gXJEjEl0Yn435UeiFZ+1vc3eGLoPkJ/Rjw6N+BlVX
         U2KcMe76gJjaRiiIfI5LLm6LZ2Q+2b5lktlYI6cQGPKSeTocZBxdm16eDpio2nKaV9XL
         gkOw==
X-Forwarded-Encrypted: i=1; AHgh+RrJv5+VXrsj/wWtLJ59pMpxhpZoexEy87f9QH1OHrZ6f5rZCgyIgYNB7TFs04qGSVTBZJ/KYpBL@vger.kernel.org
X-Gm-Message-State: AFuF++ldF/fPTnrO9Gdxfaz5H+2wuRJpYDW2fMFNneQJ1wK6cZjqEbM3
	+lAHjfPSq5l2bqaG+xJ6PWDtaT0+lqghi2RmugHiSe9ciIz2nMAASigLfQ2jxDGYN+K+GZDmFOQ
	QJtDZrvAEUONtEDITw7G7fTsC+X5ki+JBHS8+TJGXvhGjG9covyr/lX7x
X-Gm-Gg: AR+sD13ltH4f/b/FIr4wxPIzggGH0Fzvy0c60DvX384Mul/dDkoDpCA90It+iwIpFYo
	Z5eACXL9P2SBPZcz8wfcsdojfTKadSXnDHO6qd0+0ua+3x9fOvYmWnamgwwLfepJlm2pavF2QWS
	IUKU+clA3+X4WbN+hKdbUisA4MVjWb8WRqeE6RRaEehUq4ZkAtRT6iBLEUUgYElwlppeNc8kfPl
	r34OQi4Y9l9TO5B9GsCIN7k1wVFIFSr26n0XrQzgIlnRI5GoJerEipkC93//ubNr7DyJ5dt0jrS
	9iHQAUlWEdy2IBP0LJUB7jjgNoL8I+9tAwMonc6gDpDujzgqSlx1AKUMQkJAH04+LoEpGBAzTPo
	aNgtE4RPYAoAry/zN1yu1FzH/Awjjdg==
X-Received: by 2002:a17:903:1a2f:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2d7105043bfmr5843385ad.9.1787761066499; Wed, 26 Aug 2026
 09:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <20260825-unweigerlich-biotechnologie-abnormal-accff844337f@brauner>
 <CAG48ez14F42BgHm5dKeP4g8D_6CNhnAfF7BXdcBwa4NdtFiaiw@mail.gmail.com>
 <20260826-juror-energetisch-hackordnung-83810c82adcf@brauner> <20260826-rotor-heterogen-wollust-2091c20f5e30@brauner>
In-Reply-To: <20260826-rotor-heterogen-wollust-2091c20f5e30@brauner>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Aug 2026 18:17:06 +0200
X-Gm-Features: AcwNN1XyOejgP8xhG53At4w9H1ZIts9vwM506J2nZcs81pxFYrfApeUAbMczaOg
Message-ID: <CAG48ez1s-=GB62T6k5NFjkgsLYJN_eYhDwT2U9UXeTTCZBV_UQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:01=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Aug 26, 2026 at 12:29:14PM +0200, Christian Brauner wrote:
> > It seems odd to just call a hook when it's introspection denied.
> > And if that's the case why not also have a general hook in
> > ptrace_may_access() itself in the introspection branch?
> >
> > I would actually have use-cases for this btw.
>
> To be clear: I have no quarrels with this going in as is. I'm just
> interested in how policy decision such as this can be made more
> meaningful in general. If you have thoughts around this you want to
> share, please do.

A distinction that might be useful in my opinion would be to
distinguish between read access to memory/registers (like for
collecting information after a crash) and write access to process
state like memory/registers (which would only be needed for actual
debugging or fault injection). However, ptrace() makes it hard to draw
such a clean distinction because resuming a stopped task can inject
signals with arbitrary signal numbers...
