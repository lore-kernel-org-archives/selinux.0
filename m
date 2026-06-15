Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8240F8C4
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542295; cv=none; b=Zukol0fqIQCqbRw/oF4037DPf9oqWlVa+YG7bxPX4u7N1lFu23VqmQJaTiwlFbKzCGBM5XI9NaUeleZI8q7RZuQ5rO5hNXtR1wZondUbN2W0wWY2V0hHADxpxxkfru/WQn8ppfdcAtA+iI36cliWLb4znFl86Nd8n+Khm6aye+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542295; c=relaxed/simple;
	bh=8IPrCl5+72Q2Dd3wG7cIyAoLIuYF504XoWSi5a1Qcno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5M+TgxoAa8xNRDbogegLcrhrtvdDSkLZmhuHlC8LhXl4MZ9xDvfxZWSMpV+i5L92gCMfBAL+28Qi3BtGiDYRZ4rBkyXtHhUQJKeUxLs9kchp2qzVHfO2O1pNPFiUT8dztnaQBdnngy+HP9xLJptVM2orcGNyhfzEejRuTIgRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izwM3uZV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izwM3uZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781542293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Eu75rO5M+BODDIdAZjXhqBt9loutNSvATZ2a+7dwps=;
	b=izwM3uZVrA9OouMLbAM6/TS8Q8XIrL4kmCGlNYzbdsMxJS64wqOQaCVGPlINKqcaH8pRmf
	AVU0Oyp7gNXbVDh5mdfWwmVwYw9KwjBxPkju0sGOE0JNnQuD9G5dneDJaNZtpfr2CR/eSe
	SN5YAM/tqUtf6kKoCkyNp35dhJAlj4U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-0nW9TjmmNsqFy2RqK-4E1A-1; Mon,
 15 Jun 2026 12:51:27 -0400
X-MC-Unique: 0nW9TjmmNsqFy2RqK-4E1A-1
X-Mimecast-MFC-AGG-ID: 0nW9TjmmNsqFy2RqK-4E1A_1781542286
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D7EC1956060;
	Mon, 15 Jun 2026 16:51:26 +0000 (UTC)
Received: from localhost (unknown [10.44.32.87])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB37619541B2;
	Mon, 15 Jun 2026 16:51:25 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
 selinux@vger.kernel.org,
 jwcart2@gmail.com, omosnace@redhat.com, Pepper Gray <hello@peppergray.xyz>
Subject: Re: [PATCH] libselinux: add --undefined-version to LD_SONAME_FLAGS
In-Reply-To: <CAEjxPJ7K-TankL0uBE10mapBCh++SCkSNn4xx7ZEXa4UzuKT_g@mail.gmail.com>
References: <20260611130351.15988-1-stephen.smalley.work@gmail.com>
 <CAJ2a_DfUb2dWUMO-1Kr9_8j5swjeOHwwp0n7brfQR3-5vg=HmQ@mail.gmail.com>
 <CAEjxPJ4hhWE_9wAywrdPT4UdUJt9cgo6=ckH6_4=2gnxuET6UA@mail.gmail.com>
 <875x3kmb8n.fsf@redhat.com>
 <CAEjxPJ7K-TankL0uBE10mapBCh++SCkSNn4xx7ZEXa4UzuKT_g@mail.gmail.com>
