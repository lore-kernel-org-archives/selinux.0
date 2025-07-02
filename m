Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BD2FF488
	for <selinux@vger.kernel.org>; Wed,  2 Jul 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476486; cv=none; b=RPNuMZhPd/twjykOMEibXVz2rz/mPoRdGS8px8Njfr9dPzapOMnT8ELIDa8YPkuQg/sm73au8sgjIuholl3xS+XwEX8V2ROtqNyPvzgOs4G5g20QHVUe+RORrdh7qyhx3LAkzJfUAeG9MqQKw9hmYFOYIn7Z0ak66fMyWr+wjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476486; c=relaxed/simple;
	bh=vJG1BmcxbcpP2XntYMHec4ENZ7wl0v+sPSRHMz4g62o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=suz/Dk9wU78/yVtqCbv69ChT70ed+JCE0TuCY0Suc1u80BAmIWO++g++jF/i4PkC4TwZX+74qnXZbCVRf3pLjkdA0cRsn/xqQRXxFZDBiLDMJg9X+hi8AqZaMgJjo8XSrkod9GNrCQPLuJCiAoLPnJzd+tHTJyK4nOE3e7YehA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1WtywzR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1WtywzR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751476483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5aa5J0o0VMA+KBnMtxrf+ZDAmuqZtZx7q123/LhlMV8=;
	b=X1WtywzRh8aMqaS9cQvGnCnQKBA2EI11CkJvhTC07IMIlXj82GrEydkVjxorX8gP6f/IZz
	lBAg8B2FJJaVwuHtAcqRaQcvgghkHwDH5iMlGxk5m3ohkHLv5+kkXX8mgm3JMDcCdivMBR
	/SPwNNP5mZkPnCw0uc1cXXepj615AfM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-7Tiof7POMBu2No6MPGU3Dw-1; Wed,
 02 Jul 2025 13:14:40 -0400
X-MC-Unique: 7Tiof7POMBu2No6MPGU3Dw-1
X-Mimecast-MFC-AGG-ID: 7Tiof7POMBu2No6MPGU3Dw_1751476479
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00D9118089B6;
	Wed,  2 Jul 2025 17:14:39 +0000 (UTC)
Received: from localhost (unknown [10.44.33.158])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 775091800285;
	Wed,  2 Jul 2025 17:14:38 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>
Cc: 
Subject: Re: [PATCH v2] policycoreutils: make `-laudit -lbz2` conditional
In-Reply-To: <CAP+JOzSoaJP7Dqt7G9bKKW9U_4Z-qQkyg3nZNfRtwpzSm_RGBQ@mail.gmail.com>
References: <20250623180645.232680-1-lautrbach@redhat.com>
 <CAP+JOzRhp_bZXDZLnbS3DbYeJYpq0dsVzfchZQ8rCjDkGy-HGQ@mail.gmail.com>
 <CAP+JOzSoaJP7Dqt7G9bKKW9U_4Z-qQkyg3nZNfRtwpzSm_RGBQ@mail.gmail.com>
Date: Wed, 02 Jul 2025 19:14:37 +0200
Message-ID: <877c0q1pmq.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

James Carter <jwcart2@gmail.com> writes:

> On Mon, Jun 23, 2025 at 2:08=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
>>
>> On Mon, Jun 23, 2025 at 2:07=E2=80=AFPM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
>> >
>> > Commit da6cd3d8d7600 ("Support static-only builds") introduced possibi=
lity
>> > to build static-only toolchain. For static builds of `semodule` and
>> > `setsebool` seems to be necessary to use `-laudit -lbz2`. As an side
>> > effect, when policycoreutils is built without other components, the
>> > buildroot requires libaudit.so and libbz2.so to be available. For shar=
ed
>> > builds this is not necessary and had not been required before.
>> >
>> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>>
>> Acked-by: James Carter <jwcart2@gmail.com>
>>
>
> I think this has been superseded by Alyssa's and my patches.
> Correct?
> Jim

Correct.

I'm able to build policycoreutils with Alyssa's and my patches and
without this patch.

Thanks!.

>
>> > ---
>> >
>> > v2: fixed indentation, I was inspired by the wrong file :/
>> >
>> >  policycoreutils/semodule/Makefile  | 2 ++
>> >  policycoreutils/setsebool/Makefile | 2 ++
>> >  2 files changed, 4 insertions(+)
>> >
>> > diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semod=
ule/Makefile
>> > index 7c45831fcd4e..52a68dfcac10 100644
>> > --- a/policycoreutils/semodule/Makefile
>> > +++ b/policycoreutils/semodule/Makefile
>> > @@ -12,7 +12,9 @@ SEMODULE_OBJS =3D semodule.o
>> >
>> >  all: semodule genhomedircon
>> >
>> > +ifeq ($(DISABLE_SHARED),y)
>> >  semodule: LDLIBS +=3D -laudit -lbz2
>> > +endif
>> >  semodule: $(SEMODULE_OBJS)
>> >
>> >  genhomedircon:
>> > diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/sets=
ebool/Makefile
>> > index 1d5148469f01..f68440f90df7 100644
>> > --- a/policycoreutils/setsebool/Makefile
>> > +++ b/policycoreutils/setsebool/Makefile
>> > @@ -15,7 +15,9 @@ BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
>> >
>> >  all: setsebool
>> >
>> > +ifeq ($(DISABLE_SHARED),y)
>> >  setsebool: LDLIBS +=3D -laudit -lbz2
>> > +endif
>> >  setsebool: $(SETSEBOOL_OBJS)
>> >
>> >  install: all
>> > --
>> > 2.49.0
>> >
>> >

