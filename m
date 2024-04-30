Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67B180A82
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508227; cv=none; b=XzlTW++Ndn5w+DjPBjedosFXFdy/e1lyxF8O1lTXStbxfx6j54cLPL5anVeC2G8bgUFji28tJJfpKXDldekONd4/K9IMBLpBMGd6NJHj9VbhAUYn/pSL1f7F1YcEvcKSHLfUlFpIdF2I05qC8XQ6pPshxhJ8go6HIMu/S/O9t/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508227; c=relaxed/simple;
	bh=X2X7XzjxIDqpbEq5j3Hk8NAqU4vKXq0Nl0QWBooQmfU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lhV1e9C4H+yczZIcGu/ur6K2bmuxjSkGShYq0M63f8pa30+zk7W7jgtXBgytpi8DlNmXzJDcp4LxVw1I+rekXzYwBnM41mW/XwuS6PEwQagbnHRqP0DwoWdutT5/ZYzijEvLHMkRh484otu/754+v+miipB2RJklkSUg1OblDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IPHkxISM; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IPHkxISM"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61b92a83216so70289787b3.2
        for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714508225; x=1715113025; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+eymqjF76LU5iwbRsQnyv8CNj73ky1eNo3EB2JdbeK4=;
        b=IPHkxISMtNCtenC96AAlnIgnFaGnmC7Afqsuvenr0gCEWnV794Laz3h92/zc5H+5l6
         YWpXp0gCa8U2me3jEzulF/Auv8Ma6qSmY2b9crUVc+l6rZH+phxUwazEqMJ8yCfz0b3W
         0cFnRjewesqUtaq80zkVEXFPiOgvzJabOqwqruRP8GvyOlF/au8V8O3dLhNtf5l5lNL2
         mo4H5ciuzc448/t7ixID4CuprEZl3O2S557Foe+X2xKxT9fkwiLMN0JiK2AQ1P7kH/ka
         qzSWc/eJ80r19WsPfZ2za3Lj3bwsxG/cN7xQms9bpK/v2a+50CjtMpWeScfKduttwOZu
         zS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714508225; x=1715113025;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eymqjF76LU5iwbRsQnyv8CNj73ky1eNo3EB2JdbeK4=;
        b=mJ97EnDY0SYgdFV1FvGLGsSYRjAQV8xc3qPQ/bRyxz0aWxWXTlG4P0F/Em8dDG+fbb
         u2SvoIp3811nR20/aXQVQX22pPKoMvd+VS10t1HbVRJoORBvYbzo2URynebQ4eYwH2FH
         pY9D+etn/C+kesvAY6Et4ifsAQDrqD9TLkA7B3SX5az/I6jS3R7tPtaH4S4RnqS0XhBm
         43ipP7SVSzFB8Khb+G2iavkXSNmKfgqgJf0mCSDArU5dyETKA/6H9qjLyiibLOECaQzY
         sXtBkVSINFwrnDT7S7/y26xkYq++vUYk2h9exsAnLzVYsFTyVGJuHJ5bEMtbAGUKgpVC
         x8rg==
X-Gm-Message-State: AOJu0Yw3+9TMdijqTYFUlYSBXgZmM/IB+3tdUkDr9GNSVWva0qp0I18V
	ffNeNzHwg6hL3i8Cre4si8577qHBo7UUS4hGxvqhVVmd3Mb55PHPgruuCLVYeRfXOsuPqbSEUF2
	P2HMsdxvVFlk0JvGbft0mNmcBYtrishMRx1GAzpVxXvf2HIretQ==
X-Google-Smtp-Source: AGHT+IGsU1g2UTWHUK9spdEAAaHUEd594wib+MRNPLUuP0nuAXelYkyFICQf61b+aYM8hyim1+ReIdTkHQGMY+1RUFo=
X-Received: by 2002:a05:690c:c1a:b0:618:8b8a:b4de with SMTP id
 cl26-20020a05690c0c1a00b006188b8ab4demr717235ywb.27.1714508224940; Tue, 30
 Apr 2024 13:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Apr 2024 16:16:54 -0400
Message-ID: <CAHC9VhRCu-ggYA=kfrXFzmk-gGosh3djAVrDowrCUANOiT=0Tw@mail.gmail.com>
Subject: ANN: new release of The SELinux Notebook
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm happy to announce a new release of "The SELinux Notebook", version
20240430.  Pre-built PDF and ebook renderings are available via the
GitHub release page:

* https://github.com/SELinuxProject/selinux-notebook/releases/tag/20240430

The changelog highlights are below:

* Add a new section for the "io_uring" object class, updating
associated sections
* Add a new section for the "user_namespace" object class
* Update the "genfscon" documentation
* Clarify noaudit exemptions in the kernel, using Linux v6.4 as a reference
* Correct a problem where local filesystem paths were used as
hyperlink targets in the rendered book
* Assorted typo corrections
* Assorted build improvements
* Add maintainer guidance documents

Thanks to all who contributed!

-- 
paul-moore.com
