Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A51FE469
	for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918574; cv=none; b=g7KkyiBc3mg1JhrLaFzu5SjM8j7Kw9yzettDfyc+JEwOMFJnTz+7EyiubGV7mwWOCtFRZxqj7YbFHJOJ9I0PbF1Tyba+lSVNWSeDaXfZ7Fg7ZwEgRDqihicv6wJ8PX+P22C4FYX3j6DSc7zfyOUFedCfqR4xrVGr7dPgMYIiwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918574; c=relaxed/simple;
	bh=Mzw137b5u0+vtOCRWJBURT9CYCCPRelOHqiM/5rT+do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=josxa4MA2SnmRfV7cptHllcJK5SwVPnZHQcboAhqPYm4+k0PJe0JTvm1NBns+UMuv4LhdqaB2t3ARCz1rJ943nyBttSAq/29aCd0bQVDLdkzQjaaLqxtW0tMx7XisRwKQwL3WhtQSe1bWvCCuCw/NmtBWgZHrmBulSFp3RJEU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dIdhVH52; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dIdhVH52"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-702628e34f2so10438087b3.0
        for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744918571; x=1745523371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3586lSaXKBGBxBfsuEweo/iL3qrecKfGWnPMGoUQ8bg=;
        b=dIdhVH52jEKORJpfJX6uxERGEybRChv+Dx9saiJ2Td2DgUr99mEvAiLr8ZlDCO0kru
         UMTB3v7yWq5kVDKhqAvmahSwIB6wG9hhgCP8oMGiI52xEDyqZVW+UholViQZlD0o7V/G
         w7YKtEKiMgbGHfKdMF1SJMdYyRSgtfmNPusypdCriAabQt0NijgcZBkybXhsYXtHchOW
         ATbQTzT5HfZfuCMmzgD9qS9O+qS4u1nme2mq5X34OckNW/0Ld1qkt/F4gA4TCAaIN0hp
         TzMVQtD+wHfd7oypi7sjSMkXSJtOT+cx4O1dR+7UtCQ+QCLVZintQxecGK1Qmx5/ugk/
         Y1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744918571; x=1745523371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3586lSaXKBGBxBfsuEweo/iL3qrecKfGWnPMGoUQ8bg=;
        b=R+AHg5mncUNcKzzfn5Rrd0AEBTWzcl+jWcNA3UzEijoQn4ysQCMJK3IjxY5ylT9tj1
         GbQbza66qhvYyVmX+zRWWFXsByz8rbLreGgkeYysyL6soQC+eUNrbEIRHQvEO9wipJjz
         Btih+imK3Kq09yYuDD7RCwDtaWJyB3d6twMRsLPEmvgXZQMtCVD528Az8eKQhWFfALFt
         UpXr7pK6O6feKzBDJ+/BCaAHh60+7O5I1x1BvqnlTnDAeW3+siZc8jsHA4/ugonZMDTx
         1SSPcqktZJmMyt8r8U5MEN6b65tSM/pFwcaaLY+hgqLTvF/3xKr3KmTujnYhQEqJtc/f
         nEGQ==
X-Gm-Message-State: AOJu0YwVvlJ1SWYKl8lbolXCJPU8DQB+TK8btQB563nIi/acSt8q8BeQ
	Rf7YG+9xXnVlcE3GG0YGpGNxv0aZouaqtlRcsWqoXaVt99fJdOWHmBTN2LnAYQyQNHy7cy5CYfP
	F8pPrSRqboOxFSxAmX0hBq48qhEA=
X-Gm-Gg: ASbGncu/pdxmB3+4g08Wi1McC7vf5L0c5Glr2xAIXvMeQg2m1VshA22wkj7wNxWeH/0
	2oSqybInxHpUGPyB4MkXQbDt8sxslQN8EqoaP8kfnMxNoKCzJJYPzZwX+u7NvBtUBDCLKkqjZrs
	08daG0BY67z5YGAxVvM9oeGMs=
X-Google-Smtp-Source: AGHT+IHRv3VyEa9uR34rEwZ0EPIEoRB3TGBhKSTgI2VYxNYEAdLu9ISC4ESNQmzKdEXaRSN1ZK58t//g9264DusoPN4=
X-Received: by 2002:a05:690c:fc4:b0:6fe:5dba:b190 with SMTP id
 00721157ae682-706ca4b1955mr20979307b3.11.1744918571123; Thu, 17 Apr 2025
 12:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qnzzxi8.fsf@redhat.com>
In-Reply-To: <878qnzzxi8.fsf@redhat.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 17 Apr 2025 21:36:00 +0200
X-Gm-Features: ATxdqUFXWS6sns1YIQjUXQAmzcFjIj7tmJnrqX5KhmRfk5-fY3fVx2_L7OgwHoE
Message-ID: <CAJ2a_Dd0zcqbGT7K=G=8zNkatKKWsegEkEjvadgJcqudNgdxDg@mail.gmail.com>
Subject: Re: Regression in selabel_lookup after "rework selabel_file database"
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 22:01, Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Hi,
>
> we have a report [1] that in specific cases local fcontext modifications
> are not considered or correctly resolved in `selabel_lookup`:
>
>     [root@default-0 selinux]# matchpathcon /usr/bin/cloud-init
>     /usr/bin/cloud-init     system_u:object_r:cloud_init_exec_t:s0
>     [root@default-0 selinux]# semanage fcontext -a -t bin_t /usr/bin/cloud-init
>     [root@default-0 selinux]# semanage fcontext -l -C
>     SELinux fcontext                                   type               Context
>
>     /usr/bin/cloud-init                                all files          system_u:object_r:bin_t:s0
>     [root@default-0 selinux]# matchpathcon /usr/bin/cloud-init
>     /usr/bin/cloud-init     system_u:object_r:cloud_init_exec_t:s0
>
>
> The bad commit seems to be 92306daf5219e73f6 ("libselinux: rework selabel_file(5) database")

Should be resolved by
https://lore.kernel.org/selinux/20250417190812.41263-1-cgoettsche@seltendoof.de/T/#u

Note that depending on the original file context defintion in order to
take priority one might need to specify the file type (i.e. add the
semanage arguments `-f f`).

> Please take a look.
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=2360183
>
> Thanks,
>
> Petr
>
