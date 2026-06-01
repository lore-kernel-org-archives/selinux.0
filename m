Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562882594B9
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333261; cv=none; b=F34XlyDiZRnh8EyHe0WScYVxV7tj/jyPq1gwWtiluZWPf2sIri9oUaH2gHvtqnZHw3fFCAq5xHACf9VGeSwaKsJuqF9dy2Hk+QWkzG7rzzdEMuwOQ1UbeUglE1FKEJWJ8pMdzORz9cWSk+LYJICHVF3Pwuqvexfeudu5ySKKqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333261; c=relaxed/simple;
	bh=AbhI+8psZ8AjZeEBtQ263JHRc8QYGLUZj9WhB4mhRKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QUFCQJDJX/SzT66731up/ON52USfCVoJNlvEJXffo0CFMdxQKpGYIG0snkBacbP4neox7NkF66cca9cIJjx0CAYVmm5KJJvXckcmAuuaaKSyO+7DHqQIFbT7i7AaxwWmZfob4vRCyJomFMQqQb2PJ7+JYtaa13a+G99RCeYsoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=b/djbbkb; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="b/djbbkb"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 55B80240101
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 19:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1780333250; bh=KVCcJ2TcBDbf5MWp3cUB5BhgeKKN6s24oaIUU46k0Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=b/djbbkbUNweypjZqb5XIjvQPdaZu9Xzjb5/uhei6Sq+LRsc+1iGpFoB5/7FXncUU
	 EZN6LlYoRgbd6g2ywulyZijd5C6WYae7RK3HCVmtKfUI/DcE2IBffvZGNJPpD7JZ7v
	 +4S+6OhBeoqAKsCbjlJfUXdRz3gh6RnTfVlVWwbQ+eJuDjNNrVcV/d5pI/nbkso+DK
	 QNsXHaRU3ds5RTxVo1aLlo878wtcJnZZq4tEARVrce3ZbRW+eAlfUnq8iirz2fKObv
	 JZPb5gj9n1mRcaE8QyB5xXcnCfAt3g2e/nLYoFOUYKEczqleYCVSikjgaBlciSkwEc
	 hdipDSlUZc4BQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gTgFs5VDqz9rxG;
	Mon,  1 Jun 2026 19:00:49 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Subject: Re: HEADS UP: SELinux Userspace 3.11-rc1 release coming soon and
 code reformat
In-Reply-To: <87qzmq5iia.fsf@redhat.com> (Petr Lautrbach's message of "Mon, 01
	Jun 2026 18:32:13 +0200")
References: <87qzmq5iia.fsf@redhat.com>
Date: Mon, 01 Jun 2026 17:00:50 +0000
Message-ID: <86o6huxkjm.fsf@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon Jun 01, 2026 at 05:32 PM BST, Petr Lautrbach wrote:
> Hi,
>
> it's time of the year when we usually release new version of SELinux
> Userspace and given the number of recent fixes, we'd like to release
> 3.11-rc1 during this week.
>
> Also it's planned that the last commit before the release will be code
> reformat using `make format` - this will effectivaly make all unmerged
> patches unapplicable.
>
> So if it's not urgent, please consider to stop sending new patches.
>
> Thanks,
>
> Petr

Hi Petr,

Would it be possible to merge in my patches[1][2][3] pertaining to the
various compiler bugs[4] for 3.11?

[1] https://lore.kernel.org/selinux/CAP+JOzRB=2-jSQaSVjVQ12YHb5yTM71yPrXmFDDG_FiaQaT3TQ@mail.gmail.com/T/#u
[2] https://lore.kernel.org/selinux/20260531054519.650723-2-nvraxn@posteo.uk/T/#u
[3] https://lore.kernel.org/selinux/20260531184111.691569-2-nvraxn@posteo.uk/T/#u
[4] https://lore.kernel.org/selinux/CAP+JOzQe8Mr9X=mV263-g0dr4VKM2kpqKQ_X1bg+Es8oXoUZYw@mail.gmail.com/T/#u

-- 
Rahul Sandhu
