Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046DC30C60F
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242775; cv=none; b=TIRcMZlDohO1lCUo5JLj4ZqevGevBdR7g8ckDZIWF9Ef4viMvWkIqp08jaH6LYolBhOlt3YiSTNUgPJULv7B0XiiLeECskh9p5uUet1XhHvDOMr3FOGhkUk/PzyThVaDxBH7r/xK3sdLZwu/+uWREF52f3xku1WL7OW6zFU/LWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242775; c=relaxed/simple;
	bh=CWoWtCK3c9785hMi/jDZxcueoqyj/egNAy7pz+jgfVw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MQtPNeLFEC9hJ1WTPXdMwIorQUWR3U9vscrGeatsRKS9uyVNtID7fw+ReR7tCZ43wW2d+gljoxPQhDKLohJogmD60FAaVcPSsrr0nihgHFkhViF25z4+HHvo6NTy0mFeOU56ASqZDWSR0JMH0v7s9dYoh+TI6RuosNwGSYasER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=PumQWwH3; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="PumQWwH3"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9159f631656so29571885a.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1782242772; x=1782847572; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZqtuW9VmqEj/gq5Zz8J1BqvpHtegtltKhzCdUF7t14=;
        b=PumQWwH3NK/SxjhwzMnXJr2kfrK8im/LvWWQeaSxb2yeAHLjJRYQekFL42EkEUYBMn
         0rOXDb5+j0cWzduxY5i9SftuXOwK5Z0bCH/NjkyqX1rcHD6g6qg28HlzF3hteTvsj+ra
         c0wisELySmYwd/cigvXGmVTMk7r+2I2FXs6/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782242772; x=1782847572;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZqtuW9VmqEj/gq5Zz8J1BqvpHtegtltKhzCdUF7t14=;
        b=S0+SNwOqEta6VWgUlgt/KCvA9/FiD+m10PNX4sKCJiJUlf0ht/abmiT+W+IJyy/VI1
         xMSNFNq3T4pQxvISJE1L/3RV+5SkBbIPEIo0CtrKfJgtZPm4+zodQ1PRnznVh6xXEPPQ
         mHwArkuvcHl2VkqTQW1ep/1FmwilNfk4O9ZxFKF/TuRCJonyRvQYdkkCBflD3JP+qohD
         NkKlT8ZShFL2zWk2cmY5BN54JhdoW/sERfyAKc8A7ciu7hoqBBTOiFJugZPcAM9LDOFS
         KfkLYu8ifhqVBcUW6ji8gP1hb1Bhamc1ED1S2UJmOOzOLE+xcNkm/mwuZcID0TKFw0it
         dO0g==
X-Gm-Message-State: AOJu0Yz/1WcK8b1pttIqcXoWhPYNQrFZELYBBc5iwQKiLmp2215SF0ep
	lPncJmngwbMHcl5VMINh7NUXZc580YimJ1QujTXCGZC23/o2wZ3cXuQuAgu4+rFE47r5+vuunpx
	T8j2jvIILeydjSQjmTay9nPNA4KkgVCPpsdlQYXkmlCLA1I9LgTiOPXZgx0o7A5nz4IwKTEp6iF
	rJIPCeGWzW6Ea05Rl/xxVj/c0IfEWor1u4Rh2I
X-Gm-Gg: AfdE7cnPb+h2+hhIhytbrnpgULqISXf0O6XSOIwQHa0pDmDn4BnPgX5Veyn5LWvxJtq
	5Me4u6vVCsYp8kl0Ac+zcMUoWDCxlr5wSsqjaBadZGldBLyalZvBS2/qEVy5vTDBVngCkOgS6zK
	eU0SwO0qHF2F5xkHHLNTJLJCSll+Sn5IDMjO2t8lvIO3UTYlWm1kkeWj86pfSQcqm52xclyh5aa
	m5Mi5iR2I/tMUF+dF9Q9x4Qh+XYoVcYwqt9biKi7BFYf6wYtKKn3LAbTJ7tucuXZy18DdUxjoXU
	bch01bO7LmaPoQEe0eDnbnC5uUDipDAkQPXC0CGOlY0uVsKCDWRZk7pUEXp3fMRdmlF5kAVTvst
	+legBfdJ3R0sXWlP63ohfbxyjZATGnjGy/XmxKAwCCod74V8+LUVJ0lGVcbIeGmKixEcTMehWBI
	oTRfneZKwJy9BcUPIMGx5AmqsERRb+YhxZz2EAYLx7gRXtKZONNASOhA==
X-Received: by 2002:a05:620a:400d:b0:921:6c44:31cd with SMTP id af79cd13be357-925ffbe20afmr746791885a.3.1782242771887;
        Tue, 23 Jun 2026 12:26:11 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:71bd:20d:33ea:4d98? ([2601:145:c282:5650:71bd:20d:33ea:4d98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000bf21asm352798785a.27.2026.06.23.12.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 12:26:11 -0700 (PDT)
Message-ID: <af87ad78-7edf-465c-9914-2e7b3b646dff@ieee.org>
Date: Tue, 23 Jun 2026 15:26:10 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
From: "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: ANN: SETools 4.7.0
Autocrypt: addr=pebenito@ieee.org; keydata=
 xjMEZuhGfhYJKwYBBAHaRw8BAQdADz/tF/gexoZlGld9hGmv5HXcHP95b15YoRSbsznX8EHN
 K0NocmlzdG9waGVyIEouIFBlQmVuaXRvIDxwZWJlbml0b0BpZWVlLm9yZz7CmQQTFgoAQQUJ
 Bi93EgULCQgHAwUVCgkICwUWAwIBAAIeBQIXgAIZARYhBMTGKxZwwt8zFEjyhsY2PvHJaXsU
 BQJm+wuYAhsDAAoJEMY2PvHJaXsUENsBAO8TrrQXhCKCpNQUWvDto13w55ofDKHA3SVlCtzP
 zzzhAQCvGb8h5fPcw5eTjgLZbXAAG95uMtxYZzs66FNorxUVCM44BGboSckSCisGAQQBl1UB
 BQEBB0DUELErM3F1hWb3j/Wm3vDku3kdA2YVLxZtonOkF6XOUgMBCAfCfgQYFgoAJhYhBMTG
 KxZwwt8zFEjyhsY2PvHJaXsUBQJm6EnJAhsMBQkDwmcAAAoJEMY2PvHJaXsU+x4BAMeSfc01
 SUt1eNtWAEj/caCS4ako0iZd7QZT8recX3zfAP0crszn37KtEaiHb5vHy38tym3+cSzDzvb8
 +9wp84UkAg==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

A new release of SETools is available:

https://github.com/SELinuxProject/setools/releases/tag/4.7.0

Notable Changes:
  * Add MCP server to provide LLMs the ability to analyze policy.
  * The source distribution is now a Python sdist and can be installed 
using pip.

Note:
Since the source distribution is Python sdist, the policyrep C extension 
is already cythonized. Cython is not needed unless you want to 
regenerate the C code. However, because of the generated code, the 
source distribution is much larger.

Full changeset:
https://github.com/SELinuxProject/setools/compare/4.6.0...4.7.0


-- 
Chris PeBenito

