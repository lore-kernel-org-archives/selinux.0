Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28801354AC6
	for <selinux@vger.kernel.org>; Thu,  6 Nov 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459079; cv=none; b=JOTS8Jw8A02p7i+qrk9C/H3rd0PfefyZ6d0O68esmEjyziWDu35nnYnm7bs6ST/QIbwvW7zpoPSqawrjlSE2K8dSOeaUkvuHp8ntQZLZrqSPW96AP2bg2qSCDmXAFTaeozvZ2MAOrwryIC3v6+jJNhVEz4n7c0kXJcZn0LFeVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459079; c=relaxed/simple;
	bh=okHFpo+o7hPVL7uvrA15kv4GJ75VSWJZG54vVcFD5RI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=AyOg8OXkM6dsYM/TMMr7rO2quzNHL1XkQJvIfaLCOqFlspUqDRwM/bZIE1jvwqIZNB+wgIrxjEPQBg9tl2VkIv5Z/SV+UzDU5mJvbyxOwFYeOwzSZ4eSLi/Udt0FD8tRrClxK1n3epLgFZ9tIPGwpsDavPN8spCpLBPv/frMEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDotKBz8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDotKBz8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47118259fd8so19255e9.3
        for <selinux@vger.kernel.org>; Thu, 06 Nov 2025 11:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459076; x=1763063876; darn=vger.kernel.org;
        h=to:from:subject:cc:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WSA2cs3T/BM46eQaZwiGWGxYdel8RomWmvzYINlNbY=;
        b=SDotKBz8Ev8Dt5Adsg8Zx0uYKJdKa6SAKjDUjquN0J6Cu54JN/IoGYq7d2ryEC6mlI
         D/GI7D5XLdxdxqKfZS4d0T8VS6eMdHuR3P0T+fWKuwFVQ8YaztmwEdLYayzoEKhdemB6
         tqmmIC+1eX9uuNUpfIEd9Mvt8fd/KcVHzJMlpUx+npSe8YdRuKTqfZ3M0AJxClSs+WAn
         Rg8uP+10iRjX+Z7OSfwunMUiP+DtgmJwV0VPrGLYWQ5Tq+QFQ870yNBfurxieB/in5t0
         nVQ8fN4N/B3WaqG0/AnrLnPonWhSwqJtZeSKtVUqdhn7nJtDs9NiaAVpIbXDo2Wx68cE
         j1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459076; x=1763063876;
        h=to:from:subject:cc:message-id:date:content-transfer-encoding
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WSA2cs3T/BM46eQaZwiGWGxYdel8RomWmvzYINlNbY=;
        b=WkDbSH+cx9RXNpzS7kXBCwVDYLLqiYvV9Zkd6NCJYmqnczBS0NG9kyXVkK8yfpqZX1
         fO7mBWhl4sxBuFSklHcbZOlkvimJvQJ0G1LBcSopIzhJirqrkuAAMbHPsvj23KNx/Rrh
         YmqaGrXD74iDSc1pasxwHX3ggOC/Idrfpdi4WnZaKlSkNKZCF47K8VOOK2a7RLvUCRhU
         F4dq42kXaCb8d8lKaPlOvoV0QWk1SyPYDLdNXzxvzhBPiikdBIUg6KWjLQrYDu6WpyUH
         bExDiIy10XIj6/hge4q5QU9IrYVIzrPp9BSY/2dApRpkiI1WJ4eaSFJbwu9F8jETs/1+
         vKsw==
X-Gm-Message-State: AOJu0YwoOJmXjD5SbQlMzR6tX2fFAFdzok+oJWH78wCLFMxFyJIButnb
	S8JM53KnjyTmOoXv334o+PC6dbWMNKEkM2chFIUCWkKjXwGsJgPNXkhY6xJejA==
X-Gm-Gg: ASbGncuzQnx7F2X2baqvRwFBNTEcZoV2CqAbgzIyzwvRfHfvYomR4eutfxhGFvYBVlG
	sZKH3uU7mOBiv1vO5x8dzfTlYevLv7lb9Ti5G3CgCORXTHGkrInw6a0O/p1WUUuFM4Wr2t8ls3H
	xtXoehiwhKl4+umWSDHMuMbHR2idIB+C8VwmRJWxc/99CcixLypv7Y4dQfqd0OLLBWh/ljaomeo
	l9iQZYlZ/eB02andzvn8O+hiPySnYEbiy0R2kmaHMrIZdfoqmE7YGyK/dip8jVQoRN69SdCRDz6
	4DHG+dB5+gxGDrG58nhchu5OnpCZukflcZ1lmfMS3Y15SaoAhBIDSmmmhhbfH5q1NH5b/bqX/Kn
	Al/T4fee8bmhkEicJHrasN3SwdA5VVzkTpwINpAc/UwTFfvr0ZF7UMsvTyI7oox8Gv5p4Sw==
