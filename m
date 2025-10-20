Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385231E101
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968112; cv=none; b=Kj5MVHTmSUTFlqVjGCakzAuMxCu6VEPHhqtd0Zcq+lxLfW9WdMXp1KHpTn7NwYd39lili7kWJ+uf2KuvrbTwFt2fz7URCf/9KIicXu66B1k4P8mT2v4MIfISznZCA7Aj2GU6GunkFqEOj65Ltxwix7jbcufhFbGXtSTpou4Pzc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968112; c=relaxed/simple;
	bh=lHtKp1ZoYGMBLOHJ6Q60eT0SXpIdz44pLjRwCJ1hkGE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s8npg6NyYdTh5ytlADWYgcJckrNJntWEbYHch7RtT2HcTIOL32n6BLTsboh4kISht41+y49VW7gLTaYMac0Ryn+beUR9RKccygrU3w2yPLZFaF90x6+8rQndBn5ehuGsley2pg+jx2oPtd5Kkn4XVt2rIIiyQGN4CHrMshcO7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVlY/ZYb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVlY/ZYb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710022571cso36952135e9.3
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760968109; x=1761572909; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ0JhfdvGMiXpjliWOa61eI5s69H9yU4ieKGDoksS4Y=;
        b=eVlY/ZYbUgMUsoej8cjLL2u7JcSi5MatV+mKADHPHY49sTmRhYPkE//pC4aVeTAQ09
         ySIoJ3Luw7QSoIARd0gXwqE/2sfg+lzKhUOt8U+OBcj1EkwQC491U3zQx2hDuXhTzLQR
         pTu4YtnrULG8wzL3cG0kFdHdUeNtysHfP5tygWsGDtzJAX1YfxsyCnmc9IHM5nLnHt1t
         DBJ7yewTgB+ULcCphj4AFt+sZABu2VkYOC2GIC+s4JIQb0I6DINfkIrtaEAOoP3Crm/T
         0ljhl7wWFTAKo3FDgUrB+Bpk4/SG1s6bZp9smpOoNm63jvO3bPFYTQJAC5v3HE5kR3Qa
         hsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968109; x=1761572909;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dZ0JhfdvGMiXpjliWOa61eI5s69H9yU4ieKGDoksS4Y=;
        b=DEfS+7B7h2rhyfSlua58SaH/drLnA4rQLWoSm1Kgxo7d6N0tfEJhAnMf7clr62bzgW
         uYoTBIQZcj87nvBIeaBkyhbmXUnZKwhxiX/JHTjHj7qCxa5AFXRU+7wJbDBfiJVZ9qO+
         iFYlWphlFXGB6h6ZIq6C/fUWs9XNnUpsjK4WWB9np31+13bx7PDQ//53vDVK7y9CWzQS
         VCJeddF4V8hTFn2blnnxaue2hpwMNsnjXyFhKxEoU61GJKYzeQafgWgdPquhA7y8XqM5
         kFVjAq6ZzmZQyJml7n8Gmv+KURMNFwFhc6zpSzQqNgzaVq/mnr7wclVrztTzy6c1XW/X
         U9nw==
X-Gm-Message-State: AOJu0YzeVsr980JFIGhea5iW+exJY9Yh5aWhyzFEly7NXJIoITQBl5tO
	Y260QPfUrY8n4UlNwV1t0vQ4PJQ7BBt0uSTOMgJ8eNTD9LwY6KURzRfB
X-Gm-Gg: ASbGncunpxwZ6+O9bqe45Oyl2pGWGeuEOWyt8vqJbvOCDtoKyA/A4ciYpPNuFiqvQGe
	7KyFjhAJHryWdTc6lnKj49iRVNuN+qRfuM30jZAbg4UfNXWPw96gBJDnjRfbdNDKq+hg+KBqmJE
	lxexYg1J8p1Qxx86byORhskySubuTMJj9H/X4WhnKT7JWXSh763adIo8Og2yDnkF/BsO9fFHg2A
	iM+1x1MFAGtsJk490hntVhOZH5odpzglcR7hm2ZFWv8t+IkvzbbQhh4QMJtWk10+aZp6OjvGVSs
	ZL2vhL3KY2jSsWs0ShuEpq3B9z8ArS2Ats9WqrcYvKrheQ3NevSlg/RtQY88MzDV4V5GSkSFVdu
	Pw4uBxoO+4es31gTBS9P0rSzNBgrVTkaKUyDoeyX2SZGSimWfKKYESzX8u7cY/CyoE/fMT+nc8X
	CD46lWTOhP
X-Google-Smtp-Source: AGHT+IHJy/H/OmesfJOu7Rk+/s7iaSFSuQed7z7B9s9ZZq1/zkkVqbdQFmDOmZIXBjQA+KoFCdwQHQ==
X-Received: by 2002:a05:600c:820b:b0:471:1717:40a with SMTP id 5b1f17b1804b1-471178a8245mr89742375e9.18.1760968108367;
        Mon, 20 Oct 2025 06:48:28 -0700 (PDT)
