Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576274E08;
	Thu, 21 Dec 2023 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAaGXYik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B124FC433C7;
	Thu, 21 Dec 2023 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703184640;
	bh=qDRBcAHPMDINTO5YJk+RF+UNlxZ5P+ssCDEy48OWiWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAaGXYik21eInhowI4AdjcEizCLQit16Ik1S0ikr7awrnh4I+R32Atx/3lxltFNwq
	 ONopeSuDXXaeiQ13qxlnipCIIKv78MV6rD9SJ1Q6jIG37uQOBV6pqBFB+/a9HHO6Ee
	 RiZ+tURQSepCOZ9lNraILZQ4kJIAqwjJDRAN/r/9xOgrPor6U2qXT2lJtnS1khc4Yo
	 61AThNacT+wnxJwGzbX10788dG8RdtYGECNszXfly8cFMbtliS2jqn7DglmM1/vHZv
	 CF0izwcfG5Yw3Jp0v53elWS8FFbg71jrfFYF+nxzLci12ymffIJyXHcYg2dYa3DwZq
	 Ot41kTviO5G4Q==
Date: Thu, 21 Dec 2023 18:50:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] lsm: consolidate buffer size handling into
 lsm_fill_user_ctx()
Message-ID: <2ef211af-95b8-49cf-8c11-1d8b958799b7@sirena.org.uk>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <20231024213525.361332-7-paul@paul-moore.com>
 <3717b995-5209-4db8-be77-c6303bb1c0db@arm.com>
 <CAHC9VhSABo8PO0q0EUSw7uh+r8CjPFTwK6DJk8Vs4oDcckPwHg@mail.gmail.com>
 <bbfee04e-d5a7-4537-a9ab-467eecb00940@sirena.org.uk>
 <CAHC9VhSZ6SQ=2tspLk+kFhXKPoOcAcGzkVrWVneT5_cXBUyrUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O8hfQ7xnbTsNc2jW"
Content-Disposition: inline
In-Reply-To: <CAHC9VhSZ6SQ=2tspLk+kFhXKPoOcAcGzkVrWVneT5_cXBUyrUQ@mail.gmail.com>
X-Cookie: Results are not typical.


--O8hfQ7xnbTsNc2jW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:21:04AM -0500, Paul Moore wrote:
> On Thu, Dec 21, 2023 at 8:01=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:
> > On Wed, Dec 20, 2023 at 08:40:24PM -0500, Paul Moore wrote:

> > > Suggestions on how to annotate the struct, or the code doing the
> > > memcpy() are welcome.

> > You're looking for a __counted_by() annotation here I think.

> Can you verify and submit a patch for that?  I'm asking because my
> build/toolchain configuration never produced these warnings/errors
> during my testing.

Huh, actually it's not __counted_by() since this shows up with
arm64/gcc-10 (and some other arches) which doesn't have that.  I'll
submit the __counted_by() patch anyway since it's clearly a good
annotation but it doesn't actually shut the warning up in this case.
Adding the hardening people, and I'll have a further look.

You can reproduce with

   tuxmake -r docker -k defconfig -a arm64 -t gcc-10

using https://www.tuxmake.org/

--O8hfQ7xnbTsNc2jW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWEiPoACgkQJNaLcl1U
h9D7uwf+PhT897VPiqeXCU3XmgWQ8QAWLdMCZuXcd116TbdMAotlH+FNeB6o5r8t
OwEDFflinFc0MAMpOhA8L3Vv9nEJXBEylGAh9nmfD6siVKuL94uRt9KVuawak4QA
KtSIbC/EDce4VPD8rFhRv2qcrM78GnhjzsIv/r3C6mOiFftafhbbFLY+3oJC9aMu
IOLktTjIhXqxhM5y49uv/JEuHU3sm+ZxXb2PUR+ALhtXaYXB4JJOt6rWHhWDiYJB
ArbNVtDmm/APMvn7h90TD3U5mjgao/I3Vznkq+8j7dFGrX77TZpGZIyNEbQWxhNe
NgRfzXn2rcRRtNWWI98yHFz6oHXwWg==
=fQhq
-----END PGP SIGNATURE-----

--O8hfQ7xnbTsNc2jW--
