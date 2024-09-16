Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60A13211F
	for <selinux@vger.kernel.org>; Mon, 16 Sep 2024 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511128; cv=none; b=KksR7XtNRVOPea/4BUw2/KPeu1VXPTZxfVfl4X4xvUN+N0NrxihxcMceI9F1fbP6t3MHSDHcgnWDUSjtzweQ7OxSegN74Rz6VZp7mjtcGqLbtRtdKOzvnnMtq8alXNZvWJz5p3zcpARLgF6r1eJNPZ6WWYKyzMH0hKYqRd64AI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511128; c=relaxed/simple;
	bh=WGnhnwGjpcOADEq3LBNGDELMizqIws6L+RdCPRTJ60o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YKTdfwmMG2eY++l0VTru84oehHVa7kmpkvN9kAAERDFblqDHe5+bSRWPy3Y9Dcs1zekkA7BWHbVA3vCLIMSYPIUOo1MQtKFsMnwlp1i0KFkLUrVMNN7ZnYxgwSVg4HsbJLjkMMOuBeP4SkJC4f9xMpPkTOeYJTj2JT/Cki0MKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=AqlqLSVX; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="AqlqLSVX"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9a3071c6bso177554585a.0
        for <selinux@vger.kernel.org>; Mon, 16 Sep 2024 11:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1726511125; x=1727115925; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nmE6zAsmlDBdsmPX9aIv/hiOjgur9O5aLZp83WhwuM=;
        b=AqlqLSVXImXPBlstNbQ+Eeh4ZBOEc6Rxxcesn94fGypGmW6aqVy6tSW8j6Ub9et3cA
         qBXNXZV3/3y6KbXSlyIZX8Pft36ugNk1mE00jedkTQa8D+dZSVfovS8gdv1JTeutZDnP
         TaVPIVoN7Mxa3gYy4tvD42ku7fXoqMCapZ3VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726511125; x=1727115925;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1nmE6zAsmlDBdsmPX9aIv/hiOjgur9O5aLZp83WhwuM=;
        b=V/iABpRorAEqHk3DZ41tetjYA/uM8cPrEaAQY9KkHrR3ibATsQBwY/xdMZX49Cx7lt
         sK9422a4T5NxOBkcTxv4y9LN0TBqRVn30KMGSj0vyZme5LLEakR4g8xFAraJ4LZblqLd
         hZXaZZ5+/+xpP03B2a/1fzPOR/IOzdDblGJd02MY6D1o5Fg5y15OHX5DLs1yQIv57PBK
         oImW+uoGjVCBulxxRy5S4FDIIu/sWO3paHypPJhjWKrwy/HZMFW8R9XT1G7tOAHiY2uD
         a9WIKj62UWh8VlkeShY5WdoWeMbEZN7jnexnSIqkDpyzTxcrLhLbmIa3rDWm06dPIzC2
         659A==
X-Gm-Message-State: AOJu0YwyvgDE6TzJN2QXpG6i176zbNcLLK18BEB++ebDPmoJ2xc0hO9S
	JX0v0sIJvrM6cKDgb2h2Gtk04oVeFQr+xbdLp7UWIOFCPNxX79tiMedcCBt0Uj+R0oHh+eUjkzY
	wcOVThbMTYzC83fCTwyeF8VWH/qH1y8+5+ufv42ycgRt3/vHJzv7CIA9Ci3BCWcclcCkGKzY5UC
	QwNQ9NEedBjjrHnIQeI6wfHVtQwh/tm/5eBvA=
X-Google-Smtp-Source: AGHT+IF1O9YftBXzPA2UHEGHgGr4cffLEeWQkAqoPTGOxv68Cr6CnWZpyXyh4fsbBeIzv5X/bnaL/g==
X-Received: by 2002:a05:620a:24c2:b0:7a9:db7d:11e6 with SMTP id af79cd13be357-7ab30da30b7mr2109258785a.48.1726511124709;
        Mon, 16 Sep 2024 11:25:24 -0700 (PDT)
Received: from ?IPV6:2601:145:c200:2c70:6cfb:bea4:338a:db5a? ([2601:145:c200:2c70:6cfb:bea4:338a:db5a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e97be96sm279170085a.30.2024.09.16.11.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 11:25:24 -0700 (PDT)
Message-ID: <4078cdda-c3ad-4c9b-80f5-031b5f211a9c@ieee.org>
Date: Mon, 16 Sep 2024 14:25:22 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: SElinux mailing list <selinux@vger.kernel.org>,
 SELinux Reference Policy mailing list <selinux-refpolicy@vger.kernel.org>
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20240916
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new release of SELinux Reference Policy is available:

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20240916

Notable Changes
* Added sechecker configuration for GitHub CI actions.
* Cleaned up concerning permissions uncovered by sechecker
* Removed extremely deprecated domains in cups (ptal) and xen (xend/xm)
* Systemd updates up to v256
* Various container fixes

New Modules
* haproxy

Full Changelog:
https://github.com/SELinuxProject/refpolicy/compare/RELEASE_2_20240226...RELEASE_2_20240916

-- 
Chris PeBenito

