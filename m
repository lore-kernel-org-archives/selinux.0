Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5C33AD8D
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719260; cv=none; b=Row5weOj3sSGQ+x/oj1DkspNSNtntElfPVsfbgOPUedrzmtdbto2xWzAbOqYTgJXrpVbvlYnanuQxM2DDDUiO3nXvXru1yIPQVsiTkN9XQj4bG/JD2RscMdPUbMCDCvPRhbUVqkXNa76rtsVxUBJ9swIuJEUUWQoygtzjaf6sUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719260; c=relaxed/simple;
	bh=fcwOBAPMDYyJ0zZKeVKMRfO0wG9t3fu3+nPpD1ZZBfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pJjKctZJ02RYIiiYv/nvdrG8j6zmmau8kzSYLJBovvj/MZ3ISm6KnL6rL0uUuGqre+MHsjsMuQZ2DJ0JQKe3WFt7hxnPLwGR/KML5A/Aj7s++FeNB7iYKNI9J4sfo+N70f5LJpmbFYfIYhcFyw6cS+eaHDRXCXB9T2sjWxENleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=aihigCoy; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="aihigCoy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1767718885;
	bh=fcwOBAPMDYyJ0zZKeVKMRfO0wG9t3fu3+nPpD1ZZBfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aihigCoyZfLZanMcPNC6QclF4magcn6ECAzlQYqg+KWIifaf2vcla9jhb5Ps3Yi2i
	 mHpjA37tY5c+wqStwSDmZFf/uopRuE3YlFhBGYKEJkfC2exp5fl1ztp/3nDzkuhbOi
	 Q01Z3xW1f38R2RIUA+EtyesHGwmnG4gt7kbaDDWQ=
Received: from debian (debian.lan [IPv6:2a10:3781:2099::87a])
	by markus.defensec.nl (Postfix) with ESMTPSA id 46A8F240258;
	Tue, 06 Jan 2026 18:01:25 +0100 (CET)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: SELinux mailing list <selinux@vger.kernel.org>
Subject: Re: RFC systemd-sysext/confext image context mounts
In-Reply-To: <65a70099-a752-42d5-adfc-5973c21b9710@linux.microsoft.com> (Chris
	PeBenito's message of "Tue, 6 Jan 2026 11:01:13 -0500")
References: <65a70099-a752-42d5-adfc-5973c21b9710@linux.microsoft.com>
Date: Tue, 06 Jan 2026 18:01:24 +0100
Message-ID: <87o6n6iskb.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Chris PeBenito <chpebeni@linux.microsoft.com> writes:

> Systemd provides tools for composing directories like /usr and /opt
> (system extensions, sysext) or /etc (configuration extensions,
> confext).   These tools create an overlayfs at the target location,
> with the root filesystem and extensions.  While they support raw
> directories, files, and mutable filesystems, my current concern is
> with extending immutable distributions at runtime using additional
> immutable images.
>
> The challenge lies in ensuring proper labeling before deploying an
> image, which is problematic for third-party images lacking labels or
> using incompatible ones.  I haven't made any patches yet, as I want to
> consult this group and the systemd developers first.  My proposal is:
> for internally labeled filesystems (ext4, etc.), have the tools
> validate the image's root directory label.  If validation fails, apply

Sounds fragile as these filesystems by definition have more then just a
root directory.

> a context= mount using the label from the contexts/systemd_contexts
> file in the policy.  I'd probably also add options in sysext.conf(.d)
> and confext.conf(.d) to override this behavior, such as for specifying
> an alternate label for the context mount.
>
> What are your thoughts?

I am not opposed per se but feels inconsistent. Consider for
example verity authentication which will also most likely be used in
these types of scenarios: why would one be able to deal with verity but
not with selinux labels?

Also wondering where systemd is going to go with extensions will we get
per-user instances that work together with systemd-mountfsd like we
currently have with systemd-nspawn? If so how will that affect this design.

>
>
> --
> Chris PeBenito
>

-- 
gpg --auto-key-locate clear,nodefault,wkd --locate-external-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
