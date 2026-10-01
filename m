Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA20398902
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840297; cv=none; b=TUL3mv0CDhDINBz1cOGJvCSyhSS3RR2jxZ08Nlst03qPITeo8H9DxRqBQeaEquILaIr834bH/G4lEpY72tKaHKjLXGyN39U0gIRqtk+aZI949meuLcnxsVjBonuTfNwDahJ2AIWA9sZdIOpEkuGXSIhqcoN3gZQ6CjhG/K9tgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840297; c=relaxed/simple;
	bh=25IfX7czFWsKUpfe8XxUP3Is2QFvpCbTnvUBZuRktbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ley57nI9JBYJdZRONnqsoNeYFW0wpa0Qt6jmoSLUACvX1C8WbESR4QHXrTCNLNrvHxaiE/JnsckOI/16daaJNkx1gRdoT8L9msAbDiTTJ9mPV9AXbsKX+pF1mp/no5U6wpUtab1O558bzuQuYJPML3ux9ej9Zkqra4SYeIK06lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFVU7C5N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFVU7C5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790840294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25IfX7czFWsKUpfe8XxUP3Is2QFvpCbTnvUBZuRktbk=;
	b=QFVU7C5N/cOAUTqbld2hrg/3s2Y8Sdcqi/BKJ8YhEIqRBaIqk1zi3pfrm+7EMOz5bUcv0H
	zoIgOVqSCDRvaqKKjUARJJaJGyYSsmfKqeJjCut4W/uVMWSWLqYLr/ttpwD2ApzirbRbrI
	nzOoNI7MibqBaoyffRohxGEzWfi6ITw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-qfpJWie3MEKNdZsUUU37NQ-1; Thu,
 01 Oct 2026 03:38:10 -0400
X-MC-Unique: qfpJWie3MEKNdZsUUU37NQ-1
X-Mimecast-MFC-AGG-ID: qfpJWie3MEKNdZsUUU37NQ_1790840289
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A56051800675;
	Thu,  1 Oct 2026 07:38:08 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3910180035F;
	Thu,  1 Oct 2026 07:38:05 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jason Zaman <jason@perfinion.com>, Russell Coker <russell@coker.com.au>,
 Cathy Hu <cahu@suse.de>, Johannes Segitz <jsegitz@suse.de>, =?utf-8?Q?Thi?=
 =?utf-8?Q?=C3=A9baud?=
 Weksteen <tweek@google.com>
Subject: Re: [PATCH] Replace SHA-1 with SHA-256
In-Reply-To: <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>
References: <20260930111444.192037-2-lautrbach@redhat.com>
 <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
 <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>
Date: Thu, 01 Oct 2026 09:38:03 +0200
Message-ID: <pjdjyo198h0.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Thanks. I'll try to address all your comments. I have no answers for 1.
and 2. at this moment, but 3., 4., 5. is clear

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

Given that this project has already changes in libsemanage/src/sha256.*=20
I'm going to backport changes from
https://github.com/WaterJuice/WjCryptLib/commit/e1a5f7866e74c9b608afc79d4e8=
c8000af2879a3
to libsemanage/src/sha256.* and then use the same code in libselinux/src/sh=
a256*


>> 4. The commit message could note that every existing security.sehash
>> is a miss on the first restorecon -D after upgrade one-time full check
>> + rewrite to 32 bytes; fsetxattr(...,0) at walk_next() overwrites in
>> place.

I'll add this


>> 5. There is a lingering comment in label_support.c "Process in blocks
>> of chunkSize bytes" that references a no-longer-existing variable
>> after this change; you could drop that comment in a v2 or follow-up
>> patch.

I'll drop it.

