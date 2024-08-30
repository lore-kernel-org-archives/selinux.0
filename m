Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F714A60D
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000333; cv=none; b=bu5bajkNQc3yBHRrJSOI1oNmaNiy/F9ER7EGW0bCR4PGGlRYDM7cwfsxkQVu32oZt76CSMhzeRsjCenXIko8kHuelU85JlHuU1hyXKkOwZ1Z8jbigaAiv+KRAeqBmFym7RHLFWHfzqyLzTZtmARzZ09wSh4CInohnf/o5R4d0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000333; c=relaxed/simple;
	bh=rKIQqEESjOIdMkakU2AwhTVO0PrZ7cZQ9mv1fHXc6mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eq7gY3E4pP0eCVB7b9sFGTcaxpGi1HABwelePNJsrL0sQijOVXf/WYSLKGAEt1NeBe/3UYIKhZW+68bhrmYeYzzCpDwShkPIkkipJV+SyAKmUU6ycFI9qzhjsH/HRygRzXkN/n/8q9yenpjtGvqJR/+bpPEAozislLCfOTz//Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtLsM+7Q; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtLsM+7Q"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5334491702cso3099e87.0
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725000330; x=1725605130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDrv4mDaLrsqxlIoZLGrthZ665Jpkk15tTg8WVkoGQo=;
        b=rtLsM+7Qh3ZyC6M78eARLqF5eOs7czXmJXEdEt/Pz/aB8Pa4USwMmV/KsOpTpslA2n
         10KreRSSKGYZ6g1A0KHJqhvK8I6UNeSRR+liqN1TUa4DrsD5OulLHfrs25LHawbTtix6
         tYfmZyHwgggL7kEOha63yPe2HuHvCAI8sFm7FWvWPZnPQgRNQNltXvQwu81EM1Jbf6oN
         twlFj6awgVlRqZJG1EDNvE+O4hV9qDXg30cn/l2PnZ8lflZpa91nauYGtKffrK6El397
         VOqy5nj8CVJzbNjWkGTdiqLxe/ZWI1iqhhLaMc6KG5PV8PU3muIhxhhZ5hrx04vQt/l9
         0lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725000330; x=1725605130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDrv4mDaLrsqxlIoZLGrthZ665Jpkk15tTg8WVkoGQo=;
        b=URMw1fLY+/wf2SjTT33lLdCL0/rzUbs3/iRDbWf03doAYxzbM2T/hbnwMmED1qVJ9p
         5mQb44iD5fr0nCC/DKUrqoD7ahuughzcuGmZzb2RhHbeT45Xiid7qJ2C6DHTmzSEIPmB
         msqyLTAnGF2F4EHsM6V/5cA1jIEgdMeoMe1MiZ2NF+BYH4vlHrH4BTRrhQDwzGYIQaTK
         BNs7vdwf7g45ySCyGO7nxk6hKjxKPAONrTNXu6dDX/efUjIWqY4JzbHtvGUjsRf3wocq
         gkrW7xOqcp5AJOiPt3d//xlEOeqXlW43Mml7wlVC9oEDHHNSZIPShT7H81bwcvbYLGgg
         6opw==
X-Gm-Message-State: AOJu0YxU/KFMPfz84Tlm8sHNVhWkCwMb3pXwfwaVkI/ETlYvcTKqWQwn
	61WCYeCCZtBDIFdi9dPv3fctibe7hA3g9uolS7ms6CIjWRZGAMaqrL6XP1HOjfR8q87xYTaXCIy
	GKMIB0svMS+Dkq3q86GBS5aJv/T6UDYktPp9b
X-Google-Smtp-Source: AGHT+IFPkpSF5I5Gl1m3spms1eXoXlUXDtbyEExpuU6RysVWi04QRIYHGZQxatC8E74j+3eUiWmiwtiP/ly4Q7NQm+A=
X-Received: by 2002:a05:6512:b1c:b0:52e:934c:1cc0 with SMTP id
 2adb3069b0e04-535463519a9mr76399e87.7.1725000328937; Thu, 29 Aug 2024
 23:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195755.19385-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20240828195755.19385-1-stephen.smalley.work@gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 30 Aug 2024 16:45:11 +1000
Message-ID: <CA+zpnLda-npA5XJzYewxhQ9HeE5MKiM63QGkWRrjPWZCbJK1_w@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for netlink xperms
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	brambonne@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add tests for netlink xperms. Test program is based on an earlier test
> program for netlink_send checking by Paul Moore. Exercising these
> tests depends on the corresponding kernel patch, userspace patches,
> and updating the base policy to define the new nlmsg permissions
> and to enable the new netlink_xperm policy capability.
>
> For testing purposes, you can update the base policy by manually
> modifying your base module and tweaking /usr/share/selinux/devel
> (latter only required due to writing the test policy as a .te file
> rather than as .cil in order to use the test macros) as follows:
>     sudo semodule -c -E base
>     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" base.cil
>     sudo semodule -i base.cil
>     echo "(policycap netlink_xperm)" > netlink_xperm.cil
>     sudo semodule -i netlink_xperm.cil
>     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" \
>         /usr/share/selinux/devel/include/support/all_perms.spt
>
> When finished testing, you can semodule -r base netlink_xperm to
> undo the two module changes and restore your all_perms.spt file
> from the saved .orig file.
>
> NB The above may lead to unexpected denials of the new nlmsg permission
> for existing domains on your system and prevent new ssh sessions from
> being created. Recommend only inserting the netlink_xperm.cil module
> just prior to running the testsuite and removing immediately thereafter.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thank you Stephen. I was able to reproduce on Fedora rawhide,
following your instructions.

Tested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
