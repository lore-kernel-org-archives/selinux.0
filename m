Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241444;
	b=pT4m5dWcpovIB94ehA8R7G/4p8UJ7qW2SvaArGVHaVh9JdQRFDQSr5rReIHyBlKUN/L6
	 iQqz5OZuGuNLkR38pivvy65RKJe6TJgYjMhyjiOWbP3VJtCh9lXBET0A9WKJWnK0f8FJV
	 QoFQvImnrLr6AwHaxMdxAFbYSEX1xlv3Ps7N3DGhQtZESOh4YkLVliTl7bctYwDT+tImL
	 ufeIYqSVUklDe4Xb4ifIaqFoEdYURqqPkQLarnHcy4BNTIwCAeRUAarQDV4twfCI+DuqU
	 MlBjfIYgkf3q8vxDc8aaqCfn+cNIatlKYJoK4gvqzkz3uamBHhR9xbSpXk1+BmMERww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WFMEIkXFSWDem+pxKDbBTWU4agrhaHzBdOyiYscj0S0=;
	b=Fokq/5f3uNbWg+6QPMKpyPIjru4DcGh/dgC3CmOIgh89mulaFscbGqALhMCjJPbH3/vV
	 sMJtBFn0TRSVJlJfaWV/osW4iD9bvgAmJWWgWrotWbYfKYgbiJhBXuJsvU0nI7dvGdyUO
	 q4ygodCHms2AHZU0wvn0kvut90ldROrgS2MTor2T0ue+TABYKTRu2aDmjkWIJ0l8vfn+M
	 AURdTJIAdSY4ClUCzoT5EFOW2BKLoK0dg5HRrbmpCTTfyphGduAZQrvr6kjySdOLKyV9j
	 V1J3BJbLmMcPPSDtdmOgucNq/GauI1xe3h3Qd4XTj0rWIi3GaDFObI0dogfsNNqXghA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ApocDFDc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC5606A321
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAAC5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ApocDFDc
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67bf3c6654fso1100845d50.1
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 08:24:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241443; cv=none;
        d=google.com; s=arc-20260327;
        b=hl2FQg1ZlLZWiRxxlfg2fpZRr2UGq00h0nov8V2aY7EsSwjAOxmSHArYo1xKgus5r7
         z+O8H59GsAjLnJNsd2QGAtSzIYcLVt2dKNvinEaDkAI72vuJ2OVFihLtB0DPKwLPqgHS
         OOxsG1GUjl4QB7UFdyUwfgvlqhWnP/zAeD5ku8jt087nwC1tNg8S1FVyuYUMyCHeqS4D
         MVXYnyOjs70/BtuzfTYhkqZ0M8CVur2LIwgGO5WZ6tl0C7Q0i468zMium591Y4XTEcEl
         TOxZLxqXK8ckNN34mJmPOXL462JvxqdZZPJxVCre8a5tXzcnDGCl0CcjCBavMD71hZYU
         XLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WFMEIkXFSWDem+pxKDbBTWU4agrhaHzBdOyiYscj0S0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=QM35rY8DMe/z49HKw3k+GYI4UHI2HOiKkaxGYKKpsUro4LqgHHKD+ifWP8jmCjMnVA
         eGndRPqCmV9MX6lNry880q/uIjDXTDC04JHbbCByYnuol1TRptYR+hkMA3mzgaze4yLI
         UPdoLP9B73wbUWaaC5qCABx6yWsXFuQK+7tbo46UrLDpHVJ7/7DOu4VoNBy2wSzlHY8s
         tto3dvJhQuolAgtwqqrs5Q32VJl2T0baIeWDi1rGchSys8JG1+JpL+55dwrrXE/ZSnpc
         sNENL8oeLCgmobvXi1clTwLDzqYEKyCis5q1YrOhe5bfzsh/5Z11kuHNo5/lk7irr6/j
         AgmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241442; x=1794846242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WFMEIkXFSWDem+pxKDbBTWU4agrhaHzBdOyiYscj0S0=;
        b=ApocDFDcttWfM8zbfWw66D/wtvcKQ10EJgOhPvSSYHygxWU1oXYY2garDDDs/CZRBr
         GLrBYgLyMxY3c5xGQsFTk0whDJJfD2yZyNuvoazyccY6FVtKKQuhp9hAe3H8Qg1s8EMr
         z8SaJm2hW2Pz5hsnksCLfQZuSc9bx3zxoMIBQMslyaoFoS/hKy6ENQFRQXBuQK3z3HEA
         3qbvlhBXh8Kf9ze18olJff3ya53A7UHfYBp0H5LOOxTaxIH/fv6XUFRvK1JRHwRawUou
         78A1jlVBVdqhb4ta2vuoJ4toPFPS9Lv6r8y3+fLito0if89zGWvQ2kBiHQD9eTdCi+uO
         YKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241443; x=1794846243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFMEIkXFSWDem+pxKDbBTWU4agrhaHzBdOyiYscj0S0=;
        b=zeTErvI6b4BVBYmJ17qHgE9QjQhgUqOuQlvJSdPZ0QMQM9MICCvMtdtjP3ufrBZyA1
         409hGYz4Qti42CLIUFv/jI7s9bP/T/j5blXEoLsMDJpz+/mAHThwIzIfMztEB4TTZxOX
         66dZ0XjcQilbS6+XF5ztjJSrY4znpQsK1Zr11aa7/Q9HBlHlqFlKr4aQ3WLmWDIY37R9
         gS2PzVW5czFBmm2cWUZWqRf+CuwZToe4/MxWuO/ueIJ6A+m8U3eYxKqsjCoA889awF7C
         YaBB9NjankQ9Pr6NBGdk97hT2gzKt3wcjeTElVMJhA6CiyNO4AsXIL4hB6WNAwhs1D2Z
         +5Mg==
