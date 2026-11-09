Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242036;
	b=unGneUgGXoC4CNqBeu1s5JTzD+mDW/ENABTp+c/oEFRYBfowafubNt2IhFn+sfxlto9a
	 zvD7kDteXWODYC05tbCRzuYvNe3eO5FJxbJnH5mik++Os3mhLedt+iiwVSHtw8PzP6U5h
	 DUdNkUzo45mat6iPHrBBTrW1YkQnPXbVRdBbZZyQDUbqRrIMHc5BGAX9U5wE1fECw6AHh
	 pFPBtjfR89kQ30LLYAh0DYsHeskqp2Nb5dUcaudoQKB93P/9ZCiNtlShV6rPr8oENe1YA
	 a2HxKTt/Pbjj9x1J2OF4xtwuQkTEbxG23XiB5BMC2YHXPL0eNPKagkiS0i2H0Oh0f9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242036;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=NH78+7kWSFqa5TvgJa42T8E22o5YDvpLB35n4Eb2Brg=;
	b=vtpMXDmKPNyWD5zsHOX6Ipe42yqBdKjAi9G25RW5meY4cPKvisaEMyGkM0eSF0PH13+2
	 9fqO7i0cslKeV94iZqM/QQY/EiYqX/U6tdnvkhgSyjWJshpkc6Qa2yzfVg3soU98P7nr+
	 5jFPSN7wQsUkSF529nKZMm4WT022lU7fUaNB4J+Pvyi6Wdd2lqYLLWC2a62274ikb61JJ
	 /4KpTwr7WNtSBShwy2ctyDuVXWEKTfhdBFtaMMUDZvqEMOaozNBf4kE6merdnP4xTZN08
	 cxEl68en2fknUtILYXExPBAv5PYTvIU/qLY1EpI75DqeabBZeYMgRxAvSPr4WDwP5aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s3SrQjoB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9JyGyBuZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s3SrQjoB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9JyGyBuZ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE1606A33A
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDEE1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s3SrQjoB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9JyGyBuZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s3SrQjoB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9JyGyBuZ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B7F51FB7A;
	Mon,  9 Nov 2026 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794242034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NH78+7kWSFqa5TvgJa42T8E22o5YDvpLB35n4Eb2Brg=;
	b=s3SrQjoByZfUdFCV/KwLl9xUM6FQJRdT7sKMELF6aROK8W+RK7HAaYAsAA4nsB2ZsQjDmf
	dEdHIkKhf3Bi01tFQsHbiIoL/0k//zI9vkQr6MtcatHntozFU0zySk0l72RgOb+EBeeqgM
	xGxwgZY91Z0K7M5FJW2GjwQy+78jWLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794242034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NH78+7kWSFqa5TvgJa42T8E22o5YDvpLB35n4Eb2Brg=;
	b=9JyGyBuZ42fH53owzV3aXmkHvweA4H7wE6vck4nLIAWa5hdhGZ8Odasp+H8moWbQ7cLm05
	IfDQ+Qkd7IoK46AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794242034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NH78+7kWSFqa5TvgJa42T8E22o5YDvpLB35n4Eb2Brg=;
	b=s3SrQjoByZfUdFCV/KwLl9xUM6FQJRdT7sKMELF6aROK8W+RK7HAaYAsAA4nsB2ZsQjDmf
	dEdHIkKhf3Bi01tFQsHbiIoL/0k//zI9vkQr6MtcatHntozFU0zySk0l72RgOb+EBeeqgM
	xGxwgZY91Z0K7M5FJW2GjwQy+78jWLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794242034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NH78+7kWSFqa5TvgJa42T8E22o5YDvpLB35n4Eb2Brg=;
	b=9JyGyBuZ42fH53owzV3aXmkHvweA4H7wE6vck4nLIAWa5hdhGZ8Odasp+H8moWbQ7cLm05
	IfDQ+Qkd7IoK46AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D931813302;
	Mon,  9 Nov 2026 16:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HmWwJvH18WqTbgAAD6G6ig
	(envelope-from <fbonazzi@suse.de>); Mon, 09 Nov 2026 16:33:53 +0000
Date: Mon, 9 Nov 2026 17:33:52 +0100
From: Filippo Bonazzi <fbonazzi@suse.de>
To: selinux@vger.kernel.org
Cc: selinux@suse.de
Subject: Re: Question about libselinux *_with_level functions
Message-ID: <avH1bZb2poB7aO-U@suse.com>
Mail-Followup-To: selinux@vger.kernel.org, selinux@suse.de
References: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
 <CAEjxPJ6yTtMA4a-CvrQW0uTJ8mTEkdr6WE9mVJw67BKH5KRwyA@mail.gmail.com>
 <auxhNtTcQa-6TS35@suse.com>
 <CAEjxPJ7w5BMmMW-cZNG-fVpZT73BW0C9d-cBcrG3AVW-ArS=Tg@mail.gmail.com>
 <CAEjxPJ6ihzVO32+RAah_g9vo7vbFQTK5EGybgvJhow9u6tzMbg@mail.gmail.com>
 <auyV4UaYWjPiDZdD@suse.com>
 <CAEjxPJ6p+wGhq+Cjpg+J8HGZ=4x6e2o5AZ1OYHK4CCqVjd5GZw@mail.gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i5i2a3uceor7q3rg"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ6p+wGhq+Cjpg+J8HGZ=4x6e2o5AZ1OYHK4CCqVjd5GZw@mail.gmail.com>
User-Agent: NeoMutt/20260406
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-15.40 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -15.40


--i5i2a3uceor7q3rg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Question about libselinux *_with_level functions
MIME-Version: 1.0

On 2026-11-09 11:14 (UTC -0500), Stephen Smalley wrote:
>A fix has been posted and merged, please test:
>https://github.com/SELinuxProject/selinux/commit/fb81f2f56990fccae2c67d41a=
de5ad4abaa6944d

(already replied in the patch thread before seeing this)

Hi, I can confirm that this fixes the issue we originally reported on openS=
USE
Tumbleweed. Thank you very much for the fix, and please keep me in the loop
when this will be published in a proper release.

Thanks,

Filippo

--=20
Filippo Bonazzi
Security Engineer                        suse.com
8257 4398 947A 2DBE F21D 76E6 937A 63F0 5B36 46D9

--i5i2a3uceor7q3rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAABCAA5FiEEgldDmJR6Lb7yHXbmk3pj8Fs2RtkFAmrx9fAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEJN6Y/BbNkbZ0IoIAJMXheWv+VXsKzgwAlkm
DOhuIgmvu9fY3Qt+fTlY54dssHzDz1QIYx8hVF8Wf2w9cfFyLm2a1jQ3nKzwNGhE
swel7CDyRVjTiAEAwCUIWWl/+tRnzhCN5vlBuLFyTQ2hcFVHxJuzPevNyNZAItr/
tOxt+CGeMC/oZOw1JziTsgZzkr04vqrDgAj7DFw6cE7TiCsZH69jnmGpUa+sLksz
pZMpi977rrVUyc+FuNZTsAIkDaK0h0tR/cRiP9GCLpTkZYF/qpAIPGoHMORzSABM
fKSUZjgzUbBAOiDKg9xxJIN0zBexgEu/pjJhCzy+WdBqSk/WcVg8tYW6mvgqIAWi
E0w=
=Cj30
-----END PGP SIGNATURE-----

--i5i2a3uceor7q3rg--
