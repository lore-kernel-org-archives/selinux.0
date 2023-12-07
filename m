Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="JC2gy757"
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B5910F7
	for <selinux@vger.kernel.org>; Thu,  7 Dec 2023 08:12:39 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-67a948922aaso5877926d6.3
        for <selinux@vger.kernel.org>; Thu, 07 Dec 2023 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1701965558; x=1702570358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CsF3Fog0X83nNvqveIuAbDrgmf5qIr7/l5gvjue31I=;
        b=JC2gy757BtdfrlDDLcUYUs8fPxDslvjk5mAN8Ki5oDQxiRDBBNenyNyPhRAhxpcfBJ
         ikOC8lVca24oK9SZT554QHjFXhCseZVIEqfpsJAnhzNclYygJDG3lUr+q2Fv8IYrH4Er
         yyvrI4dG9RAPjpPYROzzUsGjBcgQ3+vsu3pWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701965558; x=1702570358;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CsF3Fog0X83nNvqveIuAbDrgmf5qIr7/l5gvjue31I=;
        b=dx93/yPipTb4eya3zFn1WIf+zsbs7V05ep6u8LZ27PWVmi71sEbHFsYzAvCOEV+FLf
         22ZKYbcNizb2JVA+OQ7v3apt9V7wQyrUcNw2BJZYm22jpG15f5ytW2d7o5ADqDjykdeF
         5f1qqtiFoJY6xAnJfNUyQ2lv30axXcvafTgiGh5/MGlTRkjEp/ul/u5omW0cFedK5IvF
         sSUBs7tToTSmJJZ7OH4Lr+JguduzToqwIF6CLNL1Yd09FRmiaCI1dc/mC/pVl0at5NNN
         hcF9bnlsM+BDmc8p3oiM/ks/tBBO6RWGkuuMeEoSWpHelToCKBfse++rH+M8ourNaNAH
         npEg==
X-Gm-Message-State: AOJu0YwpNdDahKjJP9lwgq7FZFK2O1YAF3AZV/MqsXsfu18T/BZG1q3J
	CUGOStVu/iclgushM4lIDhSbPEV56tnA+9AO3C8XdytVaD8RaR2vwQ/m0seT8NmSeeoNIJ02cDh
	3araybas4Y75KJiOVtDvJn+EFVyQxtgkFOiKZn1w9a13d5Aqtx714viky0q07F+8cmHG4uBZb
X-Google-Smtp-Source: AGHT+IH3TnShRMwEKr3MXw0Vkj0sAqjyGq4DsPlAiQMn4TqsJyMeui1+1c8QfTlsPU8sa4jI8KLzCw==
X-Received: by 2002:a0c:f351:0:b0:67a:b9a0:4319 with SMTP id e17-20020a0cf351000000b0067ab9a04319mr2643291qvm.19.1701965558073;
        Thu, 07 Dec 2023 08:12:38 -0800 (PST)
Received: from ?IPV6:2601:145:c200:960:e134:41db:5cdc:b836? ([2601:145:c200:960:e134:41db:5cdc:b836])
        by smtp.gmail.com with ESMTPSA id ec6-20020ad44e66000000b0067a24f5b432sm18427qvb.62.2023.12.07.08.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 08:12:37 -0800 (PST)
Message-ID: <902cdaef-8e92-1fa4-a474-f3c926a138ea@ieee.org>
Date: Thu, 7 Dec 2023 11:12:42 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.4.4
To: SElinux mailing list <selinux@vger.kernel.org>,
 SELinux Reference Policy mailing list <selinux-refpolicy@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new release of SETools is available:

https://github.com/SELinuxProject/setools/releases/tag/4.4.4

Changes:

* Update for compiling with libsepol 3.6.
* Update apol to use fully specified PyQt enums.
* Correct minor code lint issues.

-- 
Chris PeBenito