X-Google-Smtp-Source: AGHT+IFySofO6SKeXu9WVf+ZErPzxVuq3FeurxQeBTQmH6uoHAwAhPAAot4aDK9iLX2uPo7FPSZbmA==
X-Received: by 2002:a05:600c:524f:b0:477:54b3:3478 with SMTP id 5b1f17b1804b1-4776bc86518mr4445805e9.8.1762459076327;
        Thu, 06 Nov 2025 11:57:56 -0800 (PST)
Received: from localhost ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bccd2f9sm7846455e9.3.2025.11.06.11.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 11:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 19:57:55 +0000
Message-Id: <DE1VLLSK1NN9.CCD295WLXVQ6@gmail.com>
Cc: <dominick.grift@defensec.nl>, <lautrbach@redhat.com>,
 <cgzones@googlemail.com>
Subject: DBus Permissions
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <selinux@vger.kernel.org>
X-Mailer: aerc 0.20.1

I've been looking into SELinux support for filtering DBus permissions
lately. Right now, we have a few things of note from the dbus class:

(class dbus (acquire_svc send_msg))

1. acquire_svc. This is useful for:
   Allowing contexts to own names on the bus. We have numerous names
   that exist on the bus that are effectively trusted: applications
   need to be able to trust that the owner of a name is the intended
   target. An example of this would be org.freedesktop.PolicyKit1 and
   polkit: applications check if unprivileged subjects are allowed to
   perform privileged operations using this DBus API. We can make use of
   acquire_svc to ensure that only e.g. polkit.subj may own that name.

2. send_msg. This is useful for ensuring that subjects may only speak
   to their intended targets.

However, this has some serious limitations. For one, many names on the
bus provide *both* unprivileged and privileged interfaces. An example
of this is org.freedesktop.systemd1, the systemd api. It has various
actions that aren't all that privileged (for example GetUnit) as well
as actions that are highly privileged (such as StartUnit). A bug has
been filed[1] such that any service capable of speaking to systemd over
dbus can effectively escape its sandboxing (systemd's sandboxing, not
selinux confinement)! It can simply start a transient unit using dbus
without the same restrictions applied to the unit.

In the case of systemd however, the situation is actually *much* better
than other cases: systemd is actually SELinux aware and is an object
manager, which means we at least have some control over what happens.
However, dbus is a pretty fundermental IPC primative for desktop Linux.
Plenty of things that aren't object managers nor SELinux aware provide
privileged and unprivileged interfaces on the same bus name. One of the
main advantages of brokering is the ability to perform various checks
without the server needing to implement them.

Hence, I propose extending what we can do with DBus to allow us to be
much more granular with it. Other LSMs and IPC systems already have
access control similar to this:

1. Android's binder supports service names being labelled[2]. This is
   slightly different to the case of DBus here with binder being part
   of the kernel, however the core concept could still apply as we may
   simply provide dropins to extend the functionality of dbus config
   to label names, and extend the dbus class. This would provide back-
   wards compatability. It's also somewhat limited however because of
   the DBus IPC design.

2. AppArmor has a much more rich access control setup for DBus. It does
   not require installing DBus policy files, and supports performing
   filtering based on the bus type, the path on the bus, the interface,
   and the member. It also supports representing this all in policy[3].
   This is in my opinion a much cleaner approach than requiring us to
   have loads of labels for each possible member and interface. However,
   I don't really have any idea as to how we this could represented in
   policy. Maybe something using xperms? But I'm a bit lost as to how
   an xperm set could be mapped to it.

[1] https://github.com/systemd/systemd/issues/8846
[2] https://source.android.com/docs/core/architecture/hidl/binder-ipc#names
[3] https://man.archlinux.org/man/apparmor.d.5.en#DBus_rules

Thoughts/suggestions?
Rahul