Date: Mon, 15 Jun 2026 18:51:24 +0200
Message-ID: <871pe7n3w3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Mon, Jun 15, 2026 at 4:58=E2=80=AFAM Petr Lautrbach <plautrba@redhat.c=
om> wrote:
>>
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>> > On Thu, Jun 11, 2026 at 2:50=E2=80=AFPM Christian G=C3=B6ttsche
>> > <cgzones@googlemail.com> wrote:
>> >>
>> >> On Thu, 11 Jun 2026 at 15:10, Stephen Smalley
>> >> <stephen.smalley.work@gmail.com> wrote:
>> >> >
>> >> > commit 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
>> >> > introduced a matchpathcon_filespec_add64 symbol for certain 32-bit
>> >> > configurations but added it to libselinux.map. This was benign under
>> >> > GNU ld but breaks lld due to differing defaults for
>> >> > --no-undefined-version. Add --undefined-version to LD_SONAME_FLAGS =
to
>> >> > avoid breakage when building with lld.
>> >> >
>> >> > Fix: #512
>> >> > Fix: #513
>> >> > Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
>> >> > Reported-by: Pepper Gray <hello@peppergray.xyz>
>> >> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> >>
>> >> Personally I liked the fallback wrapper definition of
>> >> matchpathcon_filespec_add64() more...
>> >
>> > I don't strongly care either way. See
>> > https://github.com/SELinuxProject/selinux/pull/513#issuecomment-467461=
0134
>> > and https://github.com/SELinuxProject/selinux/pull/513#issuecomment-46=
74659036
>> > for the argument made against
>> > adding the wrapper definition.
>>
>>
>> Could we use libselinux.map.in and generate libselinux.map build time?
>>
>> Add matchpathcon_filespec_add64@LIBSELINUX_3.8 symbol when bits are lowe=
r than
>> 64, add  matchpathcon_filespec_add@LIBSELINUX_3.8 when bits are 64
>>
>>
>> Something like the patch bellow. Would it be too complicated?
>
> We would need to match the logic used in selinux.h:
> #if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && \
>         defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
> #define matchpathcon_filespec_add matchpathcon_filespec_add64
> #endif
>
> Yet another option would be to allow overriding of LD_SONAME_FLAGS or
> introduce another Makefile variable that is appended to it that can be
> overridden so that the build system could inject --undefined-version
> when linking with lld.

This would be my preferred solution together with a note in README.md or so=
mewhere.


>>
>> 1. convert .map to map.in
>> $ sed 's/matchpathcon_filespec_add64/@matchpathcon_filespec_add64@/' lib=
selinux/src/libselinux.map > libselinux/src/libselinux.map.in
>>
>> 2.
>>
>> diff --git a/libselinux/Makefile b/libselinux/Makefile
>> index aeede2b56e8e..f397967657bf 100644
>> --- a/libselinux/Makefile
>> +++ b/libselinux/Makefile
>> @@ -39,6 +39,8 @@ ifeq ($(USE_LFS),y)
>>         LFS_CFLAGS :=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64
>>  endif
>>  export LFS_CFLAGS
>> +LONG_BIT :=3D $(shell getconf LONG_BIT)
>> +export LONG_BIT
>>
>>  OS :=3D $(shell uname)
>>  export OS
>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>> index 9982faada9ef..5cb104fe5576 100644
>> --- a/libselinux/src/Makefile
>> +++ b/libselinux/src/Makefile
>> @@ -158,11 +158,18 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
>>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
>>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $=
^ -lselinux $(RUBYLIBS)
>>
>> +libselinux.map: libselinux.map.in
>> +       if [ ${LONG_BIT} -lt 64 ]; then \
>> +               sed 's/@matchpathcon_filespec_add64@/matchpathcon_filesp=
ec_add64/' < $< > $@; \
>> +       else \
>> +           sed 's/@matchpathcon_filespec_add64@/matchpathcon_filespec_a=
dd/' < $< > $@; \
>> +       fi
>> +
>>  $(LIBA): $(OBJS)
>>         $(AR) rcs $@ $^
>>         $(RANLIB) $@
>>
>> -$(LIBSO): $(LOBJS)
>> +$(LIBSO): $(LOBJS) | libselinux.map
>>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ $(=
PCRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
>>         ln -sf $@ $(TARGET)
>>
>> @@ -212,7 +219,7 @@ clean-rubywrap:
>>         -rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
>>
>>  clean: clean-pywrap clean-rubywrap
>> -       -rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) *.o =
*.lo *~
>> +       -rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) libs=
elinux.map *.o *.lo *~
>>
>>  distclean: clean
>>         rm -f $(GENERATED) $(SWIGFILES)
>> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.m=
ap.in
>> similarity index 99%
>> rename from libselinux/src/libselinux.map
>> rename to libselinux/src/libselinux.map.in
>> index 95cd53b043c2..9a1b1736aca8 100644
>> --- a/libselinux/src/libselinux.map
>> +++ b/libselinux/src/libselinux.map.in
>> @@ -255,7 +255,7 @@ LIBSELINUX_3.5 {
>>
>>  LIBSELINUX_3.8 {
>>    global:
>> -    matchpathcon_filespec_add64;
>> +    @matchpathcon_filespec_add64@;
>>  } LIBSELINUX_3.5;
>>
>>  LIBSELINUX_3.9 {
>>

