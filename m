Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB931691D
	for <selinux@vger.kernel.org>; Wed, 29 Oct 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772725; cv=none; b=rOr/yHunXvu0CUAS1fEc3v7a8v2VJoni55R2Tu88ku+bTbMJ5doGbztCVa+FMPc1QepaqB/Psz63i4NBzJ6OnyyztX/ALVt+bHw34ZDBfrxUuu44Y+dVCDgoQQupVPcfkE+QJIAFZbo51Fex70jRPg5xRC7YQDnCUahK6KtVGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772725; c=relaxed/simple;
	bh=3OZbeBpwRNl4Wf8UX7JzKMjyzQfsduuaPQJgmUcOmcc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WNycym7FSUE+H5KQEv+sIpQw6klSQ0vmQ7VCKdT9r17mSOJ/knIj6p7DzOWeKbPyrggXgWIK/qtvfe6/i5YxozclBdBXL5X3Bx1dHiNGmetve7YSikh7rSNixpvZlJpyvYXnP+VYAhnrlinxaAFGWjoct0Yyx+dyZg78oiyQ+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aNIKEO1M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aNIKEO1M"
Received: from [100.96.193.252] (unknown [52.177.6.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id 74E3E211CFA7
	for <selinux@vger.kernel.org>; Wed, 29 Oct 2025 14:18:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74E3E211CFA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761772723;
	bh=r6TwJTqJ7nfJrbSCLUsF+MRk+nwES9xzFBChFefJnMA=;
	h=Date:To:From:Subject:From;
	b=aNIKEO1MSVPoAg8IxubU+KKZh1z66mjZnvRPw0uvPvEyaVCihEf/bXYYXCEOvz46z
	 R2+xkj+M0xEDf6vif1qQBZVRD/f8q5bkjn/yfCFRyG0hF0/J8oXaq/Ckvva6BGi7kf
	 mXmHYxm9uthdwZA22LLivuVtJF03C8DU7PV/69Ks=
Message-ID: <9bf87e7a-17e7-4c74-bafd-885752dfe045@linux.microsoft.com>
Date: Wed, 29 Oct 2025 17:18:42 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: selinux@vger.kernel.org
From: Daniel Burgener <dburgener@linux.microsoft.com>
Subject: SELinux documentation repo licensing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Paul created a new repository for an SELinux project github pages: 
https://github.com/SELinuxProject/documentation

There's been a little discussion in the github issues about licensing 
for the repo: https://github.com/SELinuxProject/documentation/issues/1

Matching the Notebook license (GNU FDL) is one option, but I personally 
prefer the CC-BY license terms.  My thoughts are in the issue and 
reproduced below, but I wanted to highlight this on the list to see what 
other thoughts there were.

My github issues comment:

The SELinux Notebook currently makes use of the GNU FDL: 
https://github.com/SELinuxProject/selinux-notebook/blob/main/LICENSE

It's a rather lengthy copyleft license. I personally find some of the 
specific criticisms mentioned on wikipedia fairly compelling. Notably, 
the GNU FDL requires any modifications to be distributed under the same 
license. This seems stronger than the GPLv2 requirement that you merely 
release your own modifications under a compatible open source license. A 
consequence of this requirement is that it seems to me as though we 
cannot borrow language from the Notebook into other documentation (e.g. 
comments in source, or this repo) unless that documentation is under the 
GNU FDL.

Based on that concern, my personal preference would be to use something 
a bit more permissive (although that means both separate license 
standards for different SELinuxProject repos, and that the Notebook and 
this repo would not be compatible with each other).

Other open source documentation licenses we could choose from include 
the FreeBSD documentation license although the language there contains 
some FreeBSD specifics that make me hesitant to repurpose it elsewhere. 
Wikipedia mentions a "BSD documentation license" which strips out the 
FreeBSD specific parts but calls it "obscure". I can't find mentions of 
it outside of wikipedia and the one of its two citations that isn't a 
dead link.

Finally, Creative Commons seems like a fairly standard option. However, 
we have decisions to make, since we can specify different CC variants. 
Something like CC-BY gets us a more permissive MIT/BSD style license, 
CC-BY-SA would be similar to the GNU FDL (but of course mutually 
incompatible).

My initial preference personally is for the CC-BY, but I'm happy with 
whatever license the community chooses.

-Daniel
