Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC391F9ABC
	for <selinux@vger.kernel.org>; Wed,  6 Nov 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906486; cv=none; b=cljMNeV1na4fRoN1rC9YGSVM+OIHW55tq+Mr9OBrg0CI7+CbT8B9iTHvfgsGMSLl0AJKeWt1sNHEBVI3RrDp944fS8f2Rxk28+sbu9kfRK/5gQYJgaZd9p3W/j2qR7ZmnFP6Eu6p5OkY78vD/5paYp7mZbTZ8vJ92wNtiGrfORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906486; c=relaxed/simple;
	bh=K+xXb6LaJyadnFV+3Pi7HJwnFKZwELqp71iVgaQ0g9Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GKjp7QXulJKggIcrvqvAzMPpGC60STvBvxDPoPr2rhC6+aUqwyO0eagkR6W8jreuKlVsx9bBZNg1cdLqgs12ZLFVj4k4t2gf+scGErsX02y3LlYGl7TrsQ68fAjYEcmO0tUF/WNQg9VLAeGhXfsr7bDgzXeYyyAwLOTaistYrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Kj2ej8e3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Kj2ej8e3"
Received: from [192.168.254.48] (c-73-86-61-56.hsd1.md.comcast.net [73.86.61.56])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B26D212BB9C;
	Wed,  6 Nov 2024 07:21:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B26D212BB9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730906478;
	bh=mXNcGxJAzgYd/I/dhKFo/vGixX34iVcqWizipMoYJxA=;
	h=Date:From:Subject:To:Cc:From;
	b=Kj2ej8e3fSrgBrI3JIKVt+ZQXs5t+HMEnOisyXNZLzMpuohd3UuUaOv/xgJs0MHSx
	 d29VD+l3z+ktzJSftzd1CPTGXeJPOh1rsUJ6RP3t2H6Uo5YZ9gkjmSrb/54haJCwV0
	 sspIsDCysBPI3kPOwsLLOQtzo56Q/jkd5mx5G6PA=
Message-ID: <34e77b6f-2c76-4bf9-8e3f-ac01047c952d@linux.microsoft.com>
Date: Wed, 6 Nov 2024 10:21:12 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Chris PeBenito <chpebeni@linux.microsoft.com>
Subject: RFC: Adding a dyntrans in systemd pid1's forking
To: SELinux mailing list <selinux@vger.kernel.org>
Cc: bluca@debian.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've recently become aware of systemd's credentials feature[1].  In a 
nutshell, the intent is to reduce privilege in units by systemd itself 
copying the credentials (crypto materials, passwords, though in practice 
it could be anything) and placing it in /run/credentials, with access 
managed by namespacing.  This is intended to eliminate the need for the 
daemon in the unit directly accessing the data.  My concern is the 
possibility of inadvertently leaking credentials or abuse.  i.e. putting in

LoadCredential=foobar:/etc/shadow

This illustrative, as systemd can't read shadow if it's confined, but 
you could replace shadow with a private key or any other highly 
confidential data systemd needs to access.  The common response to my 
concern is systemd units should be protected at high integrity; only 
root can modify them, etc.  However, I think we can do better to reduce 
the possibility of errors.

I've discussed this with one of the systemd maintainers, and I'm 
proposing this change:

1. pid1 forks (to pidN) to run the unit, as usual.
2. pidN does security_compute_create() using the current domain and the 
label of the unit to get a new domain.
3. pidN does setcon() to the new domain.
4. pidN runs the unit as per usual (including the credentials stuff)

Then we'd need to add something like this to the policy:

allow init_t httpd_initrc_t:process dyntransition;
type_transition init_t httpd_unit_t:process httpd_initrc_t;

I have not yet prototyped this, but based on my discussion with the 
systemd maintainers, this should be doable.  I believe the added benefit 
is we can decompose initrc_t's privilege and maybe even reduce init_t's 
privilege.

What are your thoughts?


[1] https://systemd.io/CREDENTIALS/

--
Chris
