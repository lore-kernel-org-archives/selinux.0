Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE3516174
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864381; cv=none; b=sx6wgUDLjnJ2v/V5GCU56mfwq05VxeKSjDpmRdJTvYaoB0DE83oPMkwJJMzdVSIAkHGBN+p0BMmkSAIR/A6RdRAcSRKuAYmFuealbftSTtn7AGdMRE72eAJicJN0S3oj+ONgCCEAXuQJnaI7XCvaHcdCTJ0t2YcVQKqlg5vVRxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864381; c=relaxed/simple;
	bh=3+MA97++3DjuWebZS7CcdIYzmjo5u+PQO8dhuqEW9YA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCTmbTQNZ+bv72XrzT8Cfko5J6gHC1ALaHm3ipuehK7sEiCQ/pC5cj0/vuPlDvaY1jRjhTiXSUMBkFxBfbF6C+Pi++jG9f68zEtdxIrinNxmW+VMZzFSHp5x7rLjfTgmmvWJZku/mlw1cbPKAonpa3Su4s2ZaCIjfyUZ9vXK9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5ryY5ha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5ryY5ha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790864378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPDKQxhaYs+MGyaL+m/0pG8oFSok/Izd/LnwXW+Oasw=;
	b=G5ryY5hahqWOLRu5rQqygDg3Sw5HFUv/kRoduCbt+04CY24aDR8lPRR+dvZ+OmnWCFbbXA
	PbyO5H/SQp1Vb6cWJR049Qc9OjsAyCyqBMzZaEAU9Iudnjet4VMnRbk1ORY5VMw4Nn/9qx
	9SdGU0B8Rz8aC0zgpACkLETZVbmqrjQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-2Mc2AdYsMsuIHzKzC_cHrA-1; Thu,
 01 Oct 2026 10:19:34 -0400
X-MC-Unique: 2Mc2AdYsMsuIHzKzC_cHrA-1
X-Mimecast-MFC-AGG-ID: 2Mc2AdYsMsuIHzKzC_cHrA_1790864373
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 144471955F28;
	Thu,  1 Oct 2026 14:19:33 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A60830000E4;
	Thu,  1 Oct 2026 14:19:30 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Jason Zaman <jason@perfinion.com>, Russell
 Coker <russell@coker.com.au>, Cathy Hu <cahu@suse.de>, Johannes Segitz
 <jsegitz@suse.de>, =?utf-8?Q?Thi=C3=A9baud?= Weksteen <tweek@google.com>
Subject: Re: [PATCH] Replace SHA-1 with SHA-256
In-Reply-To: <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>
References: <20260930111444.192037-2-lautrbach@redhat.com>
 <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
 <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>
Date: Thu, 01 Oct 2026 16:19:27 +0200
Message-ID: <pjda4ox8pw0.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Wed, Sep 30, 2026 at 9:44=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Wed, Sep 30, 2026 at 7:18=E2=80=AFAM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
>> >
>> > From: Petr Lautrbach <plautrba@redhat.com>
>> >
>> > SHA-1 is considered obsolete so move to SHA-256 as the default digest =
algorithm.
>> >
>> > Import the public-domain SHA-256 implementation from WjCryptLib and us=
e it for
>> > label digest handling.
>> >
>> > The original source of sha256.c is
>> > https://github.com/WaterJuice/WjCryptLib/releases/tag/Version_3.0.0
>> >
>> > Ignore sha256.{c,h} in make-format and check-format targets in order t=
o adopt
>> > possible future changes in WaterJuice/WjCryptLib simpler.
>> >
>> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>> > ---
>>
>> A few comments below regarding compatibility / versioning and code
>> formatting inconsistency, but otherwise
>> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>
>> 1. selabel_hash_all_partial_matches() output size grows from 20 to 32
>> bytes. selabel_hash_all_partial_matches() is a public exported symbol
>> (libselinux.map, LIBSELINUX_2.9) whose prototype is uint8_t *digest
>> with no length parameter and no man page. Any external caller sized
>> for the old SHA-1 output gets a 12-byte OOB write from
>> hash_all_partial_matches(). This interface/functionality was based on
>> Android-specific functionality and I don't see any distro users, so
>> this is probably fine to break, but it should be a stated decision and
>> called out in the commit message and the 3.12 release notes. I will
>> defer to the distros on whether it requires a libselinux.so version
>> bump; I am fine either way.
>
> Actually, if someone cares, we could just use symbol versioning for
> this and fallback on the old symbol to only write the first 20-bytes
> of the SHA256 hash to the output buffer to avoid a compatibility
> break. That said, the only user of this function that I see is in
> Android's libselinux and that wouldn't be helped by that.
>

I guess it's related to
https://android.googlesource.com/platform/external/selinux/+/refs/heads/mai=
n/libselinux/src/android/android_device.c#394

It seems to me that symbol versioning would not help if android just
pulled new libselinux and left other code intact.

What if we drop selabel_hash_all_partial_matches(), add new
selabel_hash_all_partial_matches_with_len(struct selabel_handle *handle,
					     const char *key, uint8_t *digest, size_t
                         digest_len)   or ..._sha256,
bump libselinux.so version and also document the change.

This way 3rd party projects using selabel_hash_all_partial_matches()
would not even build and it would highlight the change.




>>
>> 2. restorecon_xattr no longer surfaces legacy 20-byte digests.
>> get_digests_all_partial_matches() only returns xattr_digest when
>> read_size =3D=3D SHA256_HASH_SIZE, so an existing 20-byte security.sehash
>> is treated as "no xattr". add_xattr_entry() then returns 1 without
>> adding a list entry, so restorecon_xattr on an unconverted tree shows
>> nothing where it used to show "No Match", and restorecon_xattr -d
>> removes the legacy value silently instead of listing it as
>> DELETED_NOMATCH. The removexattr() in the new legacy branch also fires
>> (harmlessly, ENODATA) on every directory that never had a sehash. Not
>> blocking but worth a follow-up so the transition is visible.
>>
>> 3. Two differently formatted copies of the same sha256.[ch] files.
>> libsemanage/src/shas256.[ch] is the same source but already
>> reformatted by the mass reformatting. We likely ought to be consistent
>> for both either way.
>>
>> 4. The commit message could note that every existing security.sehash
>> is a miss on the first restorecon -D after upgrade one-time full check
>> + rewrite to 32 bytes; fsetxattr(...,0) at walk_next() overwrites in
>> place.
>>
>> 5. There is a lingering comment in label_support.c "Process in blocks
>> of chunkSize bytes" that references a no-longer-existing variable
>> after this change; you could drop that comment in a v2 or follow-up
>> patch.

