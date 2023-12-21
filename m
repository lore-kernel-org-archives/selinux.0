Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAA73170;
	Thu, 21 Dec 2023 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHLHFDF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128A8C433C7;
	Thu, 21 Dec 2023 13:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703163699;
	bh=viF43QBY8qOaLt+Dw6Kyod+MsNmSZWTFM7djYD0jKJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHLHFDF0ZRIm9EyaxRg/fkcqVbnRtqfwIpxukRVuQ1Oe4SUX54ul7Wqz24SD30tSW
	 ch1xk0n3/kW+JEllSSpnezI2MnOyASQq1mZ5gAJMDBA/GKFJQHZ8iuwsvFCBI9v2TN
	 12Z/NjakeatVHT0jfZkboyJJ23SlGocdCVRL5WkVv2cQEN5Mzv/Os0UWssLQx0/wNg
	 AVEnYX2uJ+9tRbaJ8V3vYxvBSGnWSXETyBXLOWnKPxdW9vJVzOkAEE1g2PvXzqwuoO
	 zoi8H/akuO5PvlXsL+HE30wsaL1L9TUwNsmyJNVQLSwiqoUqO9PRfUJ1puamZOD0y7
	 v5x1HgYOeiaPQ==
Date: Thu, 21 Dec 2023 13:01:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Subject: Re: [RFC PATCH 3/3] lsm: consolidate buffer size handling into
 lsm_fill_user_ctx()
Message-ID: <bbfee04e-d5a7-4537-a9ab-467eecb00940@sirena.org.uk>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <20231024213525.361332-7-paul@paul-moore.com>
 <3717b995-5209-4db8-be77-c6303bb1c0db@arm.com>
 <CAHC9VhSABo8PO0q0EUSw7uh+r8CjPFTwK6DJk8Vs4oDcckPwHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ICe5OgUSFKA1hKIT"
Content-Disposition: inline
In-Reply-To: <CAHC9VhSABo8PO0q0EUSw7uh+r8CjPFTwK6DJk8Vs4oDcckPwHg@mail.gmail.com>
X-Cookie: Results are not typical.


--ICe5OgUSFKA1hKIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 20, 2023 at 08:40:24PM -0500, Paul Moore wrote:

> Looking at the lsm_ctx definition in include/uapi/linux/lsm.h I see
> the following:

>   struct lsm_ctx {
>     __u64 id;       /* offset:  0 */
>     __u64 flags;    /* offset:  8 */
>     __u64 len;      /* offset: 16 */
>     __u64 ctx_len;  /* offset: 24 */
>     __u8 ctx[];     /* offset: 32 */
>   };

> and given that the offending line of code is trying to do a memcpy
> into the ctx field, an offset of 32 looks correct to me.

> Suggestions on how to annotate the struct, or the code doing the
> memcpy() are welcome.

You're looking for a __counted_by() annotation here I think.

--ICe5OgUSFKA1hKIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWENy4ACgkQJNaLcl1U
h9ByfQf9FLlgjh9Qa0dMsLOAbqCLPl9tTRTCvabpFoyUmgM+XvqxZfmoUCpu0Ftk
8DmRD0mh+wNfZ4EvO3JvE9oro9YKXvcPC+IhsCza6CVmOcIAeqGlTLD4cI8at3Dr
JZsx8CL1XvQoM8fYErqVk/GkNrK8DigtlSIMp1rfpO4JnE8mxNgDxa2fjNCo06m2
+xxuO/9uk0M4L2rsd+gKFPaGJ6vJT+AUohXNxTqr3AcJ8R8dnsTN2JNu+fT7Q2x6
28/mpjrHylkAfS0y88HtzQqm5H1PKfovlGIgkWl9nyGWKJeq8iViJwpJ7SiebAT2
qkbszTlVRjsNMn0Ev7hql48UoeiBFA==
=Vac5
-----END PGP SIGNATURE-----

--ICe5OgUSFKA1hKIT--
