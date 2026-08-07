Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B52F7EF9
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107175; cv=pass; b=QBK/248mAMnTbL5y9u7OIDdEPfDL448pxwo/NjmsUSeL2FgN5SW/kEhmFoWkQ1i1TtZ6+tm7xaTuDxfS3WFwOmM0zEVU993iPp5Su6zHYg1ghEDN5AkG38KiZK2lshVhRBvJj5FRBN2HUCJam8CZgv/cy+lKsnXF//TqAWpL31w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107175; c=relaxed/simple;
	bh=n1Jk0w0t83tEbuLRrzIduIkpC/SDy/btBMYNY6uxxh4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Y/Yr3N5/PlM1gHYI6QkStbRvKDMpoEkPNoiqwMeUyO8gUiEN3aAxCoaGZGhLg6Jm2puGhewjgM6R/2kXnUXP+rwI+60a+RBcQEM91P4HjhzaMl2yVIO7SFjX6sADJsdAom4ZB/72sVCK6mHCqddORSPF3mNMcy/FtRxhG0opkXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3Otj5ad; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3Otj5ad"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-44cd237446cso2210036fac.1
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 05:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786107160; cv=none;
        d=google.com; s=arc-20260327;
        b=CRsazjRWSUMB09cHiPLCy6JSmlxqTt4qUttVT9Yd9pQ9E8DF+kR+YMQXcaPe/mmLlN
         Y8AP/hFSVZqD1d5F3m0xyxacbMAgq3kuiYrMpVM8zbsg9NvsqQU05kD9Kub9Udu4T6tE
         EcTEU9yvlWDfzvQ3uEfk95WNSjPj9JNV1MN0AVgf/0XhLGFrhSRx19olaWqR1SfpJ6IK
         k865n76Oj2JxPJ1/ZX5s/Mi2D7XHH8+iw7s32Qtu4mCBwSrnovR+xUyEQeXoVP7twq/e
         Wi4Mh2CH156IWMePcuxpNQLqpWjjexYpBbkOMFuy9QbVu9SXJZ142oibRcH1y+WJoVTO
         TjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=n1Jk0w0t83tEbuLRrzIduIkpC/SDy/btBMYNY6uxxh4=;
        fh=oUd6iX6eGfmfzSvqOqHtUAkZ8nq97+hvXuiTZgFFhEY=;
        b=khE3pWeSJBZex60TCYODhGN9Y6S+UQMgt0IO7z+hhxsKsUKE5BFtT77SHduyRxs7oQ
         3NoSmuT2ht4BpNdvfc2k1tn+vSCbKNjzvdMtEH+uoJF0ToXMAzr0nOPickbQq/vrrMvF
         mrUkXOdRN6SI7M2VO7dDB1W6eCk1yY4xR9INzDmnus8V2ePAfOY0SUbyEYieOwaknFi4
         VZqeW3kwOqF78kgROaQ7EJi9c251NB6dnib3b20HzUR4bFK+S63/0zrfSNY8BklsLrAy
         AYQvSBW2nuF57jjvPoISFh6X8DTYB1AUwn/dRiq6+GgovrAotZ8UzdvkynJ5238BCmkM
         rRxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786107160; x=1786711960; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n1Jk0w0t83tEbuLRrzIduIkpC/SDy/btBMYNY6uxxh4=;
        b=c3Otj5adn9eVhCPcU6PaxGiQwrQ4C5h3Y/gW2FfbEBpreaR2/8KHbUbmehT8KqybJH
         QfT8gPVs6IaGazVAE4+V1E81woPMhDC7mMgU1BdCnoWh4DvFK+0ximTpgI0gq/ZD3z/A
         PWVtkrpDyGQ/OWRPMda+cLxvFrwk9TGFMCjiAfmIiUaRCeuc3TDUywNM93X3ntOtvzsi
         X/2/WYL4QMbSmmh7W42cRDaVFOjEtsiJDZB2nzNH2ziLYXSckmtFZVRaJkIw15+WqUX1
         RcDu007ZmwQ/DCkipXbZuaAQIjphhDg/mJOpUqnB6QUzswL7mzcyqR0kI7OXgpj+FzoP
         o43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786107160; x=1786711960;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n1Jk0w0t83tEbuLRrzIduIkpC/SDy/btBMYNY6uxxh4=;
        b=XsZh40AfbYsi2zblG5TLBGmPiiq0jGV6a3YDGXKVnGcrHbT1Bokgq0d837Aq8vLmk7
         IUuxJlm4amO+OZY+aS1eezxg5o19aNtrc1UBoC43ikuZ89PSEUDNyml+W8x1Bt8YRY8b
         cfx6ICtZp+VvlTF60Fe+fVmUrqX5UtRfmYEQXMTRhHx0XwktGyrztKdTNIU/OlpbPEwM
         fDvRwDL36rCd8IYnK4QGni+Wkv7FB1tYg9Q/BH7oBsW6jEFqyIuuSVXcuZ2qTQb667p0
         0gakMy57+ISCF4DuEumJ51bnOGoEurQdjRha3QbIjyVYN9bsE7ie8/W/OdPkUPzOoXu+
         RYFQ==
