Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02924633D
	for <selinux@vger.kernel.org>; Sat,  8 Feb 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739022979; cv=none; b=ORlwsz+c1qj88MHSfJmnPe9uYx9FmYF+sNohQGeb4DmP7UAhAMxKk92HndTfn86H63LWBMEcXni1xeeLV0ZO1lud/bEcKKfy7BCcF7ba1cWYl2vOrVWEklWAUr0RmGOROfCbsgzXMxmt4c7fF/E+VHpzdJU1sim2hX7AMYO9hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739022979; c=relaxed/simple;
	bh=OmngAyJ4hz7jimnQVuS56HYbsMzG8pP3D2QkIifXp1E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VwXC4CEHgY8+1yAIoe8102FueyBXRjZRdJm/6Z0TFsfs40bcs4t9FakXjM5vrEHcSmUAd1XYoQyTxsOkLRZ/Wv6n/L35hgGwoI9c2SGjPZ/w3S1xPLOxYGqqwhpHK0zij1ebbXEq74qcLaPcJDQpbpTv+FV1zINHMiXReUjavFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tjvl94lo; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjvl94lo"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5439e331cceso3432417e87.1
        for <selinux@vger.kernel.org>; Sat, 08 Feb 2025 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739022975; x=1739627775; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pzI3WMMfOj8qGG2cyfgp3RqjhJf8IVE6vqmjmzj+ceU=;
        b=Tjvl94lo1SkwZaQdhoBWoCXMWmdmU4aF0rGjFA384CdlixT1FAHXLOBDbfqb7MjBcU
         snZkRautxd75UKM7+wfMGbm7TWbWFDx2bntWXzvvo+XUCKpjVwtvmnYLHP7dOlhyQ//z
         NP01tefeXwEmJzCSu2GIz/mZD3lojFjVv2DmBACrExOA1CVyBCBR/bGy9/e8x310mhAD
         ktKkh9iIxUKK88CjXR1ShZ+CB2YWtqYHwLig0ctMUmGoyUefG1S74QTQYGMIbS/+WnhF
         JsBUhPUf8Ar7hIdVlku34uBKLubhrCQICs1xg6JejHDeGOBlQaHPbRV+zz8HU0foHom0
         0c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739022975; x=1739627775;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzI3WMMfOj8qGG2cyfgp3RqjhJf8IVE6vqmjmzj+ceU=;
        b=B8bpiwsMrIgjC5PpqU1xfTQ64xYbIOl225KFKlcLgbydmjlV9AGAmT+c6Us2qrFVFc
         6gKGPASMAkfMBI8b9XCiQ8WXGUSlO7WH0vDpyD1MR73qhBp0xHcdXvLIZUIwbnkQYq0h
         XuOyO4BpjDRWkNzM8BbRsJiWuVY1ap9CQWjCwCDTkMKwhP84N+h8CKW+qq9J6Pfb73Fd
         yz/5IYDAJzMotIYJORMbMF3BpqV5rImA8Xblf+RKvDdU9vHeGxUllXggLfW9eEEeO23U
         WkGBPW+J4gJQMlC0uM/pY2RcA7lQl60KDUdil7CiAZaXohgscv0rue3v1MS5TGsueHLZ
         /+PQ==
X-Gm-Message-State: AOJu0Yx+OF4+wxyS/3emolqM5fpAvYS/fw99mFXpNRbgny8WqBKM2BXl
	n1gCsu8duq4jzGglh4CquK6VR69dVWFLAS0VNy3JWRjalY/RPyqvNOTVdDR77m3HGlxm3sFV+/p
	WPEaG06kQB+/KxodlKKCNkfsNBilzkZjx
X-Gm-Gg: ASbGnctDarIaAVNkSNRmCL0NiwPjOky4B7B+2LofvcAsWMiVTZJPZeLegoH7akDnJfy
	n/9sH8bBn5ERFJXJ8NoVNrOSWC5y2aQOVXmbuTGbZ8pKj0BjGoz5KLBII4Hf1R9IgyJpJDMWn48
	s+4+m6mGpbFXH611Z3lBJ3P4DrJf2lGw==
