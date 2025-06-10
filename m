Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F1228CBE
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554906; cv=none; b=EEbSFC0OygG7lP48PCpAMvbIGfeJeYcHuUJkG39GYWcXi7lIsZsfoML4TkSgn2nH9mxd80vkCjkVuf2VYMFQOVAYxhpduRj8VpyknWSY8MgUBSxphMZ308fBCT5u3gaX9/l7GlAuRL3Syvf8AclDvhtVk5jTbw9/tD/b+/MR+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554906; c=relaxed/simple;
	bh=I9ub6QwH7HFnQHbacXFmIHCjT+J3rT30y+sPxvFU+YM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1jB8PeS4UAVNBvK+RxEG9CGOgWTuAWIyHqIUdvisg7eYIox2r0Ba3izmGH/QYtJbEU/F8FqDtMkpbhUIVDxtfYCmVQfIjUpYPZ6pw5I+qrx1hwdo+xhUKX9S7itJFpIFlEI3mx7ZnA0I18rDfr7ZXgwdrmajln3RGILyphfFsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=YPAjrJq3; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="YPAjrJq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1749554896;
	bh=I9ub6QwH7HFnQHbacXFmIHCjT+J3rT30y+sPxvFU+YM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YPAjrJq31YBoYk4bCoihfRhPe0bRhZ7TEXUkbBzjvp9nqrozOcB3Jg5D35qAzd1Pf
	 dFyX/oxurWOxnueBHDroQIu14jZhUhV9khZ6EXHHxhmIKOJVNheqRswGc4PuVdMqfC
	 MvC6tEjFZA1dPAgOcF96Jg8ehszqSTzgZiHvLXS0=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 526DE1A264E;
	Tue, 10 Jun 2025 13:28:16 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
  selinux@vger.kernel.org,
  Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v2 2/2] libselinux: retain LIFO order for path
 substitutions
In-Reply-To: <87plfbetzh.fsf@redhat.com> (Petr Lautrbach's message of "Tue, 10
	Jun 2025 13:06:26 +0200")
References: <20250530123048.53419-1-cgoettsche@seltendoof.de>
	<20250530123048.53419-2-cgoettsche@seltendoof.de>
	<87plfbetzh.fsf@redhat.com>
Date: Tue, 10 Jun 2025 13:28:15 +0200
Message-ID: <871prrlttc.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Petr Lautrbach <lautrbach@redhat.com> writes:

> Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:
>
>> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>> Store the path substitutions in LIFO order as in previous versions.
>>
>> Fixes: 4d436e4b ("libselinux: use vector instead of linked list for subs=
titutions")
>> Reported-by: Dominick Grift <dominick.grift@defensec.nl>
>> Link: https://lore.kernel.org/selinux/87ldqftsxd.fsf@defensec.nl/
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>> ---
>> v2: add patch
>> ---
>>  libselinux/src/label_file.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>> index 61a9ddb6..b785eab6 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -1350,6 +1350,15 @@ static int selabel_subs_init(const char *path, st=
ruct selabel_digest *digest,
>>  	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
>>  		goto err;
>>=20=20
>> +	/* LIFO order for backward compatibility */
>> +	for (uint32_t i =3D 0; i < tmp_num/2; i++) {
>> +		struct selabel_sub swap;
>> +
>> +		swap =3D tmp[i];
>> +		tmp[i] =3D tmp[tmp_num - i - 1];
>> +		tmp[tmp_num - i - 1] =3D swap;
>> +	}
>> +
>>  	*out_subs =3D tmp;
>>  	*out_num =3D tmp_num;
>>  	*out_alloc =3D tmp_alloc;
>> --=20
>> 2.49.0
>
> It fixes the original reproducer:
>
> root@fedora:/# cat /etc/selinux/fedora-selinux/contexts/files/file_contex=
ts.subs
> /new_root /
> /new_root/foo /usr/bin
> root@fedora:/# matchpathcon /new_root /new_root/foo
> /new_root       system_u:object_r:root_t:s0
> /new_root/foo   system_u:object_r:bin_t:s0
>
> but it's important to say it depends on the order of entries in .subst:
>
> root@fedora:/# cat /etc/selinux/fedora-selinux/contexts/files/file_contex=
ts.subs
> /new_root/foo /usr/bin
> /new_root /
> root@fedora:/# matchpathcon /new_root /new_root/foo
> /new_root       system_u:object_r:root_t:s0
> /new_root/foo   system_u:object_r:etc_runtime_t:s0
>
>
> it looks like it was like that even before with 3.8:
>
> [root@fedora-41 /]# cat /etc/selinux/targeted/contexts/files/file_context=
s.subs
> /new_root /
> /new_root/foo /usr/bin
> [root@fedora-41 /]# matchpathcon /new_root /new_root/foo
> /new_root       system_u:object_r:root_t:s0
> /new_root/foo   system_u:object_r:bin_t:s0
>
> [root@fedora-41 /]# cat /etc/selinux/targeted/contexts/files/file_context=
s.subs
> /new_root/foo /usr/bin
> /new_root /
> [root@fedora-41 /]# matchpathcon /new_root /new_root/foo
> /new_root       system_u:object_r:root_t:s0
> /new_root/foo   system_u:object_r:etc_runtime_t:s0
>
> It would be great to have this behavior documented, but it's a different
> issue.
>
> If there's no other objection I'll merge tomorrow before 3.9-rc1.
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

I applied this patch and it addresses my issue (restores compatiblity).
I can also confirm that ordering the specs indeed also addresses the
issue at least in a simple test I did.

I do prefer that ordering shouldnt matter.

Thanks!

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
