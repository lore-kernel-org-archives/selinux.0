Received: from sender-of-o53.zoho.eu (sender11.zoho.eu [31.186.226.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6C386
	for <selinux@vger.kernel.org>; Fri,  1 Mar 2024 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=31.186.226.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298553; cv=pass; b=U7C4a+dyzqSSqblMrRGMKf7PcvpT+aKmp2e74o9V6chaHi5PuBFUUK5L3JKu5Ods+hashsdClWCaHnGkOWZMphqIrw6sH9I4cy6aJ8ON5EWCbcp2oeppLAQV7EblWpHUsGKgEQ+Hx8Iqkw9hmHYlELNExbIUjbyPg1qTNj+bzZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298553; c=relaxed/simple;
	bh=5Q3yo2mpiW1qENcRy4xj+uETvW3zM2NdcRz9vAccLdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdJZBMiV9aoCsi35jrFwT/NNShKGldZAqoRB9awjmkEaOfjybTQxCYRP404EWBF1id5KMAF7X9e+4K41Cg7YjDOIFvVkbXHm7LazBZsfyc35sQviNNINT7earAT+8N015pa91p3sHHdp1ARjK064UCF3RhteCgaqPfvCqnM1MGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jurajmarcin.com; spf=pass smtp.mailfrom=jurajmarcin.com; dkim=pass (1024-bit key) header.d=jurajmarcin.com header.i=juraj@jurajmarcin.com header.b=OleFWEu3; arc=pass smtp.client-ip=31.186.226.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jurajmarcin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jurajmarcin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jurajmarcin.com header.i=juraj@jurajmarcin.com header.b="OleFWEu3"
ARC-Seal: i=1; a=rsa-sha256; t=1709297619; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=SEpZrJB8//V1zc4iFyELm2jx29+r0Wd8pzHpyewdLqfqtX86EicdHLl811taLPlTYNZ0UZ9de9ytULjBKwMIPAyNCZ0tGtND/2e2cCfZlQvhah2gyd+rJvT7/eZGklJYjD1lEjZ95LEo4dBJKlvgOKwXvXWhJtbfSUJ5iiydchQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1709297619; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kagDbht/fgsbzJ0PlwOBa58tzlD/vHhOp5JxyxaNh0g=; 
	b=g/Ahw/8y/tjUEmPqNmF+VK0nDW4IJf2D0EGKwkyqht0Xn51Kt7Zd4de3ba8D1P64plIgLe6DBjt7Rh9lgx5UHznpVWHTivQK0irAHGxwk2QOsMkI7CvmUYlKyPC5lnff/8y41/jUUMVwPQOsgCk73vMQ5CMNA1XyvrxQULdJNsQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=jurajmarcin.com;
	spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
	dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1709297619;
	s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kagDbht/fgsbzJ0PlwOBa58tzlD/vHhOp5JxyxaNh0g=;
	b=OleFWEu3QL8vNO3JSnOpkiZnqF9jLXZMtjh2pkAUhyP/PMzjSiombbCskDRLE6m3
	xPW56OoNorEbA4ti3Lz1qlRPHifcexBr8mK6ITzyYakJRbS1wSMhnDb4ICZJkLr3uV3
	ScT73slrSgVejOs0Sb2rMLNr4ADPYqbPYPKyTmgk=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
	with SMTPS id 1709297615217610.3236228856391; Fri, 1 Mar 2024 13:53:35 +0100 (CET)
Received: from jmarcin-t14s-01 (unknown [213.175.37.10])
	by morty01.jurajmarcin.com (Postfix) with ESMTPSA id D48A4207C09C;
	Fri,  1 Mar 2024 12:53:32 +0000 (UTC)
Date: Fri, 1 Mar 2024 13:53:31 +0100
From: Juraj Marcin <juraj@jurajmarcin.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v4] selinux: add prefix/suffix matching to filename type
 transitions
Message-ID: <20240301125331.cijacxb4yqbum72c@jmarcin-t14s-01>
References: <20231121122719.2332137-1-juraj@jurajmarcin.com>
 <e5095e3efcf18b1ab85e98d421185309@paul-moore.com>
 <20231220122049.gi6qkng67jesels4@jmarcin-t14s-01>
 <CAHC9VhT943edUro1WyjXnonjpeJx-g9Zjfh30fREEH5iV6REZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhT943edUro1WyjXnonjpeJx-g9Zjfh30fREEH5iV6REZg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On 2023-12-22 17:46, Paul Moore wrote:
> On Wed, Dec 20, 2023 at 7:21=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin=
.com> wrote:
> >
> > Hi Paul
> >
> > thank you for your valuable feedback. I will incorporate your
> > suggestions to my code. I will then report back with benchmark result=
s
> > with included optimizations. I suspect, kstrdup() in
> > filename_compute_type() might also be part of the reason, the patched
> > kernel is few tenths of microsecond slower, so I will also look into
> > that.
>=20
> Thank you.  I did look at the dup'd string for a bit, but didn't see a
> relatively quick way to do away with the additional string copy; if
> you can come up with something that isn't too ugly I think that would
> be great.

Hi,

I am sorry for a late reply, I did not have much time during university
exam period and among other duties.

I have managed to get rid of kstrdup() in filename_compute_type() by
saving the length of the name in the filename transition key structure.
This memory allocation for copy of the string was the reason for the
worse osbench results. Reference kernel (case 1) is always the same
setup, I just benchmarked it again as part of the automation I have for
the comparison. Modified kernel refers to prefix/suffix implementation
with optimizations mentioned above each table.


1: Reference kernel (a1fc79343abb), Fedora policy (format v33)
2: Modified kernel, Fedora policy (format v33)
3: Modified kernel, Fedora policy without prefix/suffix rules (format v34=
)
4: Modified kernel, Fedora policy with generated prefix rules (format v34=
)


With iteration limits based on min/max prefix/suffix length

   | Mem   | Binary | Policy  | Create    | osbench [2]
   | Usage | policy | load    | tty [1]   | create
   |       | size   | time    |           | files
   | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
---+-------+--------+---------+-----------+-----------
 1 |   407 |   3682 |  47.368 |    2.4376 |   43.9488
   | sd=3D20 |        | sd=3D0.39 |  sd=3D0.050 |  sd=3D0.486
 2 |   417 |   3682 |  46.979 |    2.4655 |   44.0856
   | sd=3D17 |        | sd=3D0.32 |  sd=3D0.080 |  sd=3D0.476
 3 |   430 |   3682 |  46.892 |    2.4605 |   43.6223
   | sd=3D21 |        | sd=3D0.28 |  sd=3D0.042 |  sd=3D0.374
 4 |   417 |   2585 |  42.131 |    2.5331 |   48.7980
   | sd=3D21 |        | sd=3D0.29 |  sd=3D0.041 |  sd=3D0.456

Here, cases 2 and 3 are improved compared to the last patch, as the
kstrdup() is also skipped with no prefix rules loaded. Saving the
min/max prefix/suffix length does not slow down policy load, as cases 2
and 3 are pretty much the same as case 1 (reference kernel).


With iteration limits based on min/max prefix/suffix length and
kdstrup() removal

   | Mem   | Binary | Policy  | Create    | osbench [2]
   | Usage | policy | load    | tty [1]   | create
   |       | size   | time    |           | files
   | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
---+-------+--------+---------+-----------+-----------
 1 |   430 |   3682 |  46.930 |    2.4569 |   43.4431
   | sd=3D 8 |        | sd=3D0.25 |  sd=3D0.043 |  sd=3D0.434
 2 |   410 |   3682 |  46.829 |    2.4623 |   43.4112
   | sd=3D20 |        | sd=3D0.27 |  sd=3D0.053 |  sd=3D0.442
 3 |   419 |   3682 |  46.823 |    2.4257 |   43.0575
   | sd=3D14 |        | sd=3D0.18 |  sd=3D0.057 |  sd=3D0.416
 4 |   420 |   2585 |  42.044 |    2.5028 |   43.7907
   | sd=3D10 |        | sd=3D0.19 |  sd=3D0.067 |  sd=3D0.382

From these results, it is apparent that removing the string duplication
is effective optimization, as in all four cases the osbench and tty
create results are close together.


Out of curiosity, I also tested the kstrdup() removal alone, without
other optimizations that were proposed.

   | Mem   | Binary | Policy  | Create    | osbench [2]
   | Usage | policy | load    | tty [1]   | create
   |       | size   | time    |           | files
   | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
---+-------+--------+---------+-----------+-----------
 1 |   421 |   3682 |  46.941 |    2.4702 |   43.6063
   | sd=3D21 |        | sd=3D0.23 |  sd=3D0.052 |  sd=3D0.388
 2 |   422 |   3682 |  46.736 |    2.4655 |   43.7345
   | sd=3D16 |        | sd=3D0.22 |  sd=3D0.059 |  sd=3D0.516
 3 |   425 |   3682 |  46.950 |    2.4445 |   43.6280
   | sd=3D15 |        | sd=3D0.25 |  sd=3D0.045 |  sd=3D0.378
 4 |   418 |   2585 |  41.582 |    2.4456 |   43.3526
   | sd=3D18 |        | sd=3D0.14 |  sd=3D0.056 |  sd=3D0.365
=09
It seems that string duplication was the culprit, and additional
searches have no measurable impact in the tested cases. However, as
saving min/max prefix/suffix length has no impact on the policy load
times, it might be a good idea to keep the limiting optimization as it
might help with really long filenames.


Best regards

Juraj Marcin

>=20
> --=20
> paul-moore.com
