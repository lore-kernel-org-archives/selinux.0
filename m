Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E3247291
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679921; cv=none; b=gGtsijmNwuIjRoZpcmxtsmGY4KrPfhVO1OYXjxKAhrECG8Vc3ahIfDltbLyH2VV4E4xESG8e1n/U1sF9b7dyWTGhTQq4cvd/EynfqPn7VnIPMM6kLA+TKWp1YrGWErBIbhI66LfUzGrUNxKFQofQyPwqzVO88I0/m3nysieI+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679921; c=relaxed/simple;
	bh=H/ceC/OAs6UtlGfW8UDVRmho1yn3ReEUCH1tf1/pnGI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=b3hrPL+ZdG6q7koRCOYzJwamFqnhxqbWhP20KqRoY6hmmf0m6YmgfRS7UHhcBDdUrAcwrLPKLi/LhOjrrNLy77W7F5oMD7n7ZQWpY03NZvgyGAxo1VFEzkIq952VG+wHl5+apma+ou8Tovf0DFGizqNOtWu/sJlTzG3oGw1I9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SBWNfUzf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SBWNfUzf"
Received: from [100.96.64.95] (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8BE6B20B716B
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 10:18:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8BE6B20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780679904;
	bh=Ug/Hp5ZTCuuoS18kGZ5DAqdx4xoW914HsWMBidZohWo=;
	h=Date:From:Subject:To:From;
	b=SBWNfUzfzne0szBcfkcDS7WNjS1xK5oDek501rBYALOQZobrX1gmVRubA5mZOTPvI
	 N5hqxicWex+FQw3uHaOcessOn3R4m0uOpAc1W5WNxrJkyHEfSn01wDkjH941fSRfn8
	 xvl4awN1Tlj/92pX2e55a+hYcPjG0L3+29J5EI3s=
Message-ID: <75502c2c-4d9a-4fac-8f12-4052ed32a0d8@linux.microsoft.com>
Date: Fri, 5 Jun 2026 13:18:26 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Chris PeBenito <chpebeni@linux.microsoft.com>
Subject: [PATCH 0/3] ci: Refactor build into a custom GH action.
To: SELinux mailing list <selinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch set refactors the build step into a custom GH action.  This 
allows other projects (refpolicy, setools, etc.) to reuse these steps in 
their CI pipelines.

Example run with this set:
https://github.com/pebenito/selinux/actions/runs/27028226461


For an example use, I've made this change in the SETools CI pipeline. 
Then the SETools build that is part of the refpolicy CI simply calls 
SETools's build action:

https://github.com/SELinuxProject/refpolicy/blob/28ee79d5c811c75fb5ebef9d2c566f58a7c53cc2/.github/workflows/build-setools.yml#L56-L64



--
Chris PeBenito
