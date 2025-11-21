Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39073254AFF
	for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720753; cv=none; b=JirW846mwOZj4f1jWH2JHmtSQkFnRY4cEdQS6JNQuzx1Nztr/9KvBCN18Vdf/IPIgt0XdoYh6YtgCF+t2V5MmlUxiBU+2S3/UYDOii6y/+RUFOwFiTYCE4YcSJd8M154sjf2DWrrIcgydTxzaLC81rkizAT8vZPFM/W/kJ4+RGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720753; c=relaxed/simple;
	bh=lK9l/XzGJXOSDpgVJsXd8VkeUiUlljQ65KwIEcAcP5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSXA5UAHkM2MWNMz30hxRVMpugiPjydKkVe2x9RNhAxadcvmg9tDq9IjM3qT4wvl+J1v4VTWWNoZoy0WGULnnZ+s2itJk9XdIeqYOJwC7ZmPTGiJ/qnnf5RyBpw3x5fJb8yk5iZKOV2zM+aljkSnxePS9SqSPqlYeaOtXI+lRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fp7/D8RH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fp7/D8RH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763720751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZTmNHrmdbaHJH5Wm0sJwoeRR5YlNXyihAOp0rs4w7c=;
	b=fp7/D8RHUGtVgRNjHTzojNOTuyyEepxNBKlprNmTpuLDAhoMrgoZ9wUdGxggYbjrIvdSDY
	4XGAkya5YaWPNf1BZ7RC1grwnk7CSf5GlC41ATpDPF/8cP/SwP/GrwRcA+h2I8DoHZ/dGP
	RsP+5pD68GqwTtwRVvhTjGv4dW3GuEE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-B0XhXOIPNyOusUNrJx9Pzg-1; Fri,
 21 Nov 2025 05:25:46 -0500
X-MC-Unique: B0XhXOIPNyOusUNrJx9Pzg-1
X-Mimecast-MFC-AGG-ID: B0XhXOIPNyOusUNrJx9Pzg_1763720746
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8D361800650;
	Fri, 21 Nov 2025 10:25:45 +0000 (UTC)
Received: from localhost (unknown [10.45.225.228])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 700BD1800947;
	Fri, 21 Nov 2025 10:25:45 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: Adding SElinux support for a service
In-Reply-To: <60A8D560-3A88-48B7-88AE-1D7023AF2B44@redfish-solutions.com>
References: <D6E78BE1-7054-46F2-AA10-1BC2E0D4A82B@redfish-solutions.com>
 <CAEjxPJ7umghjAo3Yg25QsYL+pfQ27bxOvS8J2S5-MSKtKZBXww@mail.gmail.com>
 <60A8D560-3A88-48B7-88AE-1D7023AF2B44@redfish-solutions.com>
Date: Fri, 21 Nov 2025 11:25:44 +0100
Message-ID: <87ecprfzrr.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Philip Prindeville <philipp_subx@redfish-solutions.com> writes:

>> On Nov 20, 2025, at 2:15=E2=80=AFPM, Stephen Smalley <stephen.smalley.wo=
rk@gmail.com> wrote:
>>=20
>> On Thu, Nov 20, 2025 at 3:14=E2=80=AFPM Philip Prindeville
>> <philipp_subx@redfish-solutions.com> wrote:
>>>=20
>>> Hi,
>>>=20
>>> I'm working on SElinux support for a server that talks to a PCIe GPS ca=
rd.
>>>=20
>>> Is there a guide to how to port a new service to SElinux, for instance =
how to give it its own context?  Or, in the absence of a guide, what GitHub=
 project can I look at for the supporting commits that were done to achieve=
 the same?
>>=20
>> Can you elaborate a little on what it is you want to do? Do you have
>> SELinux enabled and enforcing already on the base system and just want
>> to add policy for a new service to confine it and/or control what
>> other processes can talk to it?
>> Or do you also want the service to be SELinux-aware, aka a userspace
>> object manager, where it enforces its own security policy over its own
>> objects and operations?
>> What's your starting point?
>
>
> Yes, I have an SElinux system (RHEL 10.0) and I=E2=80=99m running the dae=
mon on it.  I want to package policy rules with the daemon, but yes, I also=
 want to confine the daemon to its own context.
>
> Currently only chronyd or ntpd would talk to it, either by the char devic=
e it creates, or else the shared memory segment it creates.

Take a look at https://fedoraproject.org/wiki/SELinux/IndependentPolicy

Also given that this is for rpm based distro using fedora-selinux
policy, selinux@lists.fedoraproject.org might the better place to get a
help.

Petr

