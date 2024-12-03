Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C41E3DED
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259550; cv=none; b=HiZLXb751rI9RoH1fb6tuKFxPPpfuGcsIwqYJOySmDtn7kQ1wgWrVzks0/K/EFTDQW0k99R1iCqJWKCqVOIY9Pbh4PuQCVSrd0R39MIyQigY4tuqI9F1FeUKYLxKOIbqs8MzVzSB+7zXsby20OiZQQ9pFKnu7LJsaFmC133nidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259550; c=relaxed/simple;
	bh=PgJPLuTyCLM6uZruzM6uykOtjWDFmpPyNqk5HlEpxro=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=jDXDV61IAllQDRvC0jmjLbkn5LK260viIBMYoslitrMd/axgckXfPoyLjJCpNZV+4llccGFNVq8JyrApfu7mJLsajoK7R5aHzcxYCYEJYbiTFz5LP+4sLBCcX1WsWtWE1acSxXdjiYqwLV6/EG0vaF/TbbTPH/luZT3x6epsfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NDqqSbdk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NDqqSbdk"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5ECBC20BCADD;
	Tue,  3 Dec 2024 12:59:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ECBC20BCADD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733259548;
	bh=b/hrT39QHimlVRBa9CU3wzPEsi3YfnnmsqEwlo7uCY0=;
	h=Date:To:From:Subject:Cc:From;
	b=NDqqSbdkkvZtAyxmeQzjw1b9cRaN00IvHPG9tgzW51o+An5X7j3H2S2+MWYBOggnQ
	 lLM1zn3eVdT2NLZc+hInvtsDjd+xG5zS4uV7yIDju3aK9MIJyKBehTD/V/CTz6D27f
	 yO8rBufVJ+5Qos9AghIN2Mt/XDtAFbC8dg49OQN4=
Message-ID: <b9852970-71fd-4a44-b428-537a3f0fc381@linux.microsoft.com>
Date: Tue, 3 Dec 2024 15:59:05 -0500
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
Subject: Systemd socket labeling issue
Cc: paul@paul-moore.com, pebenito@ieee.org, masheets@microsoft.com,
 luca.boccassi@microsoft.com, lpoettering@microsoft.com, jmorris@namei.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

We've recently noticed an issue with how systemd handles SELinux 
labeling for sockets.

In the common case, systemd checks the label of the binary it expects to 
execute, then calls security_compute_create_raw() to determine the label 
of the process it will create, and applies that label to the socket 
using setsockcreatecon().  This makes sense as it matches the label the 
socket would get if the process created it itself.

However, when certain systemd directives are set, such as RootImage= or 
ExtensionImage=, systemd simply skips the above behavior and creates 
sockets without any special labeling handling, so they inherit the label 
of systemd (typically init_t):

https://github.com/systemd/systemd/blob/13a42b776db9f4bd1e827091b6640801c54304e0/src/core/service.c#L5483-L5486

The result is that socket labels end up either with the label or the 
process or the label of systemd, based on unrelated systemd directive 
changes.  Additionally, the init_t label prevents policy authors from 
controlling access granularly on these sockets.

On most upstream policies this ends up working functionally.  Fedora 
added a "temporary" workaround to allow the init_t access for all init_t 
daemons back in 2010 and never removed it:

https://github.com/fedora-selinux/selinux-policy/blob/8dfcddb1f7227bbdf98776f795be53cf50734b04/policy/modules/system/init.te#L604-L605

That workaround accidentally got pulled into refpolicy in a large block 
of systemd changes back in 2017:

https://github.com/SELinuxProject/refpolicy/blob/6e54a2eda6f493c585a3fc59e8ddc54f341dbf0c/policy/modules/system/init.te#L1600-L1601

So in practice a lot of upstream policies are allowing access either 
way, preventing functional issues.

We've spoken with a few systemd maintainers internally and they have 
indicated that there is a fundamental timing issue with the current 
approach - there are use cases where the socket must be available prior 
to the image that contains the binary, so determining the label of the 
binary prior to socket creation is impossible.

* The current approach of applying the label of the resulting process 
seems impossible to do in all cases from a systemd perspective
* Reading the expected binary label from the file_contexts would avoid 
the timing issue, but assumes a system where the binary labels generally 
match the file_contexts
* Inheriting the init_t label prevents security enforcement across 
different systemd created sockets, and conflates IPC with systemd with 
IPC with systemd spawned processes
* Setting some other static label for all sockets avoids the conflation 
between systemd and its children, but not between various children
* Checking the file_contexts for the path of the socket makes a lot of 
sense in the case where sockets have paths, but systemd supports 
creating sockets without paths such as abstract unix sockets (for example)
* Using the SELinuxContext= systemd directive causes systemd to use that 
label for the resulting process (and therefore socket), so it skips 
checking the binary and socket labeling works.  However, this scatters 
policy details across unit files, and doesn't permit decoupling unit 
files and policy.  Not to mention that it's unintuitive to expect anyone 
to know that when they use RootImage= or ExtensionImage= they must also 
use SELinuxContext= or their sockets will be mislabeled.

We're curious for the communities thoughts here.  Any ideas or 
suggestions for how we might address this situation?

-Daniel
