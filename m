Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308D20E312
	for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262670; cv=none; b=AqI5ekm2SrUaTozFAScyCdbckB6CihtuW8wJzQiYGk0n4YGWdG8rQxQh8nIenW5Sw1BeFvLEg1iCJCqAIeLPV9YzqwUNCUh69k2NHVHpMPGWI2PU8KUXnc9lDQYSWb16C1PukS1B6HiwGSYPF41xtkksMo6sQ4AZb0489lfGsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262670; c=relaxed/simple;
	bh=cOT43ZVN31nqYXQvKem7Ov+WLZFEPA1n6D2WFHJSS/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKVk3S4KnCPVUnRE2Gp3bUSThOqcTcuFwgh6VDMbcc8BDNzCbaJE/b3tuG/s7c+TMmI4W80t8aO89Ev0SidWN2emVe3/gQe+27/meApCiy2lkj23Dc0CL46NiswzalHh7zqJjgdNx6dz+2HdYHIHYNxwQxpwg+0+b0VSWvCKYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GleHw6WI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GleHw6WI"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso1744138b3a.2
        for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729262668; x=1729867468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPxKtclr+UEe3JbvGdpTmtlZd2dusSUmkPQfihPXJFI=;
        b=GleHw6WIe3c2cfoj3RFc6gT5IcZl37HMm7RiyWjCLb9TAVWchhCwtVbxhjjmgdrldp
         MCT18SuswgioL4ULTdCK2yzeculafxygoY+PdlFTklLYUqrurj9e4Uyum1uIcjESgTqt
         uism+rQiHiR7t2qBEetjnxl1J49DLf3MO82sfRyaQBwzmf2DI2uVVvs3bNsuTsJuXCG8
         WEyg5YRu/4mLFtnlkgF8BPKeWWMRgfw9/0+Er83/wIwp0stAIUeaZnOSPMQiixC8wDQe
         vssS4wUyIkqKl3Bf44U3Ao4CjA6UY8+GAUHYBu1wLwoeTqdv/M46QBX8Ox/31piQlWv1
         PZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262668; x=1729867468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPxKtclr+UEe3JbvGdpTmtlZd2dusSUmkPQfihPXJFI=;
        b=pUEmgRn4NpIJNKOTCTHSHuAE3eR1/IdyTja3EPcPJI4I7vADfmbU/1P0NSWoe4yin2
         suzWcsHj6Q+6LMg+CnKbrSdMaWH6yqNGzhkIQb+HeeCgvGlAhCb5mOXNdZlM50GS63pz
         8o389FSYHgMTt2MA5cghhTLvkH30ZJxzT64LrfjCqnQLuMAXWrYZ883FF24AG/K2Rsp4
         ulkvPUMIeUrwqVO7bZDPflXgM316RRuCgAwPRdgLHGNAWNUT2UM92y2rqmtkAnoxDeV2
         KWAV3PZVfA8nu9R/REccTNX3KdBOgDoUDfn/cN63HLcPb/5ICt084ZvuZ8HT+vIm0NbK
         RjRA==
X-Gm-Message-State: AOJu0YwmE1AhpEUgk4/H7pZETTd7lmFFrILv3VA+58L9AL2QpOF1nbQv
	o7bk8dhny2tOZXFHoBHnocoVtISSwck94WNooTuHzN6ubbAQoYr4y4LXTXxwZOUjw+/C5Z+NcIe
	pBdUA74AFQiTnVgrPpDWJ9H1IbVvhWg==
X-Google-Smtp-Source: AGHT+IFEOlc0GftuzCsXqTVFrjdw8QqmrSwU9O6w8coOVT9EvhcP4XHBp0KnDzfRYTZF5NnES1t5SkHMe5OMai2l1Yc=
X-Received: by 2002:a05:6a00:1955:b0:717:8ee0:4ea1 with SMTP id
 d2e1a72fcca58-71ea2e1f440mr4421455b3a.0.1729262667761; Fri, 18 Oct 2024
 07:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a79e0e6f-e83d-4b4b-a55c-3f2c20b93c83@linux.microsoft.com>
In-Reply-To: <a79e0e6f-e83d-4b4b-a55c-3f2c20b93c83@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Oct 2024 10:44:16 -0400
Message-ID: <CAEjxPJ4Yby2Y9mYf-mCaFy3cPZ-Ukzs6VCQER6uB0K_UeG=wUQ@mail.gmail.com>
Subject: Re: selinux_set_callback for policy load not triggering
To: Matthew Sheets <masheets@linux.microsoft.com>
Cc: SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 3:42=E2=80=AFPM Matthew Sheets
<masheets@linux.microsoft.com> wrote:
>
> Hi All,
>
> I am currently working on an update for dbus-broker to trigger reload of
> its configuration whenever an SELinux policy load event is seen.
>
> For some background dbus-broker is comprised of two major elements the
> launcher and the broker.  To trigger a config reload you can either send
> a SIGHUP to the launcher or send a message to the launcher over dbus.
> In most cases the launcher will be the brokers parent.
>
> Here is a link to my current PR:
> https://github.com/bus1/dbus-broker/pull/379
>
> In this current state things work.  The broker will see the POLICY_LOAD
> event and properly send a SIGHUP to its parent, but as David pointed out
> my initial attempt at the fix is no good since there is no guarantee
> that the brokers parent will be the launcher.
>
> My attempts at moving the callback registration into the launcher have
> been less successful.  From what my debugging has told me is that the
> selinux_set_callback is going through successfully and the function
> pointer is correctly pointing to the callback function I define.  But
> when I trigger a load_policy my callback function is never called.
>
> I am not familiar with how the callbacks in libselinux work under the
> hood so I am unsure about what could be blocking them in this situation.

Caveat: I haven't looked deeply so take this with a grain of salt (or two).
There are generally two ways of discovering when policy has been reloaded:
1. Create and receive notifications on a SELinux netlink socket, or
2. Map the SELinux status page and poll it for updates to the policy seqno.

Internally libselinux has switched to using the status page whenever
the kernel supports it since doing so is more efficient (no syscall
required to read it once you've mapped the page). As an aside, the
status page is also more easily "virtualizable" for SELinux namespaces
since it is per-SELinux state/namespace already (the netlink socket
can also be virtualized via a separate network namespace if/when my
namespace patches land but that requires you to unshare the network
namespace too).

As far as libselinux APIs are concerned for the status page, you can
check for a policy reload or enforcing mode change by calling
selinux_status_updated() at any time after having done an initial
selinux_status_open(). selinux_status_updated() will call any
registered callbacks if enforcing mode or policy was changed, and, it
returns an indicator as to whether anything changed since the last
time it was called.

Or if you choose to use the netlink socket and want to use the
libselinux APIs, you'd call avc_netlink_acquire_fd() to create and
take ownership of the SELinux netlink socket and then poll/select on
it for notifications, and upon receiving them, calling
avc_netlink_check_nb() to process them, including calling your
callbacks.

But you have to do one of those two things in order for your callback
to be invoked. I assume dbus and dbus-broker are already doing one of
them which is why it works for them but not for the launcher.
