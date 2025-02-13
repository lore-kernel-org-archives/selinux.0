Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AD143736
	for <selinux@vger.kernel.org>; Thu, 13 Feb 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460120; cv=none; b=spDnlff2SZ3MOjfGwC46zyJLWAr5arcAFdMxNa8S0yxyxHQ3R5C65RIHtJOMBa3ure8aunr2rByxtixCooEJJN9lr1Q2jDxax/iNyQcCt8KelBIA+cdooIPxnXQCripWQra6RMS5dhWSUrE3ylG3CpWuzuttxOJT+2iQLYNvL48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460120; c=relaxed/simple;
	bh=3Beuw3wx/JW8LpLzDWK2VlGFdYoKG/NWhyJ8XrJLP7k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=alNkgnYvwrKIajN1pdoPsOSwiiAZ6OH0D7H2vw659yCuO8blIyWfwtQ7N1UJP41mS6Qd0/ONE6RVf69CkIhTgAq98OHAIkRrWx4yRmofG/nslu2kouk08DpVfsFEogPF+xDFRbi1uEsNOijRNdv5+dEPQskaSh7DlW4hF6NkvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=UhnoGJpD; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="UhnoGJpD"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c077c9cbb9so81616185a.1
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2025 07:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1739460116; x=1740064916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7vyozjuJV198fxxTBAnnNLaKIaVIGwZlAtdvi/bhAQ=;
        b=UhnoGJpDgp4T1FJUj1EGLF29jkfuUYeECgnmryAVaPHj3JixcmQg/J+61R5oFcZ2og
         xG16tp6KjwPWCcO+HbOULlL7srW5VpQ0jYYQLtNUnghtRmEligoi4QKUAFhLDwM0OEnI
         cQtYkOAuXgnsXCK04Lu9a80qdxSELKYnXuzq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460116; x=1740064916;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k7vyozjuJV198fxxTBAnnNLaKIaVIGwZlAtdvi/bhAQ=;
        b=sAJEJ8Yc01qMdH8n+sFJZ14YF5X0LisALMrU14t9I3b58AaK68hiWj0hSXymcbOoCv
         nJPfAsuzwv6kj4lBqp7f6r1GH6/F2wq/fNlc4U1UaHSTPK8zmXUVpvi/k3X8TBFC+31J
         gymq/GBEhxMYTelkNzUj/m7Ej2vdVg7lhb2vNVllXno4/Y9aohI52HhTq8fUSMRQ7Qia
         T1/SVP90E9S9+1VxxVyWLL0FGZRZ/KcyDi/K0LVXGI7ILb7Sc89jVZAhYMePX9eRljxG
         KdzTS1zWwnt/2NbWNTZe27sNEdA+Jm24q6oDCTtW4H0CHNa/YPEkPpKs5AIASoeBQM0a
         Yceg==
X-Gm-Message-State: AOJu0YxRbMSuIxNghl/uXema/8nOuJGpqj7nQEs+VDYbD6dUAN7GWOl+
	VkrMSbIuwhXUaQ8WrdpYIf1V1tJt4/mSY2y2zZOVd5Dr82fkoFiuM92XoaRZ3O6pyubexo/w4/2
	9DGzBHWkCOP/k8teldMdfmyoXNwYNnR8DsNi2HkuHZZPT8f1boGI9NaO/xBN7QWyc9FifsuL92/
	rgkthZJBiuZfMD1OTbGHEFxbTIwdxN195T
X-Gm-Gg: ASbGnctO6Ndmpk5bSh29JD203J9r25opceoXzksXVCVNyWaJ1gxNgCp+HXVCDmlSBdN
	EXcyEU4dKHBdFe3++I7tbph0bjc+mFaRK1onBTB+a4zWLP23J2hZpbTYJfJ27s4Nx2Zom9vgLQ/
	ThCK0Nw4ftHDpPmKLNN054e/Kxi9MccyXrVfM9BEkcuiXphwP03Nzcu5UZwUBUmhqwGyK96gpmZ
	fKSpkIACydYhpL09/k74IMJDvZLKvcaeMjQnhuAZ+TC9ZJgwBlJfeoaqZFqoQpOvIjgbnp7+FlE
	k8Pcuqhqlx9gY2etvv/TF4CSt4gy48BjE8KdPAvJMYNM0qqhkOy4t3ytiAyKmbS4dg==
X-Google-Smtp-Source: AGHT+IFuhTqmKxdwi8GZZTXvhAYC4jBnMsVg0TYrmIZHEK/Gj1e//C8W1Ge8nEB6E8qxgIWpNdJb6w==
X-Received: by 2002:a05:620a:808a:b0:7b6:d241:3f07 with SMTP id af79cd13be357-7c07a8b3e46mr508502685a.15.1739460116469;
        Thu, 13 Feb 2025 07:21:56 -0800 (PST)
Received: from ?IPV6:2601:145:c200:2c70:94c4:8d23:1c3a:e211? ([2601:145:c200:2c70:94c4:8d23:1c3a:e211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c86e878sm99273985a.94.2025.02.13.07.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:21:56 -0800 (PST)
Message-ID: <64caec05-e185-4ea7-ba82-d1fc7599a8ac@ieee.org>
Date: Thu, 13 Feb 2025 10:21:53 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20250213
To: SElinux mailing list <selinux@vger.kernel.org>,
 SELinux Reference Policy mailing list <selinux-refpolicy@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new release of SELinux Reference Policy is available:

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20250213

Notable Changes
* Add tool for validating appconfig contexts files.
* Add netlink extended permissions definitions.
* Updates for Systemd up to v257.

New Module
* openarc

Full Changelog: 
https://github.com/SELinuxProject/refpolicy/compare/RELEASE_2_20240916...RELEASE_2_20250213

-- 
Chris PeBenito

