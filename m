Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39123817D
	for <selinux@vger.kernel.org>; Mon,  8 Sep 2025 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358801; cv=none; b=E4olbMkUk9Y8Qq0ctDgfsVfxLDnCLgDmdg4okarhRqtKxY9e1EdGioEIBDZYXEdqrAzSh757G2XxQfrIaWMqYCKYHVy2QvjWNDsI7nAC5L+eUcwIhyOmHpE88e3dOmAw6+AuOhFlMfJa+uHNf+Pt5h9wO1JkPa13AGmrR78J2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358801; c=relaxed/simple;
	bh=laAQmbRgicHHt+Dnwo2VpWRIX2UkHp7jxKlYU0ODyLQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=o4/l1MxqW/zc+QAULdIcJDq2/41xKT615LNx7epjbzAb0Cei7Y7W09LJ1YsWnkGelJaNnGgH4Bc58nKEfJM9yBL/HIoejheMwOa5/89y8yJlhLME7UKM5ZUDcrw9r0S+LbcGlSW25VqajSBXXBrkd6SzJQquzVmXpy9eJ+B2L7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=F7KHMobB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="F7KHMobB"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-726549f8161so44189626d6.0
        for <selinux@vger.kernel.org>; Mon, 08 Sep 2025 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1757358794; x=1757963594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDMPYV+a91yXMMewo/T0BrZSE8Nuhf9Lfx3KWtwtEII=;
        b=F7KHMobBexkeneuF/ONZU9Wd2X2UKUeXxWWN+pM1Gy57Dq3UMcHO8AFChIqU5KlX0l
         uNmpvMZOFzVnbj03aI4tDkIFa0RHkwEnI08KX0yHbP9QUHjA4MtD9/defRT0GDjvbr91
         ikWqMzSBiCnuVMBWRJjj1haM8KiQ9P1nLY1GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757358794; x=1757963594;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sDMPYV+a91yXMMewo/T0BrZSE8Nuhf9Lfx3KWtwtEII=;
        b=AlUAfD55Fazw+Ax7B/Wc6IYW46R5CSsNOKhaP+ym2LcI2jCqGbSt8W4CrhpnPdVTgI
         71UQNklwsuyEytBPeSoRxx62GUEzYJJIqcqKjfTy8/RKtm5eNQ+sATSLXst1FLLYQP9R
         wlVrqgAy32Hl6u8OWBFlENAjNJ9LutWDoY+DU7N5RVcTLNjhLISpUx+sJBd6Nli9Dj+L
         tCzHlURozuNzvJJH6PoL9pAB7btgZuppv7bv5PqkN9RkCqgAmWq0Rv3sNRpa3kK4b6iE
         QouNDAcYsY6mwkB+XTFvlNFhjAQ6TgJfw0srKTHxEW7XdtTi7LLky4JDIzMzuXSBSIMM
         JFFA==
X-Gm-Message-State: AOJu0YztzvDYxWER4RXt4wkwUc8PtA+ZqlBoT6mtuz3ZQMbnsECLiNn1
	R6pMq1St3YN9nRyyQuDpARCDGxpACHWqRDDTqb2WTNh6Fh+aD45z7+oue663J1f7oTEgDFp2dEd
	/Lb8FOkVRojYc2dUx+fSZ/U5ZnphiOX2yEuFY9NRU+doG4KwFHX12ChZG5opR9Vfh3NbGVA9GYA
	LFvI7Gb6seQUGGN5hmRB/eEfiJ8/t6nBL3XEO8
X-Gm-Gg: ASbGnctcNgqitLXv/L42BnvgWJu+bsXkiwxldeydy6m6u6coPOBu5lBQToCEF4SpO0X
	YmcRJibinIPZfyBVEf2OZ3IRVuQ5T7xoOgdfqQeXcmLBkj4WyqunU5oGMsg/DYvG9/8EgiYi+vJ
	ex3LRq1FfqEpBmLKKqhR7y8zIGrE02uWl34t+0mp8mXF58iFe7G+Ujk3ljVNMwUTBSQAOL0Vl9I
	zHSJJS4luF/uVyShIPFG+XQpcp3qAa+T8xFveqMI9pgw2sS9AC+D26j+1tFH/nv615tKpY96akt
	YV97KwnzyH7rWowGcTigIwdPyJkJSvODCit0U8NH4E91XJWLLQujccaYP0G9mmn7NU/p920t3U2
	k8BfEFuXzmw2LH0yJJnfyhPHxzdw40CvF9h0zrKdN5QCpNf8hgYNXn/FElCHP0DWk9NT1jLcv64
	IeIhHtzLSK
X-Google-Smtp-Source: AGHT+IGv6/NBwy/A72f90v44Vx0PaD81d4IzxM75yRr95hcMNd9180klmhCLKvLJjiBC3AYUb5xlfw==
X-Received: by 2002:a05:6214:226d:b0:729:8400:a79a with SMTP id 6a1803df08f44-739323029d4mr86684266d6.26.1757358794210;
        Mon, 08 Sep 2025 12:13:14 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:96c:ca44:c5b4:b09? ([2601:145:c282:5650:96c:ca44:c5b4:b09])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-73add612cafsm57951206d6.52.2025.09.08.12.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 12:13:13 -0700 (PDT)
Message-ID: <b6a9a66c-9f77-4d43-8f0f-d2da310781af@ieee.org>
Date: Mon, 8 Sep 2025 15:13:10 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.6.0
To: SElinux mailing list <selinux@vger.kernel.org>,
 SELinux Reference Policy mailing list <selinux-refpolicy@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new release of SETools is available:

https://github.com/SELinuxProject/setools/releases/tag/4.6.0

* Add seinfo option to see roles allowed for a specified type.
* Add sechecker module for asserting kernel modules are read-only.
* Add support for the nlmsg extended permission.
* Significant code quality and unit testing improvements.
* Drop methods marked for deprecation.
* Refactor packaging to use pyproject.toml.

-- 
Chris PeBenito
