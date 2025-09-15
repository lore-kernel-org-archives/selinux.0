Received: from sender-op-o14.zoho.eu (sender-op-o14.zoho.eu [136.143.169.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAE2C21EB
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958967; cv=pass; b=bKdnzegpPmnFSVMhD55CJ12MeNYusX2Wa7tR8+NK9yMpgayT/SiQnj072xzRTsDbELUoyni8ft6HeZh7xWYiz4uOHh67JvjhRnjjAURNmOXZEaMUwg2JIKD5vUyg+8K1Ae4hj/DcIqE12FU9I1yA7GtdDN3r52fa5sl8/Z+jRtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958967; c=relaxed/simple;
	bh=ElN1QtZbTcBA2Su5P/vWJsoqiZqBeV/EdBSJ7faLoAk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=axT5AN7KX2DZmstikQFjeghN3PA04nRexC0ojuInzZJvMpLYB0riGKghFYkOMvxUKbTHvR4Yz/+CymdEYIjBxqJr5sApLP4u3iwBTt8LkfQ3kHRDk4+XteGBC/3UvosCiQZp1epgQzt4NFs+PVnrSSRVwLWw6fcSpGxQq3N68mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penurio.us; spf=pass smtp.mailfrom=penurio.us; arc=pass smtp.client-ip=136.143.169.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penurio.us
ARC-Seal: i=1; a=rsa-sha256; t=1757958952; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fcGX92gRZKm1+7Hao4xdHNJ+GOPyZEz3mye7mjuyx9Pti3+N9SaRQIjOcL5BjSHTJG3K7OMMSTYM7OTZY8uv4gZLkwzVzhi+N+ceadwZgyHobfC8Dx9s2Pyji/uhkQY6miuBvi8DsVW30XN+Hh9QlOy2C0h88KGS+wyFDvwk2tM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1757958952; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=faEVgbCIMFWsJ51Ncz5eGF2FlCfzbLxLwiKtKwaDy7o=; 
	b=P+EIIxVvKbcUA8BpkwynxjaHU9cnbUZh2S66g6OulrziYPSdAXIuPH7SVQx8WILBvyuhoXghr6TvemNnc8ke7VRjdp+JB35NjUwsZIWJFlKGTxJGmBpDCcDisMFw6P3bcRL8bvhECY0uPE5GiJrBotu6uSTfiBATtV4n8OfqVuY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	spf=pass  smtp.mailfrom=ian@penurio.us;
	dmarc=pass header.from=<ian@penurio.us>
Received: by mx.zoho.eu with SMTPS id 1757958950044968.2923864135047;
	Mon, 15 Sep 2025 19:55:50 +0200 (CEST)
Message-ID: <7a27eed6-9554-4f6a-9f2f-2cb1efc522fb@penurio.us>
Date: Mon, 15 Sep 2025 12:55:48 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: SElinux list <selinux@vger.kernel.org>
From: Ian Pilcher <ian@penurio.us>
Subject: Lack of official hosted macro documentation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

TL;DR - Writing policy modules is harder than it needs to be, because
the documentation for the macros/interfaces in the reference policy is
not easily discoverable.  This could be helped by hosting the generated
HTML documentation in a location that would be indexed/processed by
search engines and AI chatbots.

Over the weekend, I wrote a policy module that allows a containerized
service (running as container_t) to access shared content
(public_content_t and/or public_content_rw_t).

> policy_module(container-public-content, 0)
> 
> require {
> 	type container_t;
> };
> 
> bool container_read_public_content false;
> if container_read_public_content {
> 	miscfiles_read_public_files(container_t)
> }
> 
> bool container_manage_public_content false;
> if container_manage_public_content {
> 	miscfiles_manage_public_files(container_t)
> }

In the end, it turned out to be extremely simple, but it took me most of
a day to do this, because it took me that long to figure out the names
of the macros that I should be using.  I finally discovered the
miscfiles_read_public_files and miscfiles_manage_public_files in the
apache.te source file, but that was only after I wasted several hours
asking search engines and AI chatbots what macro I should use for this
purpose.

I was pretty sure that macros like these had to exist, but I was never
able to discover them through Google searches, Google Gemini, or
ChatGPT.  (Google Gemini hallucinated a non-existent fs_read_access
macro; ChatGPT did a bit better and referred me to
files_read_public_content, which was real, but has been removed.)

 From my POV, the problem is that documentation of the macros and
interfaces in the reference policy is *reference* documentation, which
is helpful if one needs the details of a known thing, but isn't helpful
in actually identifying what thing one should use to accomplish a given
task.

Fortunately, search engines and AIs have become pretty darn good at
processing reference-style documentation and answering "what should I
use to do this thing?" type questions (occasional hallucinations aside).
But this only works if said reference documentation is available for the
search engine/AI to index/process.  AFAICT, the generated HTML docs are
not available online anywhere (at least not anywhere that seems remotely
official).

It feels like having this documentation hosted in a place where it is
visible to these tools and given the appropriate weight (i.e. not just
a copy of the docs on Joe Rando's web site) would go a long way toward
making these macros more discoverable, which would make it much easier
for policy authors to use them.

Thanks for reading my screed.  :-)

-- 
========================================================================
Google                                      Where SkyNet meets Idiocracy
========================================================================

