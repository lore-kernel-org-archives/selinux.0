Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658E74E05
	for <selinux@vger.kernel.org>; Thu, 21 Mar 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026173; cv=none; b=R4t+h7P7Pfzc34BEYQNaahGOCRMQus7I0Q/A1Q5a6EPzaV+CUjNeCcvol3zeDq1XbdUcNbIqVR9I2ER9rX3Lb7SmSJ9awj+opz5cdaGm1P2GwQgarT18q5IcVA15x6StNKWISW8DCvPq+0V7ahA12gR6jDxLyR0rQ2AwTBO/gd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026173; c=relaxed/simple;
	bh=DnJn+lZf7P8q0kPefKZZ4ppMCV2rqEnHPvss0gKHGmo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=o1OnvgSboS4dhCmpmD9Fj5/xjtBlM6HdXgQpit5qgLr+xGouxkXzevEFdddGOF2/dmzxFSn5Ewmo4zavAnJZACdgPaMl9GbSw1ZUeh1vDO8mweFJLqzV8PGN22Pzxc0XSplPQZJuy3uOwPag4pbJjKjvj6MOHHHnfjUYKM60BS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=TVy3ynT+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="TVy3ynT+"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6918781a913so7717046d6.3
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2024 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1711026169; x=1711630969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P7/X0B9+ifdgVHvxv+Gr0tjjHyZfXEM1x1vuN/qQ4Q=;
        b=TVy3ynT+O3ProEaEgp52UqAxORoTWJZKgDgnGfNTYInjfMfrXbQ4ujOP+Hj77Ak9/e
         k5kP5oCLLUli7LVmKL2gGtp86VMi7clfG2QjRrtgHls27JaipF3/a2bs7wIm9mNjDY19
         +CNcYjG36aTLovh3NrCXWuMCThEb5xYdS81Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711026169; x=1711630969;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5P7/X0B9+ifdgVHvxv+Gr0tjjHyZfXEM1x1vuN/qQ4Q=;
        b=M7J7GxRSy/Kz7OSpOZ5q2BLlXqcLWnq96NvrfC1TXaY22wT5ngL3HUE2AWrx9sbQyG
         3wG6UAb6moEPOFaq5cJlcaQcyoDhg6RFOc2BWkq9iqpfAp+OXCLdOryawMqU35mlivGT
         5ftCBOwaPPb6NZwFHPpVdk9Qh4Vw0NMbZkmrgPaguTldog+K9VGrMQIJV5kQgx9EQM5B
         Ei/ZurIEaTl7ShRVyw+Vztq9RCg7stZ6IMqMuCfpYqIVfYTFYVf5Qm6+JTNvafOTgpll
         x+iTlbey99NgqMGBvP178hZffUY76a5ak8NuOdsUFbOQ3KJzYD1ge1vnkrzt2upFchgi
         21BA==
X-Gm-Message-State: AOJu0YxG0NMZ+F5WRY9Lm/NlifhUtJo82bw60H0lv7aYU/622fgzRw3p
	Df1fO9G+oHypYjLWfqWdkONRbTnrNUShNyGnqaLi5PzvgWE4THPvaM6bwcPHobre0BHOjwco+Nv
	4Y9QZsda0G7RiMiW3rnrB7FvCFcrjcD/K8NTv03zMEFPPB+ahzZjjTx2iMD9JNNuVSSiMNf5DUQ
	ykR3OYK/wCzYsiXkgw+xkBLzELmYSpEB1V
X-Google-Smtp-Source: AGHT+IF87C5B0kbjVTIfqGJMUha+ekNMhhTg6Oa7Amp+VOR2D5xLF7acNGffDEPdwg6m7Cd3lI4qCg==
X-Received: by 2002:a05:6214:500d:b0:696:3cab:bc4b with SMTP id jo13-20020a056214500d00b006963cabbc4bmr2022639qvb.6.1711026169241;
        Thu, 21 Mar 2024 06:02:49 -0700 (PDT)
Received: from ?IPV6:2601:145:c200:2c70:10ea:59cb:9953:6679? ([2601:145:c200:2c70:10ea:59cb:9953:6679])
        by smtp.gmail.com with ESMTPSA id kc28-20020a056214411c00b00690bfb6aac7sm8983328qvb.51.2024.03.21.06.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 06:02:48 -0700 (PDT)
Message-ID: <4408b03f-7c03-4fda-90bc-b2c810023cdd@ieee.org>
Date: Thu, 21 Mar 2024 09:02:45 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.5.0
To: SElinux mailing list <selinux@vger.kernel.org>,
 SELinux Reference Policy mailing list <selinux-refpolicy@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new release of SETools is available:

https://github.com/SELinuxProject/setools/releases/tag/4.5.0

User Visible Changes

* Add graphical results for information flow analysis and domain 
transition analysis, available in apol, sedta, and seinfoflow.
* Add tooltips, What's This?, and detail popups in apol to help 
cross-referencing query and analysis results along with 
context-sensitive help.

Under The Hood Changes
* Rework apol to fully generate the UI programmatically.
* Update apol to PyQt6
* Replace deprecated uses of pkg_resources and distutils.
* Begin adding unit tests for apol UI.

Updated Dependencies

SETools now higher minimum versions of the following dependencies:

* Python 3.10
* NetworkX 2.6
* PyQt6
* Cython 0.29.14

New Dependencies

* pygraphviz (for seinfoflow, sedta, apol)
* pytest (if running unit tests)

-- 
Chris PeBenito
