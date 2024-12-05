Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958E82C60
	for <selinux@vger.kernel.org>; Thu,  5 Dec 2024 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427833; cv=none; b=eN84CGXK2jrimBBu4Vv1mS7kPuvUhdhpy4VCI0XNj5+fNytE5P9Jk6aobFK1Q8Pgy7YtxsKNXx6S5s+YQIPGD7chJNplkGvQu8SBQq0ATTeA9y4zII7sl9K5quXtTIvIuQ9Um5jGil6uBhgzH2rm6+aenUT2jJA+Gr/1O1s+u48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427833; c=relaxed/simple;
	bh=QBhyypICwAVspu4GGNPbszMAYjwvUxt84/mz/077kBQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=naHtXsx5kZxOmBYk6I+P+lKINea6KXNrn4YyZTC+1zFm/uxzVTV8d/VUtNcbnIfKqGDtMbrqVFm45ZW/p5d2PSLE/jyAB7lvbnueMpcDRno5TnfICIiThYtVZntVIgUhsGKWV9+1Esz0IywBBtxyqQdivl8e5NNEEpAvGofmBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c1jRsvCn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c1jRsvCn"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D67020BCAD0;
	Thu,  5 Dec 2024 11:34:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D67020BCAD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733427277;
	bh=qO2j0+VSVXAwtPkudJZDr/hZCndduBnBusNiwVx8Nuk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=c1jRsvCnnvVCDMd7BzI5QlzAglD4WhYIRvc/UYmDpyQtUiwxH3+I4689Gmm9n3njU
	 26cEoet7SC7739aKdveKc3/wdE5zVciAA9scOz10do6oKWsJWwwgL1Xzjq4AEt7YiZ
	 NXGSja0Pnc2DRS/Zr5vhoA2nwl1V43rWaJsjBkTw=
Message-ID: <3d839c02-913e-4900-bba3-02a3beb116a7@linux.microsoft.com>
Date: Thu, 5 Dec 2024 14:34:34 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Systemd socket labeling issue
From: Daniel Burgener <dburgener@linux.microsoft.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, pebenito@ieee.org, masheets@microsoft.com,
 luca.boccassi@microsoft.com, lpoettering@microsoft.com, jmorris@namei.org
References: <b9852970-71fd-4a44-b428-537a3f0fc381@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <b9852970-71fd-4a44-b428-537a3f0fc381@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> * Reading the expected binary label from the file_contexts would avoid 
> the timing issue, but assumes a system where the binary labels generally 
> match the file_contexts

I had some off-list conversations with a few people and there seemed to 
be a lot of interest in this idea, particularly as a fallback if the 
binary label is not available.  The approach would be:

* If the binary label is available, use that
* If the binary label is unavailable, use the expected label from the 
file_contexts based on the ExecStart= path (using selabel_lookup())

This would potentially have drawbacks for systems where binaries are 
moved around or typically expected to not match file_contexts.

It might also cause challenges troubleshooting why systemd used a 
particular socket label ("Did it read off the binary or the 
file_contexts?"), and a last potential problem I'm aware of is this 
systemd bug:

https://github.com/systemd/systemd/issues/30560

Currently finding binaries does not support systemd $PATH resolution. 
Determining which field from the PATH to use in the file_context lookup 
could be tricky.  Typically many possible fields would return a valid 
context (possibly something generic like default_t or bin_t in typical 
policies).  There's not a clear way for systemd to prioritize one label 
over another, since the actual binary may not exist yet, so we don't 
know which path we will ultimately find it at.

Those are the problems I'm aware of.  The first two may not be real 
problems in practice.  My questions to the community are:

1. Are the first two problems (binary labels expected to differ from 
file_contexts, and troubleshooting systemd labeling) real problems for 
people?
2. Are there suggestions on how to handle the PATH lookup problem in a 
sane way if we go down the selabel_lookup() route?

-Daniel
