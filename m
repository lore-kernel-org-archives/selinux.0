Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4818052;
	Fri, 11 Apr 2025 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337765; cv=none; b=YDUARluOtfzvefyxQyYYlzcyzhzdjoaYQ/13nKkZ1YCaF16PITj63xowjHtLYl8X5X7h6K8Z/hOuMaAz4mZFaaUjK0+31tYX9G/erAEvFcPnJuDs6i3Aypk8ryfKW+1ug6cro53ZD9/L1ziyp5fZdix1mur5/c1/txG0u6Z/rdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337765; c=relaxed/simple;
	bh=vZvDy+kOrWAaKY3hM8qC9K+FqrF2jjmB07w+WO1ui3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFxewiRlZ998vRG7vLXSRYWnzF2YpRfQNHGRRSF4l0yVYDFRmH46j649wUMOP8yMUltzx+79ITcpV+tTfVbcgnj9Sw0KdISVQlkRnRpaDOmubXPGWmMI35KgJPggBMr064TrxnEHSgd+/dtV5MK32z0SHh31a2bCp4HKxgugwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjdoRyRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjdoRyRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E91C4CEE3;
	Fri, 11 Apr 2025 02:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744337764;
	bh=vZvDy+kOrWAaKY3hM8qC9K+FqrF2jjmB07w+WO1ui3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjdoRyRCRvdzLQhbw8W1FCfCoPDZqLOfyfAFWOe0ZnIMwewDB9pkyWnc8sPVUYm9A
	 joQ61cMyrC4aBI6mpLIU95HYE+TPDhyagpQhifpsasc7t5BN9tVvNVbZEUDmzbjBSx
	 utH1WfUjwZCmZinbKoOJCOdxRcaeeFEr2zNHGbvXljg498+mUY9MnY93VITB6XvP8i
	 d/RhdGbXStKBSSpVAb08+b1yWoayYCzcQ4mVZzRcHeAi13bX0DrVcyQBgJXj60l/F2
	 jOHShV4cGuIUHZ+lYIkWzU2Pw2bULgK9Qhi88pKxOnEYPEy13anrgKKj5dq173+Szy
	 d7nRSgAbUP8KA==
Date: Thu, 10 Apr 2025 19:16:01 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
Message-ID: <202504101915.CA031AE@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-49-paul@paul-moore.com>
 <202504091639.A12E1A853E@keescook>
 <CAHC9VhTR=ee4SGuvDbFj-dtevVFN3Pm-tVhtMLpHsiYB24Xxcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTR=ee4SGuvDbFj-dtevVFN3Pm-tVhtMLpHsiYB24Xxcw@mail.gmail.com>

On Thu, Apr 10, 2025 at 09:15:47PM -0400, Paul Moore wrote:
> On Wed, Apr 9, 2025 at 7:39 PM Kees Cook <kees@kernel.org> wrote:
> > On Wed, Apr 09, 2025 at 02:50:03PM -0400, Paul Moore wrote:
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Reviewed-by: Kees Cook <kees@kernel.org>
>
> Do you mind if I convert this into an Acked-by?  Generally speaking I
> put more weight behind a Reviewed-by tag, but in the case of Loadpin
> you are the maintainer and I'd much prefer an Acked-by.  While I'm
> always happy to get more reviews on a patch, the primary reason for
> CC'ing you directly was to get ACKs on the LSMs you maintain :)

Acked-by: Kees Cook <kees@kernel.org>

:)

-- 
Kees Cook
