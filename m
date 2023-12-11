Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Umi9cQJt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aU4gxg8z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Umi9cQJt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aU4gxg8z"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4067FDC
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:08:06 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 227941F8D7;
	Mon, 11 Dec 2023 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702307284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDDfZL2siSkw3kroAIDEzCx84sVncPqD9ky7hdvh7HA=;
	b=Umi9cQJtBakfV/TDyP5xDImxY61Ky+63vL49EMmzcuAqRFUwR8IkRAm2SGgAzYOakjbhwH
	r/4YItzahZ3M3+yiZAoIOlZleYKGjatEFLALHuRzdmRO97HlVtb29lccy3OHiS5itlS1e/
	HhpRpMSZ69mMN2u5vJaPNa2+8jNSTMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702307284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDDfZL2siSkw3kroAIDEzCx84sVncPqD9ky7hdvh7HA=;
	b=aU4gxg8zpvh6tUo8XPmLZ6/5Q9rlhD/K9VRPPZdN4WxXQkaYRYtAiPbtdnoFH7lpdhj0+V
	i9CLVqO0ZQXAidCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702307284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDDfZL2siSkw3kroAIDEzCx84sVncPqD9ky7hdvh7HA=;
	b=Umi9cQJtBakfV/TDyP5xDImxY61Ky+63vL49EMmzcuAqRFUwR8IkRAm2SGgAzYOakjbhwH
	r/4YItzahZ3M3+yiZAoIOlZleYKGjatEFLALHuRzdmRO97HlVtb29lccy3OHiS5itlS1e/
	HhpRpMSZ69mMN2u5vJaPNa2+8jNSTMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702307284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDDfZL2siSkw3kroAIDEzCx84sVncPqD9ky7hdvh7HA=;
	b=aU4gxg8zpvh6tUo8XPmLZ6/5Q9rlhD/K9VRPPZdN4WxXQkaYRYtAiPbtdnoFH7lpdhj0+V
	i9CLVqO0ZQXAidCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD48C133DE;
	Mon, 11 Dec 2023 15:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LT8zLtMld2VMMgAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Mon, 11 Dec 2023 15:08:03 +0000
Date: Mon, 11 Dec 2023 16:07:57 +0100
From: Johannes Segitz <jsegitz@suse.de>
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Subject: Re: Where's 3.6-rc3 and plan with 3.6 release
Message-ID: <ZXclzTjExZpvWrew@suse.com>
References: <87o7ewsy7f.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dhUqxE2azW9sQaDc"
Content-Disposition: inline
In-Reply-To: <87o7ewsy7f.fsf@redhat.com>
X-Spam-Level: 
X-Spam-Score: -4.16
X-Spamd-Result: default: False [-4.77 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.37)[90.70%]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.77
Authentication-Results: smtp-out2.suse.de;
	none


--dhUqxE2azW9sQaDc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 01:47:16PM +0100, Petr Lautrbach wrote:
> I consider two options now - a) to release 3.6-rc3 on this Wednesday and
> leave 3.6 to the next year; b) to release directly 3.6 this Wednesday.

I would be fine with b. In my experience there's not that much breakage and
the chance that a rc3 will uncover something significant seems small=20

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstra=DFe 146, 90461 N=FCrnberg=
, Germany
Gesch=E4ftsf=FChrer: Ivo Totev, Andrew McDonald, Werner Knoblich (HRB 36809=
, AG N=FCrnberg)

--dhUqxE2azW9sQaDc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmV3JcwACgkQvCfdnSzE
/WYo1BAApVa2BEg2j5f9CygCLNJEqupQT1BUMOIiWtWB6zQkW/QVD7RptabVkt7m
JzVBLv0NaWuIo/SkacfC71TMEliPUxPEqo/oYG9zo4zZXvHhIW7HYMJGz5Fs9Dhw
M9wxUNLKcXbX0aA81GQgFxkvUC95ewhYaoAE1+JBYBnMSXOTPDq4Qak+moAllmi2
jmyJHzaV5nR4oqH1Gg2Iem7xNMt5loLGrcCDzxoo4mh92CchfkmLV+hQUdQNW1Da
NRX9JPoJFGkJY4a5ntAtqGXKDE+ysDKSjiP7XTKEoAp1IW2wFbpVecQis81XirKy
ooukHcXxgEcMiIcx2gi4Gpg4lUP9u9PdVrTtUydQgfePFyz5tZFSqUbQsvsIfP9Z
1YqHaPCW9RBFoJTJu59cwBqkX1OrM6Nd0tZUOz69K1NbViOP0FRqCURKvogHiLk1
2cqEznpTq+blaxYtxsvS7Dr/26h5ZysGmkgynDAcHmq+/N4ryVqH1GLXkd0keaou
8xnEpGM6LQ/ofI6v3d4CTo3wwjvsSvX+bCBOj5uj7uay5uBnRG8C8EePTu0iqMfR
iRLK/JYGvDcnHmo0TY7PNsP6TtO/nZpw5+AZDW0AzeOxB3GhFSbRUzFuYXZ6luS8
idiYIM2ta+rzzdTV8qiqcEMWPPNiK0teY7igiZ+iNWlgKR33cYs=
=IvPY
-----END PGP SIGNATURE-----

--dhUqxE2azW9sQaDc--
