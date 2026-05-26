Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60683A14
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835178; cv=pass; b=mEs4wv39vIcNLTrJWzl+tXBr4747M63aO8/VGuhLiDWhdXqLLzoGTCQcK9jzhNKD5dFtsOZ+CM7Z2UMImCQ/qqXW6hsvcvQSreXSJbd9UxDLJMw3RgePF+OdVk7D9CcSGoOB276wsAWoredK2rs5CiEFnWNySdGDTd+tiPizVOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835178; c=relaxed/simple;
	bh=GwwBrn+z9SObIvq5sU5oIBL+gVqrYcmXfApHax8UX/4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QmuAF176+kJaaCNFcK/xzFMreBHJ2gQKzsAo5x+VY4y+Vt9RWGDAJDo+jAP4PLJJpDUaNLpoBsLE6LQFHCTQ+VBSWsfbmduJ58OclUU7UJ9AlWDmTpnLOeXXUmFMx9nheh2rx3Ep2uHBR51Wz5ITgApY2u7RvsolN3hFW7JpJxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lceRcue8; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lceRcue8"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c6a2158d3so8093686d50.3
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 15:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779835176; cv=none;
        d=google.com; s=arc-20240605;
        b=Zzm2I5TcofH2CeZA9sqhooBVZABWm/NhRLLrhS8uUYQhsrf5hWoHyr9YnpfnMSrux1
         rVwmi4WH51HpoNdWDAklYtawj9hpe0iL+HYElNfj/tHf0h3IxIc+bweWH9Gc4ZqFmtmc
         KWHTq6Klu9wXB3PsDhX4ELSNAS3+tMrhcu2Py4xY5hql9TxVj/vTH8nPCs58dJ4JmGit
         0o47fqvwRI70ALQLBAf97g/uYAixSfwUAV6pFa0hjTeyKWF9y4/PR2Cb8s1oiiewEfZ1
         1f0jCCtHw/oNLcvwy6dEA0ATMhZ9xkv7LtHPvpoZX48NPn7bGBQTmM21/063Vox7onRO
         ipAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vVAt65K+G8V38AN8GApoYXmDVFMGK2WPPS8C5x4E7bg=;
        fh=LiqUKi86URF/fNhHEa0UH8qBdBfJanOG1OBywS3XXBU=;
        b=eCg4WAYUjy3aUgqBSrFOgsP/FCxgyGvXWUr0zROmx7Bah+Fvv9iDG/KxikusNgIgpR
         mtQ5VoP5/kFzDNl/0qua7mVDprbjRjdqWlZ+HEZ0rsrUPcyczNOlqFYnXxsEWMSiHl9N
         V8XgpV1AKqkhi1ySlkosCZ4lGh7oIP8yaqHZ2Un8jNllra7FJmtppWOaOe/FdfM3cGM2
         Zm+lYOLYpQIXpJfuvqtUPziNxw8oautJN0uKOl4rBmT0pr+4d57NzP5GtUGd2iFHHLYQ
         hQpXKxgZz76bp5AsiHqMIYMTTLPdHZfwARPjv9QkGMzB3Ee+W5t4mV31ZluholAIFaCN
         NEUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779835176; x=1780439976; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVAt65K+G8V38AN8GApoYXmDVFMGK2WPPS8C5x4E7bg=;
        b=lceRcue8aRHW73NI8nB0p3vfOSQGvA23w89Q+9Z9nocCoyu8fz3HnoHwCsTmx0Zpc3
         QqX0+mOjlI7wCxEioHAArNaCwVT0kt21P1ZNOp/pRDcEGA4BEJp4PXk/vme9xAH9mvm0
         7lquAODrLG8jTyqAdV5h/eAiEAXD7wvfF/qKHpsFWtcwy4Od/uq3+j/mJarBt3skvUS4
         7s2Q4vIrmepBu4PBYEon+GxURBBt4wP8rASJUQJ3fyb2QWML24vnbeDON7sGh75RW9yI
         76Yzrd3jpu5FiG483MUoUaSXzTAXhGHpedvQaI71mXrHOlUFRu+A+iLDN6sAMS7NvNz8
         KrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779835176; x=1780439976;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVAt65K+G8V38AN8GApoYXmDVFMGK2WPPS8C5x4E7bg=;
        b=K7JL475lfLZQB1/5R4O01+x7Kx9t0v9GlCS3gVPGcO3YbjdAODj0H2vqCB8yqoQoBO
         hHCvFjLwfjaeAz6CNmQ6WgluTy/4KkNgZv2JFk7tCpjgySOexNu0hF5xNV+NWsXNdJR6
         WupZiLT6LSeRVSln82nQ9dRVg/+R78BdO3YRMJjasSw8gPxN4m36oTF5FTUVa/k+bkCv
         mtVgQLKK4Vd+dboPrW5arBIly9aNe59X1hQs0Mvrs4HCYkhFvum9+mNpa8HNpcgY1nSr
         LlGz/d104o4FKVtHrtX+ahsZmTLilP81bhBCQbCSGQfS7pcQuYTDrSIDx4xo74bkDDc2
         tAwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LIIT8GtVqO7QwsVgssMwRxY5HB6OP/1tmnodfKD4tMw+lAzsjzIymSgCv8xVMslQhD6BUr3oY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/3qIj8lR97CXm/wGvQfjOb9v5q1rcAMabw+r0APTJXiVf6xO
	EekEARW8hVRSmmeCMkUI83K4biJPmiVQmK2G3N74KzAQ6l1CuV+kFzqIPa7Kk9HZFOrMkkckDh5
	YAGDucwh9cJ0ygq9zi/iFrge3GiaQ8X1CGbDqT2c=
