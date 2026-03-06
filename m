Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A623D7FF
	for <selinux@vger.kernel.org>; Fri,  6 Mar 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786892; cv=none; b=AzEd6Oie0EdEkGCZcpzv+ba7r2baUQ/dRFaTwKyD/OepsGqixlplJ3kyCzLuH05W5hhM55hg5EiMVVkBeMhW6mDQ+T+9PDiUupg9igAYY2pMrnN0Lf1zGDVTwBC95JBC6hH8qHJmM9DaaT22eaYd3JLHGaYbJhRNGJC9VY9AWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786892; c=relaxed/simple;
	bh=ndM8sutGqTKrOBGn36u60r/diR7xe7IIyvjwQ/EM2SI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s4D4KKEwemRovtJXB/PUEgb1Kw1mm6AaLHO/SmeDeyH2p+EpAp6AWdVhdDf7K+p3LchkGSs99EvJXgnmdh4SzPY0yj4AMrxEZH+/fsVcF1mt6Paoi481yGY5EBU3EgUGIAah/Z0l9X96KOpyPFHPYX81TfwxR4MOcxHMPLI39eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8qvC2cC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8qvC2cC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772786889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBZE+7gVemz8ahnKJUUuozA0Qpll9elAYfX70rtnAnQ=;
	b=V8qvC2cCbHjikuWkLCBiqWYSe6qdGIO922T/MJTUYVxvZoEmI8mxvhiK0xLfcjWUdd4/rZ
	dI41IRO/AkR76DpFcQLkGtasvWAtXLGrE0+KsLjW7norXV+0/leEa6rx+kDxcFEtRSj0cb
	kBoCkQwtJeiID8PxliYsJ3TDqeHnHJo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213--Uucf-_nNRywUhi3c81Z-w-1; Fri,
 06 Mar 2026 03:48:07 -0500
X-MC-Unique: -Uucf-_nNRywUhi3c81Z-w-1
X-Mimecast-MFC-AGG-ID: -Uucf-_nNRywUhi3c81Z-w_1772786887
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E760A18005B3;
	Fri,  6 Mar 2026 08:48:06 +0000 (UTC)
Received: from localhost (unknown [10.44.32.213])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D6381956095;
	Fri,  6 Mar 2026 08:48:06 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: =?utf-8?Q?Thi=C3=A9baud?= Weksteen <tweek@google.com>
Subject: Re: [PATCH] Add support for UTF-8 in file context labels
In-Reply-To: <CA+zpnLcC6e74amyz+6pqau+zUBYLhYGSP4zRy133XUfC75Qbvw@mail.gmail.com>
References: <20260303122412.1596047-2-lautrbach@redhat.com>
 <CA+zpnLcC6e74amyz+6pqau+zUBYLhYGSP4zRy133XUfC75Qbvw@mail.gmail.com>
Date: Fri, 06 Mar 2026 09:48:05 +0100
Message-ID: <87jyvps5ru.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Thi=C3=A9baud Weksteen <tweek@google.com> writes:

> On Tue, Mar 3, 2026 at 11:39=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> - libselinux to be able to read UTF-8 spec entries
>> - libselinux to compile regexes with UTF strings and unicode properties
>
> Thanks Petr. I'm a bit worried about the performance impact here of
> always enabling UTF support. Were you able to run benchmarks on this
> change? Android's file_contexts [1] could be useful data here. If the
> impact is non-negligible, could this feature be behind an option for
> selabel_file, something like SELABEL_OPT_UTF?
>
> [1] https://cs.android.com/android/platform/superproject/+/android-latest=
-release:system/sepolicy/private/file_contexts

I've run perf on
`setfiles /etc/selinux/targeted/contexts/files/file_contexts /` and if I
get it right there's about 5% overhead in libpcre2 when it's used with
PCRE2_UTF.

I'll prepare another patch where support for UTF8 could be disabled
during build time, e.g.

    make LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 DISABLE_UTF=3Dy install


Petr

