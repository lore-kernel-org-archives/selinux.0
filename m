Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14E189F26
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626112; cv=none; b=uupAz7lNognmQWm47w647cgKk9NFmllVhoqcZDlyTAVkqmjATb2KxepBraCzEhm6HtTFi5y9PpcJ6ZS0vnfOQcKSD2J45wa4piDrE+nsqIVvICb0UVALbbSwxT5cUlJkHx5dTuCjSA4BqXWLTTQriWXLjgaifqrUddcDi0NwJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626112; c=relaxed/simple;
	bh=gCxBtBhWSR8lEj3l6YlrVgQ1ipGksk4eYhCuUwm2pHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQt1O9xLI0Q/olQxKQDxl2a3mEcGzOtqqup/nb2selyl/nSVzo0G5jysqHaulItik9IKI74KT3WExs91GHQSlTGIWmgFNn9i+I4fDr+A0llmChZAo//gExHHUxwkoMyM2AdrZPzT/jQZFxSU6J4ZWo5gbYjwXXpPh7ZAVdEsMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOBJZ64c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOBJZ64c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720626109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Vbe5/9MQ0WqCADuORATBYvc+vFICNheFLICoWgYEBY=;
	b=GOBJZ64cu1pO0GqkHuv3X8s0whP93R73S1tKOT8IDo3WadPYhMlS6VOdGMrxy+QNbjTp+X
	K8WMEez3XFoqVACYUMB0x7/BGplNqTXoXJJoxbQ3LOFRMoIh2lLDZgwC4cbkhSEk2giyCA
	K8G1VvZ209Fw2lTM44Tv4hfZae5g4+M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-shX1rw_iNw-RaRWltFnAnQ-1; Wed,
 10 Jul 2024 11:41:46 -0400
X-MC-Unique: shX1rw_iNw-RaRWltFnAnQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0BBB19560AA;
	Wed, 10 Jul 2024 15:41:45 +0000 (UTC)
Received: from localhost (unknown [10.45.225.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9D901955F40;
	Wed, 10 Jul 2024 15:41:44 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
 daan.j.demeyer@gmail.com
Subject: Re: In permissive setting labels that are not in host policy when
 running unprivileged fails with EINVAL
In-Reply-To: <CAHC9VhRJ8CLD7ifENG2dC6wYtXBujc9UY=WKmXx3u0-HyTx-mg@mail.gmail.com>
References: <87v81d74pj.fsf@redhat.com>
 <CAEjxPJ45g8jh=0LtjWE14+ANXjOknnmyZUChu_D==z3M_5wZdQ@mail.gmail.com>
 <CAHC9VhRJ8CLD7ifENG2dC6wYtXBujc9UY=WKmXx3u0-HyTx-mg@mail.gmail.com>
Date: Wed, 10 Jul 2024 17:41:37 +0200
Message-ID: <87r0c16yq6.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Paul Moore <paul@paul-moore.com> writes:

> On Wed, Jul 10, 2024 at 9:50=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Wed, Jul 10, 2024 at 9:32=E2=80=AFAM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
>> >
>> > Hello,
>> >
>> > this is originally reported at
>> > https://github.com/SELinuxProject/selinux/issues/437
>> >
>> > There a question why kernel blocks changing SELinux label to some
>> > unknown label and requires CAP_MAC_ADMIN even in permissive mode?
>> >
>> > Reproducer:
>> >
>> > $ id -u
>> > 1000
>> >
>> > $ getenforce
>> > Permissive
>> >
>> > $ chcon -t bin_t /var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/syst=
emd/system-generators/systemd-ssh-generator
>> >
>> > $ chcon -t selinux_unknown_type_t /var/lib/mock/fedora-rawhide-x86_64/=
root/usr/lib/systemd/system-generators/systemd-ssh-generator
>> > chcon: failed to change context of '/var/lib/mock/fedora-rawhide-x86_6=
4/root/usr/lib/systemd/system-generators/systemd-ssh-generator' to =E2=80=
=98system_u:object_r:selinux_unknown_type_t:s0=E2=80=99: Invalid argument
>> >
>> >
>> > Quotes from the issue:
>> >
>> > This is happening on a system with SELinux in permissive mode. Applying
>> > your suggestion does not change the result. I assume this is gated
>> > behind CAP_MAC_ADMIN for unprivileged users. Is there any way to make
>> > this work without needing root privileges?
>> >
>> > Hmm so the kernel blocks unknown labels unless the user has
>> > CAP_MAC_ADMIN in the initial user namespace. I'm assuming this is for a
>> > good reason and it would be unsafe to allow any user to do this so I
>> > don't think there's anything that can be done here
>> >
>> > One thing that's not clear to me, why is an unprivileged user allowed =
to
>> > write labels known by the host but not labels that are not known to the
>> > host? What specifically is unsafe about unknown labels that's not an
>> > issue with known labels?
>>
>> With SELinux disabled, setting of security.* xattrs at all is gated by
>> CAP_SYS_ADMIN.
>> With SELinux enabled, the security.selinux xattrs can be set to valid
>> security contexts without any capability if allowed by policy.
>> Support for setting unknown security contexts was a later addition to
>> SELinux for a specific use case (original motivation provided by Red
>> Hat was to permit rpm to set contexts on files unpacked from a package
>> before it inserted the corresponding policy module from %post), and
>> was not expected to be used by unprivileged users.
>> Smack had already introduced CAP_MAC_ADMIN at that point, and it
>> seemed reasonable to use it for this purpose, since setting labels
>> unknown to the policy is effectively like being the admin of the MAC
>> policy.
>> The policy can't make useful determinations about what to do with
>> unknown labels so it can't provide any information flow guarantees.
>> There may also have been a concern about the facility being abused to
>> push arbitrary data into a security.selinux xattr to be fetched by
>> some other privileged process later in a manner that would ultimately
>> lead to a vulnerability.
>> Not saying that we can't change things here, but would require a
>> graceful and compatible transition path.
>
> FWIW, we would also need to see a very compelling reason with broad
> reach that doesn't have a good workaround before we consider changing
> the current behavior.  The scenario described in the original GH issue
> is interesting, but my suspicion is that it is fairly limited.
>

thanks!

