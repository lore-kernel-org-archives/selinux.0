Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49941C6880;
	Wed,  7 Aug 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033214; cv=none; b=sczZRlDYMY4/01n9iu8J6k0Rrads6gY1+hG4oZCwV5ZDQZhzA7O6ljEfZqlMAkZ+6vnTY0QX7dUD2Yxo5P6k/NXEX7Fcgx7OpJ7Du1Bf//ceG40mwshbhaZmny1QV0WteI6f3+ia6TfjOfwTlf9Vxn703XID5kOh5iScVm3Il54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033214; c=relaxed/simple;
	bh=vX0uCyyadAH/BLtjmxNtpG1In3Eo/drET2siUnj+cKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNmWhTcq1BkkVLAR1YNEJRw1nxJVwWBTVpgM4ebLeEad4zP1J/XKSys+hDsxnXJQzo6gGzV4UnzGOLE8GKCDD9IOA7DEP3mjqeKTRDpwbnStQLmDAl+/YecyfCX4JgJpwiplFolKKSy/iIf56eHbiX5b2lGSeNmAlMTntD5tKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iNPywI/o; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iNPywI/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723033204; x=1723638004; i=markus.elfring@web.de;
	bh=zRBpY0dycMJAvahUfF2nU52iexROLC6eajPiL9g18KQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iNPywI/ojAJVxlalRepBVPzrkS99Q4QMtk5k0tWSF/KI7mEVmk0mnLzx36ON5DAw
	 q3EG7yMs01JmVcKpGd2O6w5sQ5k4Li8Sy/FVdDCYx524EZwxzHt+hcPf1ccdlRJuD
	 RJIHyNRf4e7peWfbWfFg+9i4a5OwjtGOuk75RtLW8qQ8abme/jGOjoyuMDEbQag1Z
	 gBAGtIA6z2LPYOwUAUIad8N9QgdIptytFKlzwTJg2PYgWYBeWh+2apD4yObBMM5Qd
	 2rHuFYs6bkPeVtiDm2IemaOktPS9POG5cvqaPmnKtQODu0zaHl+6RuceAPwsakvnm
	 5XwqfIm5Vy9vbmHsiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1spv2A34xI-00Lpy2; Wed, 07
 Aug 2024 14:06:30 +0200
Message-ID: <ed7f98e2-596b-4e4a-bc8a-d88543eeaa6d@web.de>
Date: Wed, 7 Aug 2024 14:06:29 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: Fix potential counting error in
 avc_add_xperms_decision()
To: Zhen Lei <thunder.leizhen@huawei.com>, selinux@vger.kernel.org,
 Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Vander Stoep
 <jeffv@google.com>, Nick Kralevich <nnk@google.com>
References: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com>
 <600318b9-928c-4466-a8d1-334fab8c512f@web.de>
 <8e9f8931-0fd8-5808-8898-761e31e55208@huaweicloud.com>
 <d3f95ed9-a8f2-aedb-9097-0ac420d5bfa1@huaweicloud.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d3f95ed9-a8f2-aedb-9097-0ac420d5bfa1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W3wUKOCY/k/qhfAOrjV6cLkQQoCo7hxgzVSfumipBVd0WxaGT8h
 sZ+QZcx+wOaR0a3LUIi9xEZw6ASKjO8QUrTCTWKnkG7LUMYZEMxvGIzZUSpgH8oSnm9S8x8
 CgysqDWTZF9YVsogcJK1jbrhSBx+3gc23G2DqCJ6c7aDhpm8jDaUgBohrKfR9PZ281mJOeH
 vt1xR6IHDXx9IxFOogDbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8j+xC7+59zA=;sW26kC6373DcQmXXE9I9WNWXCYn
 SVL9kxTD0wm4tOgWUR9cIcqZC6BiVXv8+uZuxOdrBAitw8PYn4Tdy7HE/tM5pEzQFd8bu4nsc
 oVmCtTlmrP4YuFNr0YImC1aocae0ZCruaHhNFoXhHyZw0+kAgp9Vt32BJ53txTl/hzbP9OVMF
 6wMwEt9l6Mv7lVUcrhr0seqvo2sClfkPiCTCY34ugmL+cYdiqBtUJ7IqYPv3SdnqyjVRMMoG2
 76wP7C8/AME4AU57jCYuFvLKUYEIIT1uRMU3EipjF3UPU8JjS9a0s02gWi+rNHnl++XMhmD66
 p022w8EMLqNhwuOv//JnJxLhFKm9Xv12/aH4+NkVdeKWDVSFp51/Mx4cH0qMC+mNRIIBnbv/J
 K/i96IMBLB0xSsrDUcWMs8/nV9h0Uvbnu68uJBPKgael/fMOzeYkIvG9wM3OKAIQS7NKhTeOL
 Tp6W//N++cOTReZ8/welAeQW1fNFgC0slmO1PJuo2j3HJnnMXuizi68W7I65xJQiXzvaBXsbE
 Ybgk8xqOU1yuOvrzUccJMlXuhBKHYrhxcN4djiWRqTuuM5nA/7QWq18NfNn3OhpnZDqPxuzZh
 2j8y+dvIW3gBH1ngw7x7H6qNFFoVfeb7SPQ8kCWSvcxKO5VkIKCzlzY8hM/ALmHuwKRyCBMAO
 nDecf+YtiK1Ezbds2tnmOW7a5fOdIxeq4ICC6JHmvyQXr9MAAtFZiFIw6jJBKulFLRJ8FbKUn
 9spvl4ClTFoBMqN1d7rncKPkAHyKnXafRjuo9bjxs8qKB1TcwDoALDYdCExmPO4RVW63UJdBD
 veGFfTpvbo2TgKxRcFoT/raA==

>>>> The count increases only when a node is successfully added to
>>>> the linked list.
>>>
>>> 1. Please improve such a change description with an imperative wording=
.
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/process/submitting-patches.rst?h=3Dv6.11-rc2#n94
>> Ok, I'll try to improve it.
> I see this patch has been merged into selinux/stable-6.11.

Interesting =E2=80=A6


> So I decided not to change it, and I re-examined it,

Further collateral evolution can become more helpful,
can't it?


> and it seems that there is no problem you mentioned.

There are obviously different preferences involved for patch review proces=
ses.

Regards,
Markus
