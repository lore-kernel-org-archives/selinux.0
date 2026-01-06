Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253A9EEA8
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715362; cv=none; b=Xp602e5uuKEOcRCRSbu2R/+Z0PAQlK6uBHAfdkjFd3xg76MXW9vsX8nqaozuxyBjrWw0p9L/17vjv0y/hvon6zTDqvobWSm28Exl1646Sqaoc0N5Tomu31UinHOYCdcC14HHhgBZhjtDOp0F6IP5yWCUKDwpzsp+AygctG5N5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715362; c=relaxed/simple;
	bh=av8l6/2OfuqzpXMDWXV/3fANhQVGEXJthxjZMX7IhbA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=g+4HrIqUzfPs2AnGtMaVVySN5Fuhe6qBKGhVfaUNoofTGoL1oTznkY+sAkBw1H9ArR3/6AwQh3MfzMFZToZ4QefyzgIU8/fp4hgQJwFu2euPSnA9JQEYZCAV4vDaRxFwqvcG7+4DXarNDxQalPHLf0AKTdtuFApq/1dFL2HiAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hf3GIgXQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hf3GIgXQ"
Received: from [192.168.254.48] (c-69-251-182-238.hsd1.md.comcast.net [69.251.182.238])
	by linux.microsoft.com (Postfix) with ESMTPSA id 45CE32016FED
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 08:02:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45CE32016FED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767715360;
	bh=pdj2QsxVvMq+F0nhqGYK6hhn5JmHXMMajgAWh3HZLFc=;
	h=Date:From:Subject:To:From;
	b=Hf3GIgXQb4Bkvfn7GmJtUfaptNjxy9EXY+ySVcCHmWNYZrqYlRdRryJU2nP1wB5q2
	 zXAGBmPzNmE0u1taU1oPvdOf+gtACh+H94nwy44sYTigXqxzw2vcQ+szb3PJKAI0UI
	 hPpQUjRILzCRyA6Eav9K4mt7avcQhEKshn8oJ3Jg=
Message-ID: <65a70099-a752-42d5-adfc-5973c21b9710@linux.microsoft.com>
Date: Tue, 6 Jan 2026 11:01:13 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Chris PeBenito <chpebeni@linux.microsoft.com>
Subject: RFC systemd-sysext/confext image context mounts
To: SELinux mailing list <selinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Systemd provides tools for composing directories like /usr and /opt 
(system extensions, sysext) or /etc (configuration extensions, confext). 
  These tools create an overlayfs at the target location, with the root 
filesystem and extensions.  While they support raw directories, files, 
and mutable filesystems, my current concern is with extending immutable 
distributions at runtime using additional immutable images.

The challenge lies in ensuring proper labeling before deploying an 
image, which is problematic for third-party images lacking labels or 
using incompatible ones.  I haven't made any patches yet, as I want to 
consult this group and the systemd developers first.  My proposal is: 
for internally labeled filesystems (ext4, etc.), have the tools validate 
the image's root directory label.  If validation fails, apply a context= 
mount using the label from the contexts/systemd_contexts file in the 
policy.  I'd probably also add options in sysext.conf(.d) and 
confext.conf(.d) to override this behavior, such as for specifying an 
alternate label for the context mount.

What are your thoughts?


--
Chris PeBenito
