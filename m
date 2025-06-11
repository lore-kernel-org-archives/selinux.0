Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE42BD5AE
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669478; cv=none; b=HfJHWidQRVnrOCk4ARa70YbGga650cV315HLDtPLhOA0xf9LGpY8gF/Iv9JKP/W3bcGoxSFmWlH1f1AaMvITnIeCWUMg6v6hQZEZL8jADae9OMr3x2VVLC6t+adn0qurCBi4vSpROg+cZDfPcDYp50m93jbx0tytmgJPcfWNF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669478; c=relaxed/simple;
	bh=/rFQfL4cB2rtrb6KgZ/2uQv4OkqdxH0RvlxrzOEEaUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ALKyw2TUxeUSu8Pn4AkqbzjTsHUo+vOH+X6pAIBWNoaWFuu3gdd0OYUM64JxDGtI6F96pM5Z5kxLfr8/of/QInG+GqKDE5snrMob2oRzkENGwyEVr5k/EkvHzEWMwXlr4ILzmDxoFpYV8Qm98SoG9v0SasD4RUr6f4w0lApVmlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9pAcaNU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9pAcaNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rFQfL4cB2rtrb6KgZ/2uQv4OkqdxH0RvlxrzOEEaUQ=;
	b=V9pAcaNUhbkhLDh+xeCz7r9r1l3PMydeQb6HIONaGvI6aJ5YnGhho1C1BWFbXxztNN1pJJ
	jee6Ww70InzxojTIVwIhaBxKfGZg5innPnSJ36r5k2czS6s49Dnr0Tlt77HhBSoaeuP0A/
	WPkRhJcyDpw35zpz/DR/LkYeZWd1xMA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-ryARQItvNx64AXptXsa8Lg-1; Wed,
 11 Jun 2025 15:17:50 -0400
X-MC-Unique: ryARQItvNx64AXptXsa8Lg-1
X-Mimecast-MFC-AGG-ID: ryARQItvNx64AXptXsa8Lg_1749669469
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B55D91800291;
	Wed, 11 Jun 2025 19:17:49 +0000 (UTC)
Received: from localhost (unknown [10.44.32.71])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35A8F30002C3;
	Wed, 11 Jun 2025 19:17:48 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: Do not inline compile_regex()
In-Reply-To: <CAEjxPJ54dhnb40R0Zk9SDuwqXWvv2aMtD6a7MUJQzdKy1NY+sQ@mail.gmail.com>
References: <20250611182846.236298-1-jwcart2@gmail.com>
 <CAEjxPJ6g+=N3p83hUXRndvET+4T-+OShvMHipLg0h7fo89iPfw@mail.gmail.com>
 <87ldpydrhx.fsf@redhat.com>
 <CAEjxPJ54dhnb40R0Zk9SDuwqXWvv2aMtD6a7MUJQzdKy1NY+sQ@mail.gmail.com>
Date: Wed, 11 Jun 2025 21:17:47 +0200
Message-ID: <87ikl2dr50.fsf@redhat.com>
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

> On Wed, Jun 11, 2025 at 3:10=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>> > On Wed, Jun 11, 2025 at 2:29=E2=80=AFPM James Carter <jwcart2@gmail.co=
m> wrote:
>> >>
>> >> Since commit bdcbbf89b9548afd452449835e58e84105a71a9a (libselinux:
>> >> limit fcontext regex path length), an error would be given if
>> >> libselinux was compiled directly. (Though, building the whole SELinux
>> >> userspace still worked.) This is because the flag "-Winline" is used
>> >> when building libselinux directly, but not when building the whole
>> >> userspace.
>> >>
>> >> Remove "inline" from the function compile_regex() in label_file.h
>> >> to allow libselinux to be built directly.
>> >>
>> >> There are four functions defined in label_file.h that are not inlined:
>> >> regex_has_meta_chars(), regex_simplify(), compile_regex(), and
>> >> insert_spec(). The first three functions are called by insert_spec()
>> >> which is called by the inlined function process_line(). This last
>> >> function is called by utils/sefcontext_compile.c which prevents
>> >> relocating the non-inlined functions to label_file.c.
>> >>
>> >> Signed-off-by: James Carter <jwcart2@gmail.com>
>> >
>> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> >
>>
>> I'm going to postpone 3.9-rc1 to tomorrow so this change can land there.
>>
>> Ok?
>
> Or feel free to merge it now (or I can) and you can do it today,
> whichever is easiest.

I've merged it just now.

expect 3.9-rc1 in next 30 minutes