X-Google-Smtp-Source: AGHT+IGg29RXfZgPPicAJQ7MNtCa83i49g3rQk8hIj3V+WMHwvKuT0guQjPHmENeLrjmG7vn6e4TssIKGJ8AGP3WyPU=
X-Received: by 2002:a05:6512:4024:b0:545:746:f36f with SMTP id
 2adb3069b0e04-5450746f4f3mr280859e87.42.1739022974434; Sat, 08 Feb 2025
 05:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Darvond <xanthinzarda@gmail.com>
Date: Sat, 8 Feb 2025 08:56:03 -0500
X-Gm-Features: AWEUYZlkqRjOgDl6OLa5xjs4jye6Lx1SeaJ6DZIxtZ86LA8LAvwCd0BByLubY2Q
Message-ID: <CAHT0TqyAfxn38cpsBL36q_BLWk9PMhLDT9OmXp0EzAYae-iU7A@mail.gmail.com>
Subject: A duo of annoying SEalert checks.
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Context: Any time Speech Dispatcher is invoked within X or even before
system boot; preventing it from running.

     SELinux is preventing speech-dispatch from create access on the
directory speech-dispatcher.

    Additional Information:
    Source Context                system_u:system_r:speech_dispatcher_t:s0
    Target Context                system_u:object_r:cache_home_t:s0
    Target Objects                speech-dispatcher [ dir ]
    Source                        speech-dispatch
    Source Path                   speech-dispatch
    Port                          <Unknown>
    Host                          Dellingr
    Source RPM Packages
    Target RPM Packages
    SELinux Policy RPM            selinux-policy-targeted-41.31-1.fc41.noarch
    Local Policy RPM              selinux-policy-targeted-41.31-1.fc41.noarch
    Selinux Enabled               True
    Policy Type                   targeted
    Enforcing Mode                Enforcing
    Host Name                     Dellingr
    Platform                      Linux Dellingr 6.12.11-200.fc41.x86_64 #1 SMP
                                  PREEMPT_DYNAMIC Fri Jan 24 04:59:58 UTC 2025
                                  x86_64
    Alert Count                   2
    First Seen                    2025-02-03 05:08:51 EST
    Last Seen                     2025-02-03 05:08:51 EST
    Local ID                      3db93a55-befc-449c-bc19-b8047059d506

    Raw Audit Messages
    type=AVC msg=audit(1738577331.806:80): avc:  denied  { create }
for  pid=997 comm="speech-dispatch" name="speech-dispatcher"
scontext=system_u:system_r:speech_dispatcher_t:s0
tcontext=system_u:object_r:cache_home_t:s0 tclass=dir permissive=0


    Hash: speech-dispatch,speech_dispatcher_t,cache_home_t,dir,create


Context: run0 operations are not being allowed for DNF.

    SELinux is preventing (dnf5) from entrypoint access on the file
/usr/bin/dnf5.

    Additional Information:
    Source Context                unconfined_u:unconfined_r:unconfined_t:s0-
                                  s0:c0.c1023
    Target Context                system_u:object_r:rpm_exec_t:s0
    Target Objects                /usr/bin/dnf5 [ file ]
    Source                        (dnf5)
    Source Path                   (dnf5)
    Port                          <Unknown>
    Host                          Dellingr
    Source RPM Packages
    Target RPM Packages           dnf5-5.2.8.1-3.fc41.x86_64
    SELinux Policy RPM            selinux-policy-targeted-41.32-1.fc41.noarch
    Local Policy RPM              selinux-policy-targeted-41.32-1.fc41.noarch
    Selinux Enabled               True
    Policy Type                   targeted
    Enforcing Mode                Enforcing
    Host Name                     Dellingr
    Platform                      Linux Dellingr 6.12.11-200.fc41.x86_64 #1 SMP
                                  PREEMPT_DYNAMIC Fri Jan 24 04:59:58 UTC 2025
                                  x86_64
    Alert Count                   17
    First Seen                    2025-02-03 05:09:13 EST
    Last Seen                     2025-02-08 08:36:47 EST
    Local ID                      ca351e52-a53b-49f4-854e-4e155019ceef

    Raw Audit Messages
    type=AVC msg=audit(1739021807.975:2774): avc:  denied  {
entrypoint } for  pid=469897 comm="(dnf5)" path="/usr/bin/dnf5"
dev="sda3" ino=4197266
scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=system_u:object_r:rpm_exec_t:s0 tclass=file permissive=0


    Hash: (dnf5),unconfined_t,rpm_exec_t,file,entrypoint