X-Gm-Message-State: APuU4Z83ixGXW92neWAxY9hSdjpOwsTRPtrR4hFChJCga2ch3ZdW/1oT
	jeqnbj3ET9xC+8tJ9bs/LmNGU3xepc+FKuOZwWtv7Eg4zNMcRDfmW7l6fwmQZZlbj2xuOevAVQc
	UtU9HtSPMpU4+ycqGbQMxs2RE1QKtKwDqTtz6
X-Gm-Gg: AYBFou3rxZo+zv92isE/FisrggPioqNKRKtUCZQ+yINRUS3QsUfl7MwelaOC/x+uqx6
	v9Z/4gCbytthk9eYDGkdYezn3cYx7ovQoaxQtu8S8WLPAJtarbFxf3wmCA0gqkP+wU87I8PTWPz
	PBr6inRVI7ilrc0TpbA33/IyMI+MRzlrhDHEe4j8mP8qmod9MtYGMcIgogojiciXVTY3ZhFXkXz
	YaQBYKvc1qEw5faIRhNhau/LYXJeHoXbnouMdgdHTkFPiRzc7VSibT1kBqJKxf46UhenasTWZqA
	+dSt8fDqcEr4zbwwvIpJGM53G7IYjnILW0SgebFthrs++z44x6T0h2b4h2oRXGSCaeI6zPZ8rcU
	mniPckjJ2NZplAZIaSYlgR0ve4Zuw8YQWA/i1rUdRKYRULZFimqzBkqRyEdW4AM+6tkpcQtOBX1
	ysgJWmCcLnAO7o4gvOhtpearMnRk5FKpZRAWWhbOKGtC8mJ3UoIfvF+uNQBg==
X-Received: by 2002:a05:690e:108a:10b0:67c:288c:f6a8 with SMTP id
 956f58d0204a3-67c5643bcb2mr42866d50.4.1794241441193; Mon, 09 Nov 2026
 08:24:01 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106142302.512540-1-cgoettsche@seltendoof.de> <CAEjxPJ4C=e89ta+1FwErVnc9aFjSTULDG5r_-3b2wYk38USDrA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4C=e89ta+1FwErVnc9aFjSTULDG5r_-3b2wYk38USDrA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 11:23:50 -0500
X-Gm-Features: AclHuK8qD8UumfZGpiA4dS14jIY3wZ1GHDxHW1d0Hvsz4Ag6YQNyOo6LNXR1QUs
Message-ID: <CAEjxPJ70x1phrr5FHK0LyaPVtE3_81yzfoNrZQ4qf8rKgWZ9MA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: avoid quadratic removal of redundant
 conditional rules
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 3:38=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Nov 6, 2026 at 9:23=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > optimize_cond_avtab() collects the redundant conditional rules in a lis=
t
> > and then, for every entry of the conditional avtab, scans that list
> > linearly to check whether the entry is to be deleted. The cost is the
> > product of both sizes; on a modular Reference Policy build this single
> > loop accounted for about 12% of the runtime of `semodule -B`.
> >
> > Sort the addresses of the nodes to delete once and look up each avtab
> > entry with bsearch(3). Addresses are stored as uintptr_t, so no pointer
> > to a freed node is read after its deletion. Should the allocation fail,
> > fall back to the previous linear scan, so the function stays infallible
> > and policydb_optimize() keeps its behavior.
> >
> > Also free the list entries left over after the scan, which were leaked
> > before if a collected node was not found in the table.
> >
> > The resulting policy is unchanged.
> >
> > Assisted-by: Claude:claude-5.5-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
