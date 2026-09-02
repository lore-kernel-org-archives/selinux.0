Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E83E6DE8
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387214; cv=none; b=dFRf8HlBtpf6Qv1atdJxL4xlq2xIyaOSooOrbMG1rBhhDFp/kIlqGA9ioTeojCrXY8lkbUmGBdWaswngk2keN7XtDD/ZDBpEZj6KkoC6MogMSargXR/SGTgs9j9adaR1S/5rZFozAD/GLHJDsK8ynqBCQI+0GP6SDQaSNQ5SQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387214; c=relaxed/simple;
	bh=hML2kxzICCnwiVxKw4rM35W0i7FwNYt4RPiV3T4z2qI=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Powu9sFV1LPDq/bqtEyYWWIThpxYyUCtDB6RgXbhSDuFYqawcUK0tqet3l+6BklkysybDnc5f7mFn8uWCv6bVrBql7JnhaQcnRlLvqyfiuEQsSwHDr2dlEPL8CLxdYZ5bRUSXcu/h4kGAQTswU1uhWkoTH9LeC23zFcV9hHS+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9fIuTzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9fIuTzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B341F000E9
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387208;
	bh=hML2kxzICCnwiVxKw4rM35W0i7FwNYt4RPiV3T4z2qI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=U9fIuTzb+pXeZBwfdJbflJGPlYuS0dxVw0cB8kjLld1WZo5WxA33tKML8/8ErZeeP
	 7kdS3j8yIYu3Srfl3jPrdqwt84YNzJk84fXKFQV/gFynIFjGpLjfIMEqYZ04oJu7aT
	 nFtfWXnUv1UM33Q79KnUeSGix3HH/3N+xBQttkRx7PBj2wOm1fatNuD+6kCqwnwALv
	 FqS+iap7jLxSQGCv8LY45Qb2gx4M6EkJmChbJRnjDTN1+V7UIMZ4hqzuTgV+dKfNqc
	 Drotk4yi1Ve6FLjOtZhYtvckqLEU7oR2idWnrOx3NjZggcgwIa+k5wAYEtCHHoGdM7
	 oQJR3RL+PtfXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] net, smack: Create a function to set secmarks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260902220150.18586-2-casey@schaufler-ca.com>
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 22:13:28 +0000
Message-Id: <20260902221328.82B341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Rather than open coding assignments to skb->secmark, use a helper function
> secxa_set_secmark(). This allows for a case where assigning a secmark
> is more complex than a simple assignment. The version of the function
> here does the legacy simple assignment.
>=20
> Change the functions that currently assign values to skb->secmark to
> use this function.
>=20
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902220150.1858=
6-1-casey@schaufler-ca.com?part=3D1

