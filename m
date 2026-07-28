Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92E3033E7
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261353; cv=none; b=pM4Ka3QJbfos3p2ViPIscdn2nCdhIOfkxEtIeiqE3t/U5qbhlGmHrRLYjIfNbx8lxTSapsupwr3Kj+U38737sLHeLoJTbVWuCzWQyIwfLrR+cv7jdpxkUAXPB46kyU6Wvc2fvQKq/CJ713c4+EiK/FK1Cyanq004zPUB9EYlx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261353; c=relaxed/simple;
	bh=YyGj2zmJuwxQeemTpcVpZIObthrYrhKiLChfPhe/UFI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=sOBvLvqADQN0kWWRMtg8RmeMJ6+5xQtVzT0jKbfMB2Lt1D5QdwBlNR+t65Bm1Bk721rk854F7M7V+RQZIxXJfbnoqBdq1QR5YtnFzp54lAU3Ag2eqCJihSGWdaGfZSddJ7z7XygJ6141XeJhYwXQxEYsnypymIpeHnAFOP615pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=QI4saaBq; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="QI4saaBq"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e6391b114so11756685a.3
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1785261350; x=1785866150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:autocrypt:content-language
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=37atQd1axkn9/JLp3G9iH/0pRCYp7k0hUATXKi+KlB4=;
        b=QI4saaBqLgTvPOhBrUZzn6SUPCp4sKaMRZIWlkdbUIOr4uj50ws0JZMJSSrjAEAU4G
         eAvET1Vjp1U05aws535MM/1kIuIdwDnfe9ZJE71iChe85gnXacM/f8lvC6jQrGIljXOM
         PYTokaookfSGMHlK80TREI5EByVaJlgK4yIC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785261350; x=1785866150;
        h=content-transfer-encoding:content-type:autocrypt:content-language
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37atQd1axkn9/JLp3G9iH/0pRCYp7k0hUATXKi+KlB4=;
        b=jr6U/tybMen7Uw9mrXrqVFj9AbgQzOepj8RTjogCEtHCrJoTZOIHwcLjHK6oczW1n7
         cbPr9DzvnyfVce+4a1C29s5DxohSO3j5zBPlad4aSpGTHDAIBa+ERmJwGvJLOEacyWAV
         opsSeimiklb0RmEUfZexm46P1msDYqSZMwasq+V+rGwPjdmzpQkmseUki+CTBT1ycFn2
         BWB00EuBRXydga+k9pkNHT7MJ2U1RBDJL1Z6Na7uVNolVhbipiy5CVwykHnT/aR5NUV6
         FQDiKs92kxHMP/l9xwcL3905/RFnO0PV2RVy/WmB5euP7b9rRHjfv6M8oPsqPJR+TtKK
         /b1A==
X-Gm-Message-State: AOJu0YyphPo4Pw7MFcEfgmsCH0hAFZUUkZdx5+ndoInI3r74O/rEO7jb
	JEI57HJkrcnK/oy+GPs4ox2u1FK16WySIbaT2Ls4XrMR6jhU3AG+jVc5Okit1DnZFUieV445vJa
	pCrjlcw7WCv+8EC3PXpR5oW7OlWGsH7//dXJzAV26Kc0tv3ZdmFnnxUHQCx0+efNvRaLbX4bRiB
	x5ZZCrOyI+SyqI1fU3jbhmX48rB2A9b14jxRlNe6Q=
X-Gm-Gg: AR+sD11vuo80g6jLmfsDdVi9Fb/UGz0LnyCnZw5D3K+BCwsymk4DqWaRGGUwy8SrNw9
	vxWcMC3p9NUrqeEwhmwTJ2zJ4mm+kYHyccQM6w9fhKcmDWmConjwlzrt29fi2j4OPqX1Kue8+UT
	2xUCA6lA/yJey5O2bCSk2nSLtUbhC2ztSZZd3x1604DxnXCcVx2b7iExj/A09GGncEcbZ9ifDqi
	q7I0847UfDlpI5Y4flOpqw6Ha7zQ/wHAkK/xqqfrZ4jiO0WgFjm67CpN6b5o5NSWeW6sexdJEj5
	Ns5lrFeA+XdysmZ/BVmvo0pDEMlZ35nDiLFtrNXBvz6eV+ktrb2aD9aVZXLoJHd4zQ1LZO8X3kh
	w3jFtxh2kT/3zDLSewM3BuJCcHGRAVlbfjQUe3Cj/avPuDHEcf7fXLN1mMkiTPMHYOFskjBU2nZ
	fwL0z0UhB4TPm2+o4/nSP54YFkbK5kiVX9C+WMK6pBtHs=
X-Received: by 2002:a05:620a:4802:b0:932:ddff:123d with SMTP id af79cd13be357-9330275bcd1mr345942685a.29.1785261350148;
        Tue, 28 Jul 2026 10:55:50 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:71bd:20d:33ea:4d98? ([2601:145:c282:5650:71bd:20d:33ea:4d98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de635f7asm902901085a.29.2026.07.28.10.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 10:55:49 -0700 (PDT)
Message-ID: <331c32be-4fe5-4a70-856f-3c580c2564c1@ieee.org>
Date: Tue, 28 Jul 2026 13:55:49 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: ANN: SETools 4.7.1
To: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Language: en-US
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

https://github.com/SELinuxProject/setools/releases/tag/4.7.1

Notable Changes:
   * Add initial prompts to MCP server.
   * Add file_contexts querying class.
   * Change MCP server to use standalone FastMCP package.  The FastMCP 
server in
     the mcp package is a legacy version.  FastMCP depends on the mcp 
package, so
     this change is not expected to be problematic for users or distros.


Full changeset:
https://github.com/SELinuxProject/setools/compare/4.7.0...4.7.1


-- 
Chris PeBenito

