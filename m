Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2XaDUhe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3E99
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 08:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702312234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AeWR0R2elkGn75i4GSVVVRMaWKSyc/uK5u6+dsb1PI=;
	b=T2XaDUheCTf0XJsgL9BAgmRs9VhOv6iFWyxNzKo8/AtxKqOYqDsc3td+HPADbEG2gSbhIj
	ilDIKOYHzya0t8K78G9it+L3fdq9Y6goBn7SsA6vPdN9u8NPyJ5Ss/4QVPYKNRNLWX529o
	6f+00Scq5kYtS2fIzmUcez7O+MgxCfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-jJqcj4f-PVirBM5lto43KQ-1; Mon, 11 Dec 2023 11:30:31 -0500
X-MC-Unique: jJqcj4f-PVirBM5lto43KQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6053B881C84;
	Mon, 11 Dec 2023 16:30:30 +0000 (UTC)
Received: from localhost (unknown [10.45.224.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2162A492BF0;
	Mon, 11 Dec 2023 16:30:30 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Subject: Re: Where's 3.6-rc3 and plan with 3.6 release
In-Reply-To: <CAP+JOzRaEO91z1th-zfVi4-pNokJaQqXGDCKGyv=rz+5UWeRvg@mail.gmail.com>
References: <87o7ewsy7f.fsf@redhat.com> <ZXclzTjExZpvWrew@suse.com>
 <CAP+JOzRaEO91z1th-zfVi4-pNokJaQqXGDCKGyv=rz+5UWeRvg@mail.gmail.com>
Date: Mon, 11 Dec 2023 17:30:29 +0100
Message-ID: <87il54snve.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

James Carter <jwcart2@gmail.com> writes:

> On Mon, Dec 11, 2023 at 10:08=E2=80=AFAM Johannes Segitz <jsegitz@suse.de=
> wrote:
>>
>> On Mon, Dec 11, 2023 at 01:47:16PM +0100, Petr Lautrbach wrote:
>> > I consider two options now - a) to release 3.6-rc3 on this Wednesday a=
nd
>> > leave 3.6 to the next year; b) to release directly 3.6 this Wednesday.
>>
>> I would be fine with b. In my experience there's not that much breakage =
and
>> the chance that a rc3 will uncover something significant seems small
>>
>
> I am fine with option b. The only reason I would want to delay would
> be for the prefix/suffix patches, but it seems like there might be
> more work required on the kernel side, so I don't think that they'll
> be ready for this release regardless.
>

OK

I'll release 3.6 on this Wednesday.

Thanks!

Petr

> Jim
>
>
>> Johannes
>> --
>> GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
>> Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
>> SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=
=BCrnberg, Germany
>> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich (=
HRB 36809, AG N=C3=BCrnberg)

