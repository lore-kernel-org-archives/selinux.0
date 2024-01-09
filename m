Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A343D574
	for <selinux@vger.kernel.org>; Tue,  9 Jan 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VjL50jv8"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 130B920B3CC1
	for <selinux@vger.kernel.org>; Tue,  9 Jan 2024 12:19:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 130B920B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704831574;
	bh=lMoNIdSaIVi3p41jbQtluHBctPWsNNAYoXtAmLoBLwA=;
	h=Date:To:From:Subject:From;
	b=VjL50jv8Gn16+gX/NNnT3YKQAvgvQvvi1biOLhPdKmgyHY2/1LKTK3DJUyzGFP4ny
	 27liDPquiRuLVsOXMOgWKgsDf14hESlE7zRPyYiL3zW7Drzu6AdCt37m3TaTZc0ZR8
	 5DVPcQaf9IcPhWUA2z6NJFy0euuJwFqc5L+TLn1o=
Message-ID: <85ce5cee-4af1-4443-b627-973d55388c08@linux.microsoft.com>
Date: Tue, 9 Jan 2024 15:19:26 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: SElinux list <selinux@vger.kernel.org>
From: Daniel Burgener <dburgener@linux.microsoft.com>
Subject: ANN: SELint 1.5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The 1.5 version of SELint is now available at:

https://github.com/SELinuxProject/selint/releases

A big thank you to everyone who contributed to this release.

The major changes since 1.4 are:

### Changed
- Checks about requires now support userspace classperm requires
- Various CI improvements
- Clearer message for W-011

### Fixed
- Support quoted genfscon paths
- Compile with gcc 14