X-Gm-Message-State: AOJu0YxKO98SmelJIErD97UL2xhEyUf2Nmlsy7AQY/LYhz/3JYbbHJve
	XVHUp3tk9R9PRxI0WE8G/uZNVudeSrFp9EKTP+Ivp7sX2zFwgDepv7vfLV35lBc1jPMBfjGmv3u
	sXeNFKcnzRWCUW1VdBxKYC+Xx2mltRuIw/yP6
X-Gm-Gg: AR+sD10EHk04SMqO90v2J5DS9koSv6lUNqZrfO2ntzbrYqWt32w4/zvHkeqwHCIpx5N
	mQzmmIom4EFVvpfjGl75MW2sSom0rSgqEXRn7zVLdHjFsGq/82I0L/EsNVtTiFGPHsy0lTUBSRO
	4CzkABIGakHNgZtPOF8kl6nSv3kcB3IWWaqFDZLDDpDqw8oB7bM81d+0VJFdRATd2+PIp1GpmB5
	tZQwXQi5ysVOeBNl1g1BpfrOT6ayGA44YjoSr8eyxn7ZcDPczwabv2mNBIH3snVptDfup/UvMo+
	tyty0vOYCLuiyjozwmt7OFzWspch/5EifynIjJEJLTcR
X-Received: by 2002:a05:6871:eb14:b0:409:5241:8abc with SMTP id
 586e51a60fabf-459ffc96be9mr1523173fac.20.1786107159890; Fri, 07 Aug 2026
 05:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Aug 2026 08:52:28 -0400
X-Gm-Features: AUfX_mxil7Qn5N_wrZ_XCMDMAgs8VfUfkHtd9wNUG97p4RZemIZt3XvbWhEhxf8
Message-ID: <CAEjxPJ69EVhwVX3sCUguMNF8M=0G3shhfzOh1QM+TUiEJMZ8WQ@mail.gmail.com>
Subject: SECURITY: policycoreutils/fixfiles <= 3.11: relabel files to
 incorrect security context
To: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

An upstream security advisory for CVE-2026-19079 has been published at:
https://github.com/SELinuxProject/selinux/security/advisories/GHSA-647q-jhqw-6p4w

The description is included below but please refer to the link for the
latest information as it
may be updated.

Title
policycoreutils/fixfiles <= 3.11: relabel files to incorrect security context

Description
fixfiles is a script that wraps the setfiles and restorecon programs
to provide a more user-friendly interface for fixing or checking file
security contexts. When called with the relabel command, fixfiles also
attempts to clean up /tmp and to relabel any unlabeled files in /tmp,
/var/tmp, /var/run, and /var/lib/debug that may be leftover from a
previous SELinux-disabled boot. fixfiles does so in an unsafe manner
that is subject to TOCTOU issues, making it possible for files to be
mislabeled.

Impact
If an unprivileged user/process can execute commands/code while
fixfiles relabel is being run by an admin or other privileged process,
the user may be able to trigger a relabel of a file they do not own to
the wrong security context.

Patches
Upstream fixed this issue by dropping the functionality in commit
https://github.com/SELinuxProject/selinux/commit/a556538c2d5d2583273e025b45c02651fef47679,
which will be included in the 3.12 release.

Workarounds
Enable the fs.protected_symlinks and fs.protected_hardlinks sysctl settings.
Only run fixfiles relabel at boot using autorelabel before any
untrusted users/processes can run.

References
https://access.redhat.com/security/cve/cve-2026-19079
