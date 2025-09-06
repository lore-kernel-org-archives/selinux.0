Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C310957
	for <selinux@vger.kernel.org>; Sat,  6 Sep 2025 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128524; cv=none; b=hFt8feH4az+Xnx6Usn/LLgqgkxE3EzZISH8/DP6CEkAe1I8Ixq6uU07BkPjpoYiyaRxIN4ta5jwd2V8NhoM8YyH00O8f7f7rKjZBZXo4kcEETaxDkCmFDgVl9MhoVHwsXDKAGDgT0g1o4QpFPVyUFC75fTBz/ZyoFaoqdNlXux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128524; c=relaxed/simple;
	bh=AvlMdw25eCgMu0dHMlriCCLoeoNd2IN9QRBLOBFWx7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtDHui6XD1oGduvI6qqDlruvL4WWGrnUc1pobzOXTPMC5FP2TzXzb1UyNhZiSUxQpp3H9sd+FH0tzBCR+gLEyxGBKgpT4VDL4XUF57u5nRpn7FzwA9M24+o0usiUfnuKxxFCknSzvrl0HVy6Nv8nga+QLH9pEaioxviaWvCDq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQlVNbzK; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQlVNbzK"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3f680ec2a03so21367715ab.3
        for <selinux@vger.kernel.org>; Fri, 05 Sep 2025 20:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757128522; x=1757733322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g44f+BPw5Hi5G4yK4fXujHmXwUWXbVPu3RwfoHic3HA=;
        b=MQlVNbzK2Bw7FkR9TCxyaX09JnoIb3E+dRTTiprwhrB9FF964ngajLGdYZI8FT+UQ/
         PwmDs3HId3pZ/gBzpMRrGE2rjY+dKaajO+cmJm2v7PxbP3vu8GFwtAm+bQD1kPXyQSD/
         q4nYPz5OHLT06osuiR75mfsW601HjFfcCTkJbwJIAKYF9/OF6kzDDUN2R6BKT3LBCQS4
         b98sTR7VUyFNGA0yws5PR0yIfPmsSNoq4Sh7mbE+OSqITpW8UiYbSot2fuflTfzYYo9W
         cxQ8ZhZvvsMnSM/Z3YuLknkWL+ZrpByX2eX++sM4eEndOpDJIiobEEZR9xUeJ2+E1CtL
         W64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128522; x=1757733322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g44f+BPw5Hi5G4yK4fXujHmXwUWXbVPu3RwfoHic3HA=;
        b=FBt+fPJPg1bNVK7Xg0qUGvk8k6VQH6kyQ3ImwDueBMWwYQSzQI4bFPReBzoPSEr2Go
         V4bDXtQ/g5MtYkzEa+CfGk7butT07CX8/cgpKIVKoA/+2YaPIG/Dabil4W6wJZ65SP4M
         2F1kBE+w8N4SHHrSZjo7+HI1X5mPqxblmbOp71iM6cTcncetDGiIfTdYkTz8P7pOgfpq
         DkzoW1eccPLMEmlvM1ioCitjxMcKUe8T8D7yWdbm2o2odqzjXhfYXa9+OHvdA2h4x5XR
         fDAAL6Wreh2b0l8QArdPgmhdFlti9NW1s18ViEmN1BxifiH4iQDw2EoWlzuRc81NJYc7
         nbFw==
X-Forwarded-Encrypted: i=1; AJvYcCVSx0xKhNizUGaX9QtPxf+4qIHWV7WSatboKVRjgCmygpIfx5m4dstSeUpb7eFylIvX7NuzJQjk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzph6RL9cCyBCyuxPXcers8DsyHDgjobU45CD16u2mWBt6xXnN8
	LITqQq3HhA1QMvu/bRvuGRlF9wn6y1PFaTsNDSPBXPql4xok4B4cCRIKLiGPZe9BDw==
X-Gm-Gg: ASbGncv4RoxnoWFyIxWCZVtnCSHfEa4d9Ttb4XnDJWKZ+QRpZ1l7mQ0PoiK1mNOxibR
	DpQh7IKpF528lp0LA52k9ExSkDdmiiRes55l7CZ0n/vE1LASs90ugAVFUvDE2kDqP6tXNgZz8Kb
	wuZ7JDgiHeFDKdj9N/RMgUX9T9MSNLcsPyyyfA6xsfKUSCJGy69rNsxFL9O9mkIeeT79T693NCs
	tEOD4cycq2icaZu9V9Dtqx+i4Wrhe5nUKXCQgcaoWIiuBl96NbpTwmKFZeS8GgW8eCqkuh9Os99
	5In05kwaQvkDzh0hs/xrkiRlEHDRQgdVJyj5JeJPYrbUFC0ObIiXCZmZKP7lw04LwxsiwJlC6gn
	XlXHQt+3vSj0FmdImjlMBMUYu0OlAoDfY8Sy0BEcvmz0HAx9f5hPRdIuWSobsYc4jZ9AhHA==
X-Google-Smtp-Source: AGHT+IGLw2fIxxDwuYWLRzhDla8WwJDRsF96LtIboEPn6HhOZqGVG9ZppVZ6OQM5ivQzCu68n0DXrQ==
X-Received: by 2002:a05:6e02:214d:b0:3f6:63c5:74e3 with SMTP id e9e14a558f8ab-3fd94a140camr15675845ab.16.1757128521855;
        Fri, 05 Sep 2025 20:15:21 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3de24e723sm81698055ab.7.2025.09.05.20.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:15:21 -0700 (PDT)
Date: Sat, 6 Sep 2025 03:15:19 +0000
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: fix logic issue with per-file labeling for
 functionfs
Message-ID: <aLunR_0BPCrATnBP@google.com>
References: <20250905222656.3692837-1-nkapron@google.com>
 <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>

On Fri, Sep 05, 2025 at 10:13:01PM -0400, Paul Moore wrote:
> 
> With the original patch sitting at the top of the selinux/dev branch,
> are you okay if I simply fixup the existing patch by adding the
> missing '!'?
>

Yes, that is fine by me. I could submit a v4 if you would prefer that.

Sorry for the thrash,
Neill
