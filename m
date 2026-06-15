Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABBA37DEAF
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513887; cv=none; b=LC5lL31RXHHAnjiZxFQKVBHshpighND4rkyxyWNI+0cYUnhG8bD93PVsHVv/pfOfP0nVfhzuJd6iPdsBnV11pTgVzNvwgyjO73OSxNi9l3teWDzEbQJNBE65dLCJAd8yVt+lnWWibDtW/XEBXgzZBnQPD8WqrRJyhbGk/hWXpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513887; c=relaxed/simple;
	bh=gxXaJGIOES+Z/Ja3IDtnaCftAr+lr/in+bFtErzGTZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q9gb7BckS1BHiAGDm+y2+EJwYm0bXVjF/HOfTFohLtS73P1PXV4vqVw8LqjDD62OiWedbzyo88xN9Tmk5uuPLmCifaa2d2XponytASKyT6WGzchBCP2ArqX4Y2tz6PZtzb6tat0lGmghEcQpUTFSSNK27qUfVMXZrBbs6jv0fBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkYDt04u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkYDt04u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781513885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZqU/RLTcD7vTY/DMwTGERU8Z0JX8uq5+twtvVVGIKg=;
	b=KkYDt04uuYbYpRJHez1RO7iAO3rSGSoIrKfmsL6RO/+muiCdkWb0FCkPaCwOamFVZ8GeXX
	KViPdpp2U3uJy8G2C+QCrGlxOn8x+C9vQtpi/vdnkj6+dA2GuNFKWJc8WGFG2uLlMZmxHN
	whkdUumkblGhV7zpt+XDw5wX0w6KKFQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-CiI1NX0UNKe4U_yEMPLXEA-1; Mon,
 15 Jun 2026 04:58:03 -0400
X-MC-Unique: CiI1NX0UNKe4U_yEMPLXEA-1
X-Mimecast-MFC-AGG-ID: CiI1NX0UNKe4U_yEMPLXEA_1781513882
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25CD61955F3E;
	Mon, 15 Jun 2026 08:58:02 +0000 (UTC)
Received: from localhost (unknown [10.44.32.87])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C2171766;
	Mon, 15 Jun 2026 08:58:01 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, Christian
 =?utf-8?Q?G=C3=B6ttsche?=
 <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, omosnace@redhat.com, Pepper
 Gray <hello@peppergray.xyz>
Subject: Re: [PATCH] libselinux: add --undefined-version to LD_SONAME_FLAGS
In-Reply-To: <CAEjxPJ4hhWE_9wAywrdPT4UdUJt9cgo6=ckH6_4=2gnxuET6UA@mail.gmail.com>
References: <20260611130351.15988-1-stephen.smalley.work@gmail.com>
 <CAJ2a_DfUb2dWUMO-1Kr9_8j5swjeOHwwp0n7brfQR3-5vg=HmQ@mail.gmail.com>
 <CAEjxPJ4hhWE_9wAywrdPT4UdUJt9cgo6=ckH6_4=2gnxuET6UA@mail.gmail.com>
Date: Mon, 15 Jun 2026 10:58:00 +0200
Message-ID: <875x3kmb8n.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Thu, Jun 11, 2026 at 2:50=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> On Thu, 11 Jun 2026 at 15:10, Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>> >
>> > commit 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
>> > introduced a matchpathcon_filespec_add64 symbol for certain 32-bit
>> > configurations but added it to libselinux.map. This was benign under
>> > GNU ld but breaks lld due to differing defaults for
>> > --no-undefined-version. Add --undefined-version to LD_SONAME_FLAGS to
>> > avoid breakage when building with lld.
>> >
>> > Fix: #512
>> > Fix: #513
>> > Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
>> > Reported-by: Pepper Gray <hello@peppergray.xyz>
>> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>
>> Personally I liked the fallback wrapper definition of
>> matchpathcon_filespec_add64() more...
>
> I don't strongly care either way. See
> https://github.com/SELinuxProject/selinux/pull/513#issuecomment-4674610134
> and https://github.com/SELinuxProject/selinux/pull/513#issuecomment-46746=
59036
> for the argument made against
> adding the wrapper definition.


Could we use libselinux.map.in and generate libselinux.map build time?

Add matchpathcon_filespec_add64@LIBSELINUX_3.8 symbol when bits are lower t=
han
64, add  matchpathcon_filespec_add@LIBSELINUX_3.8 when bits are 64


Something like the patch bellow. Would it be too complicated?

1. convert .map to map.in
$ sed 's/matchpathcon_filespec_add64/@matchpathcon_filespec_add64@/' libsel=
inux/src/libselinux.map > libselinux/src/libselinux.map.in

2.

diff --git a/libselinux/Makefile b/libselinux/Makefile
index aeede2b56e8e..f397967657bf 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -39,6 +39,8 @@ ifeq ($(USE_LFS),y)
 	LFS_CFLAGS :=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64
 endif
 export LFS_CFLAGS
+LONG_BIT :=3D $(shell getconf LONG_BIT)
+export LONG_BIT
=20
 OS :=3D $(shell uname)
 export OS
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 9982faada9ef..5cb104fe5576 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -158,11 +158,18 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^ -lselin=
ux $(RUBYLIBS)
=20
+libselinux.map: libselinux.map.in
+	if [ ${LONG_BIT} -lt 64 ]; then \
+		sed 's/@matchpathcon_filespec_add64@/matchpathcon_filespec_add64/' < $< =
> $@; \
+	else \
+	    sed 's/@matchpathcon_filespec_add64@/matchpathcon_filespec_add/' < $<=
 > $@; \
+	fi
+
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
=20
-$(LIBSO): $(LOBJS)
+$(LIBSO): $(LOBJS) | libselinux.map
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ $(PCRE_LDLI=
BS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET)
=20
@@ -212,7 +219,7 @@ clean-rubywrap:
 	-rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
=20
 clean: clean-pywrap clean-rubywrap
-	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) *.o *.lo *~
+	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) libselinux.ma=
p *.o *.lo *~
=20
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map.=
in
similarity index 99%
rename from libselinux/src/libselinux.map
rename to libselinux/src/libselinux.map.in
index 95cd53b043c2..9a1b1736aca8 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map.in
@@ -255,7 +255,7 @@ LIBSELINUX_3.5 {
=20
 LIBSELINUX_3.8 {
   global:
-    matchpathcon_filespec_add64;
+    @matchpathcon_filespec_add64@;
 } LIBSELINUX_3.5;
=20
 LIBSELINUX_3.9 {

