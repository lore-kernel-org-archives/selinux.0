Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565562;
	b=1CUkqZOFRfpQdxzYBOpke22QmFkUr5yZT4DU6aC5CU4NwtOIn6RVcMWzuOsIZhYAUbA+
	 4b+EohvOz2xhfQ8m4WWVKns3CJYIWdcK0+zxWFADlNzaBs9SlmZCV3bh5wnPJISBRQE59
	 mS605fpIsntWdxNaSk+R+Y3t4rD+MLQ+X6FPIQ7XTzIBudnMc23ZKNsGxeLdifQbObHrA
	 fRJdVKAiMUc5Bomz1CbGa3K8UV0lkY0PMe/mgsTKiMR89Elw/W/z9Uw9uYXAEoq0ukl3M
	 AJqjUCsOxP9Uyt4Kswquwt7tls9jMeV3KsO7Fjv7xd/xYGJFZN9Fd76KyvOjxOFr4ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
	b=EklBPeRrkJTH2EyIJcu1mOOE9pfnRi8widmYjo5lolAHBXk7xnmyxhsMyTiHnTZ9fwWJ
	 Fq3yXr99Sc+e7jZPt2oxfPG6Oz5UO/m9sdh4+fMvdRkZMF6lzCAHl6A4397v2xelIEReP
	 esQO9SCg5gHLj0UuOyOM5bIZRO7rneEEmSRGTZf7Zphs1ZLJzGbbI7TdwKxPD3tRAPgWo
	 9XZrGtiKSVJWTaHoUSg40SyB58r0mIX/sudHTUGbLt+tRcKM5Vai0qmyuoL4Kkze4s79Q
	 M17dkxaRLKYxg8XTx8HppHMbHp/QhtFltSqf/zAxu3A9qUScxxkQwnlvvE4hns7H7SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF36606A88E
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF36606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso1224275e9.0
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565560; x=1795170360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=EhCy1rjVxVdFrlqlBXdnWdhZOgju6UqPO7MHP0T5eDQlLH3bu4fGnJjBmSeu+X4e2W
         fqknndYp9WUsPcSw+hMOJQKeOCVQ26f4CApHOuaHiz0ZnrEcpw06GAGjRX2e/v0KskXR
         kPbczhlJA2JL/E3RYwJYZ55bjMsTqV1bcwrFG/iNBMGzSlTlhWz25UxyOw6nI4axYZSB
         u0krz81cE8qJBpZN+Gj0XIkGJFuZa0vCttP7+3dXPKfvLd7fzcQdMwTNK/JaleYs6P1m
         dJAReh6EvrYwFB4nFlJdvgjX0mrHV5c8k7KozarvFnbaOIXtcKdLHY5nOcL1YTJjLQtf
         x2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565560; x=1795170360;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=ddsJpHPkJQ8ZxOESv92Vwd/cXtJFDaP1aQxeAnEkC1sxlibtTIu1szL0OIk0m0HGpF
         iZamtR+cne8sS8OUXYzUEjEUqD4AEJog3h6adExYre+4eqWEjH7B3mxkAkuaHcrMs2kM
         cx3PTU3eDGbG0JNKkaJ+QWcS3uWElzQoDcLjGe+IrO5qcx3pmYZWrqFocI0N6Y//h+19
         xgHh0TE5e+X60Uogo7aczWXwwOwXWvqZHw5z7I751P0R1GT6CiUwJkZreDyB+VCLBzXa
         5rA9udj6/2NX9MPJW5Mf1KGDPh8oD0RByneNH/eOkozKRqAeAI7VYN43m6F0EvTo9k/a
         CxvA==
X-Forwarded-Encrypted: i=1; AL+hErFr3Vda7QzsbGlxzhismS1XlrShDaSWJXlhWvCTzmzP1xGt5ckKVkhg4Xd6X/HI+BPqssBeYKsT@vger.kernel.org
X-Gm-Message-State: APuU4Z8p83HRHH11/JmdoLJvz3sT7ZxbrOZpcOHvUDPLTEKX+T3nY2cA
	Uv9L+R95Bl+DAsm5TBh6gtBBECQKykp0RKd1kW/lgfDuNSLzp/Q4h8b8Y+4XxURzSZGs
X-Gm-Gg: AYBFou1hedAU95HJglsiLYNHiOWiW+dF/lmuqF9INL4+l2OCiOwqy3fnI8zYZsfTDY7
	8mS6QbDxY/OAVOjhw+EKidvkk93O5pLTJCqA3PtlmBCnEQj+hMU5XEpfQBEor1GX4XjlTn/gWzq
	rqaXdE8Qt5WYvVWWQOCJO6tvnu2oiT2WM9Mw6qUIJ8QHwdT/UP+0/ZbFR2fA2Ue2l0XSPulC8o+
	oRFKsTDFayjgH/oHdP8G+RwCmoZimB4LXJazZRDUZa/1BQcGEDnu5+f1LI2kyqc62Y6AGz6Tr6o
	jh43UHfCETJNO2ZVjJz7VIhpYwEnlJyd2jzrEOeq/Kq5aPKdHIVBqG0zzB9PO1NOELZ3RQOVyez
	bVo70zRW/cCa/Z+vkPvo3tmYjBBXxqqKLKzclwaTrtgnStlIAtdTOwUSz002tnCiGHe21yw2lCw
	cHmHbN5RDOfLF8Av90l1rveS6l4ooB0Mg0X5OLZ9W2awGqEwfFRcCp7NvZKPOUxKLVpqUrRu1Xx
	RV+4dFZE9/lrcEuwTUb6FCu7BZLwSkzaZRVpNuEjt0gZvl2iv7wXQ/NmmX8GksasKWK2yNK96px
	r1klXCEANgVORgcLGLVVubFpqkhRMLP+rxL5BFRFi7uXbWQaN4KkWsBjG5IM5Mw=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr38995625e9.33.1794565560090;
        Fri, 13 Nov 2026 02:26:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm244439965e9.1.2026.11.13.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:25:59 -0800 (PST)
Message-ID: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Chris Mason
	 <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:25:57 +0100
In-Reply-To: <20261111151202.GA11391@lst.de>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
	 <20261111151202.GA11391@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Christoph,

On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> I've seen setups where people use fuse to mediate access to sysfs
> sysfs in odd ways.=C2=A0 No idea if that's still around, but if so, this
> patch will break it.


Oh, that's painful. Do they use backing files for that?
It's a relatively new feature in FUSE...

Kind regards,
Alex
