Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4B30BF6A
	for <selinux@vger.kernel.org>; Wed,  7 Jan 2026 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787712; cv=none; b=WW37Dkllu8obf9VNo0GX4M4uP3TVGvTjtbqGSfxhvxtuZjp1fmya31ZkifRF7qlgnZv1xPthY6ohEAzgDfpJ/zsxcsD03pgrWYXM7iyRHp44pkC9Yel9rRTEARRlOTkAtIH29nYJwjUnksMnPn2wSWVGnjQ7PpIdd0cj59Mzl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787712; c=relaxed/simple;
	bh=zyP7AlzG0V1Wad3NFXjpBoVTp+mDNsYhgdrJmY1KzMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5ezEW10K/eKv622g4yZL6CPkB8hqEqBMztFAqkSbjky1yIE3nLvUY0acLAkj7e8oT3fy9lAKwIeMHlbg5TVg4BL5wCnPjW33cl0GqPoI1TE6chIQg2ohe7pZ9dS4VkLTxB6o9B237b6AyGv1v5g5+h/K1E8scD4BxyKuqnbZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9UazdhT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9UazdhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767787709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCHYrfRsxnr4Gw7y+zLfYaQmRfhq5Qw1zQmB6odduyg=;
	b=D9UazdhTUmc6drSDUhqKBfyVkvX8lnICvVA9c/RCST34aHvegyp5DbCboTvN6D9WEAatlj
	KTw8wK80sUA9WL8u8k2ZBTXHnwKplx68YBxUtzV5Enr26fyowSiaDAs93s4Vhg9Rc/1snH
	QeJCSdi0b30pMBK59F5UAKxiZpYDkD0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-8iWM-lZGP_KU23pNrsAF9A-1; Wed,
 07 Jan 2026 07:08:28 -0500
X-MC-Unique: 8iWM-lZGP_KU23pNrsAF9A-1
X-Mimecast-MFC-AGG-ID: 8iWM-lZGP_KU23pNrsAF9A_1767787707
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67FAE18005B3;
	Wed,  7 Jan 2026 12:08:27 +0000 (UTC)
Received: from localhost (unknown [10.44.33.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAE1119560A2;
	Wed,  7 Jan 2026 12:08:26 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Paul Moore <paul@paul-moore.com>,  selinux@vger.kernel.org
Cc:
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
In-Reply-To: <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
References: <20260105174020.887724-1-lautrbach@redhat.com>
 <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
Date: Wed, 07 Jan 2026 13:08:25 +0100
Message-ID: <87h5sxvd52.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Paul Moore <paul@paul-moore.com> writes:

> On Mon, Jan 5, 2026 at 12:46=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> The key is available at:
>> https://github.com/bachradsusi.gpg
>> https://plautrba.fedorapeople.org/lautrbach@redhat.com.gpg
>>
>> Also update the email address
>>
>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>> ---
>>  SECURITY.md | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/SECURITY.md b/SECURITY.md
>> index 2a7ce5b317a7..faa060ccff03 100644
>> --- a/SECURITY.md
>> +++ b/SECURITY.md
>> @@ -24,7 +24,8 @@ list is below. We typically request at most a 90 day t=
ime period to address
>>  the issue before it is made public, but we will make every effort to ad=
dress
>>  the issue as quickly as possible and shorten the disclosure window.
>>
>> -* Petr Lautrbach, plautrba@redhat.com
>> +* Petr Lautrbach, lautrbach@redhat.com
>> +  *  (GPG fingerprint) 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C1=
3E
>
> I think you may want to list the fingerprint of your primary key and
> not a subkey, as the primary key is what carries the signatures and
> helps verify trust.
>

I guess I need help then:

$ gpg --show-keys --fingerprint lautrbach@redhat.com.gpg
pub   rsa4096/63A8AD4B982C4373 2012-04-03 [SC]
      Key fingerprint =3D E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B 982C 4373
      Keygrip =3D 6BC6915CA93F20709BC8B5020B8E22D7E6ED2F94
uid                            Petr Lautrbach <plautrba@redhat.com>
sub   rsa4096/06C3AB0B84CA81FE 2017-12-05 [A]
      Keygrip =3D 04808A09AA88E1CB0055033ACBC0A27D4ED46237
sub   rsa4096/BE22091E3EF62275 2017-12-05 [S]
      Keygrip =3D 56BA5B9D06707CA797DD4380A7ED91A95ED233CE
sub   rsa4096/7C4D5CA6A1BC4B25 2012-04-03 [E]
      Keygrip =3D B0FED3D171572C546D4601AB94C1852E46A02FE6

pub   rsa4096/BC3905F235179CF1 2022-10-26 [SC] [expired: 2024-10-25]
      Key fingerprint =3D B868 2847 764D F60D F52D  992C BC39 05F2 3517 9CF1
      Keygrip =3D FA0CE92171EEBAC2DD084E6399F18709A2F7353B
uid                            Petr Lautrbach <lautrbach@redhat.com>
sub   rsa4096/F1B73DE3D81A529B 2022-10-26 [E] [expired: 2024-10-25]
      Keygrip =3D 3A28778B1F09A154888A372BE543AB2CA12BB4F1
sub   rsa4096/2F2D5A2B6D4CC2C5 2022-10-26 [A] [expired: 2024-10-25]
      Keygrip =3D E5B12C87E5760AC68443C63D620AD3E407A67FA7
sub   rsa4096/4695881C254508D1 2022-10-26 [S] [expired: 2024-10-25]
      Keygrip =3D 55F576834D965A315EC66BF1327BAA810A5A2587

gpg: WARNING: No valid encryption subkey left over.
pub   rsa4096/FB4C685B5DC1C13E 2024-11-04 [SC] [expires: 2026-11-04]
      Key fingerprint =3D 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E
      Keygrip =3D 834230A0854D7A8698B5432C007560FE7AECC504
uid                            Petr Lautrbach <lautrbach@redhat.com>
sub   rsa4096/C500C028A770AB66 2024-11-04 [E] [expires: 2026-11-04]
      Keygrip =3D 2EF1D48B43E234CAAE155A0AD032C00063FCB102
sub   rsa4096/CDCAE8C927C6BE31 2024-11-04 [S] [expires: 2026-11-04]
      Keygrip =3D CAE3E6B80FFD15958C813CC635CFFDF9F86D9C17
sub   rsa4096/37BCD711A64B2890 2024-11-04 [AR] [expires: 2026-11-04]
      Keygrip =3D 850707DAF56607DEABD28933FD0A77D382923F1C



I'm looking at the last one Petr Lautrbach <lautrbach@redhat.com>
[expires: 2026-11-04]=20



>>  * Nicolas Iooss, nicolas.iooss@m4x.org
>>    *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5=
EB
>>  * Jeffrey Vander Stoep, jeffv@google.com
>> --
>> 2.52.0
>
> --=20
> paul-moore.com