X-Gm-Gg: Acq92OEQ/psKVkCsLHd2/dNAQYkQac2oDS66pONculJ0pU20P3IdAk5UhNE/qC/m40b
	gpyt5B3WOIDDM9qc+9JMyA28iahfksD4lfJmdWVAff+SRu/9ok4oRhNkxP63m6tdLjGD2hPyWe4
	/PO5aOZATfK8uRRD6vZKPW2sSVMRTdAYTohDRCWsAJcH6ATiD+s7azOul9i0CcZqKBcFGv+ldck
	97QV4mtdG3+l0q9n2g6Tv+hqOvIQlZF8hVy4JdVMO2m+NKvqUAWeGiuClBKsLFvb8aesMOffQuy
	hEpKmCmJO5pQ42mhVB4UpqBin0al
X-Received: by 2002:a53:d057:0:10b0:653:1c2a:94a5 with SMTP id
 956f58d0204a3-65ec96184cemr16436623d50.8.1779835176242; Tue, 26 May 2026
 15:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 26 May 2026 17:39:25 -0500
X-Gm-Features: AVHnY4LBTBZu9I3pGIJPzVCjSbKmaYPGo3IVDyncqbmQDO-59BE8QXKQiGnEh9g
Message-ID: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
Subject: security_task_prctl: why -ENOSYS
To: LSM <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

I am trying to understand the motivation behind having
security_task_prctl only continue if the return value is -ENOSYS. This
seems to be very different from other LSM hooks I have investigated.
For example, in other hooks, the value from SE Linux avc_has_perms is
used directly. This essentially means that a 0 will cause the check to
pass, and anything < 0 usually an error.

In commit:
----
commit d84f4f992cbd76e8f39c488cf0c5d123843923b1 ("CRED: Inaugurate COW
credentials")

(8) security_task_prctl() and cap_task_prctl().

         security_task_prctl() has been modified to return -ENOSYS if it doesn't
         want to handle a function, or otherwise return the return
value directly
         rather than through an argument.

         Additionally, cap_task_prctl() now prepares a new set of
credentials, even
         if it doesn't end up using it.
----

The check in kernel/sys.c is currently:
        error = security_task_prctl(option, arg2, arg3, arg4, arg5);
        if (error != -ENOSYS)
                return error;

Should this be something like, "error && error != -ENOSYS"?

I ask because I am looking to leverage this hook in SE Linux, and it's
annoying to have to coerce all 0 returns to -ENOSYS.

Thanks,
Bill