Received: from localhost ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b985esm16009950f8f.34.2025.10.20.06.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 14:48:27 +0100
Message-Id: <DDN73GJRM4FD.64O8R1T8XR3M@gmail.com>
Cc: <selinux@vger.kernel.org>
Subject: Re: [PATCH] libsemanage: semanage_store: recursively create
 SEMANAGE_ROOT
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: "Stephen Smalley" <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251018051945.51425-1-nvraxn@gmail.com>
 <CAEjxPJ6dzwny-82pHpEHf6ugMDpXb_atFe5Q-EZBzte=NYy7_g@mail.gmail.com>
In-Reply-To: <CAEjxPJ6dzwny-82pHpEHf6ugMDpXb_atFe5Q-EZBzte=NYy7_g@mail.gmail.com>

On Mon Oct 20, 2025 at 2:15 PM BST, Stephen Smalley wrote:
> On Sat, Oct 18, 2025 at 1:20=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
>>
>> In package build/install environments, when semodule(8) is passed the
>> `--path` option, it is expected that it creates the entire directory
>> tree for the policy root.
>>
>> Some package managers warn or error if permissions do not align between
>> the tree on the existing system and the build environment about to be
>> merged. To make sure this is a non-issue, create the tree of the policy
>> root with 0755 permissions (in line with standards for `/var/lib`) and
>> then chmod the final path to the more restrictive 0700 permissions. As
>> the contents being placed in the policy root are security sensitive,
>> erorr instead of warning if we fail to chown the policy root to 0700.
>
> error
>
>>
>> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>> ---
>>  libsemanage/src/semanage_store.c | 58 ++++++++++++++++++++++++++++----
>>  1 file changed, 52 insertions(+), 6 deletions(-)
>>
>> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage=
_store.c
>> index 1731c5e8..c1425f15 100644
>> --- a/libsemanage/src/semanage_store.c
>> +++ b/libsemanage/src/semanage_store.c
>> @@ -491,6 +491,44 @@ char *semanage_conf_path(void)
>>         return semanage_conf;
>>  }
>>
>> +/* Recursively create a directory from a path string.
>> + * Returns 0 on success, -errno on failure.
>> + */
>> +static int mkdir_recursive(const char *path, mode_t mode)
>> +{
>> +       if (!path || !*path) {
>> +               return -EINVAL;
>> +       }
>> +
>> +       char path_buffer[PATH_MAX] =3D {0};
>> +       size_t len =3D strlen(path);
>> +       /* + 1 for nullterm.  */
>> +       if (len + 1 >=3D sizeof(path_buffer)) {
>
> if len =3D=3D sizeof(path_buffer) - 1, then len + 1 =3D=3D sizeof(path_bu=
ffer)
> and this condition will evaluate to true even though the path + NUL
> terminator will fit into the buffer, right?
>

Yea, forgot to change the check from `>=3D` to `>` when I added the +1 to
make the nullterm more clear. Will update.

>> +               return -ENAMETOOLONG;
>> +       }
>> +
>> +       strncpy(path_buffer, path, sizeof(path_buffer) - 1);
>
> Not sure why "sizeof(path_buffer) - 1" is used as "n" here or why we
> even need to use strncpy() at this point. We already know that path
> has length len and that len < sizeof(path_buffer), right?
>

Should be fine as I initalise with `=3D {0}`, but it isn't great agreed,
will change this.

>> +
>> +       /* trim possible trailing slashes, except if '/' is the entire p=
ath.  */
>> +       while (len > 1 && path_buffer[len - 1] =3D=3D '/') {
>> +               path_buffer[--len] =3D '\0';
>> +       }
>> +
>> +       for (char *pos =3D path_buffer + 1, *slash; (slash =3D strchr(po=
s, '/')); pos =3D slash + 1) {
>
> Assumes that path_buffer originally starts with a "/"? Likely always
> true but noting it.
>

I don't think this is the case, there are two cases here:

1. We start with a /, so `/foo/bar`. In this case, we have the + 1, so
   the `/` is skipped over and we start searching from the `f` character
   and find the next `/` before `bar`. In this case, we set that to '\0'
   so mkdir doesn't read past that, only creating `/foo` (because we did
   not actually modify the first slash in `path_buffer`. We modify pos,
   which is how we calculate where '/' is to set it to '\0'.

2. We don't start with a /, so `foo/bar`. in this case, we have the + 1
   again, but this doesn't actually matter! Sure, pos advances, but we
   never remove or change the initial character in the `path_buffer`, we
   only advance past it when searching for the `/`, which then continues
   the case like we did above, setting the `/` to '\0'.

I might have had some oversight though, please do correct me if I have
missed something.

>> @@ -529,6 +573,8 @@ int semanage_create_store(semanage_handle_t * sh, in=
t create)
>>                         return -1;
>>                 }
>>         }
>> +       /* We no longer need to use mkdir_recursive at this point: the t=
oplevel
>> +          directory heirachy has been created by now.  */
>
> hierarchy

Will fix - whoops.

Regards,
Rahul
