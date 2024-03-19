Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BD40BF2
	for <selinux@vger.kernel.org>; Tue, 19 Mar 2024 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889426; cv=none; b=N0AN8PSIkq6JZS3vZJN/SJnHNg97Z7EWJV6RHRH9Sf3o2bxjQf+qDeo3ngM4z3pRJ1IbzXbgIhIj4c/EFiWKDkvXC9/YwR8lGd5Tkdo0qV1qAxx8AfQUguQJ+IVcTVX4Dw+ouUBDYrk9xi4wwzP9YFMAZiY+uV9Zo4O0/B/phps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889426; c=relaxed/simple;
	bh=+GYSuCe7OxEY4PLpIVC4OfQeXTntdF/e9kLldzow4Rg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=fh2hMq5wGXn6ugkybt/M18a0xtyBD8qImf1Soyc3P/Q3Tuicaf/CP7zJ4vGRVcZUrVVCD6BBrlxDGi47/e3dWPOXAX3ga4JLWTSrgemNjMI4LoLgKZu3UC9+++S/EFGZt9Ay0YaTB9hP2t1AmfWKb8Umx4UhUd/P9kmsrdwpB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XrfApTpJ; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XrfApTpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710889417; bh=P/CMuba8MizGGkM8QG/n1paqz7/sq2OKNoEel5hSNeQ=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=XrfApTpJtTsR5Ijskb7omAj8XJZr0WYM6BQOo8tPc6n1JUfMrqEW/quTsI/vGXcH7VgqmKslR6Wj0FOJEOGV+fviUKRsc2i3zdXZAm/HyTXTHNpkhSvqjehqIpxnGRKmYBVrrI4AQaYKQUrFB1rpK3dwOl/RLeIFudqkAFDueQMP8eDyGt1rNXLzIcMjawiVpZ1wlbnGbl4O5nNDJTwhTRNJ//E7hD52uFNELhpzfEbKMnMRgQgoiTfseSYhMUvrj63N9gWJ7esfe/nmL7y/pGsnw277DTlJbTmklHPa10vVoScXUO8tv6gFjKmWL7OEVdN/k6wGxJCP19Xr6bcnJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710889417; bh=odiw0A5bcFD/6ajrga3ppflMDq4YA1yaXmWKQDJ6FWl=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=frNNgzlml1zl5TGia4enwy/JVEWjl3t/gTKPhkABfKtyBQS9uKxyEowbJWgvNyM4ksLT7/c40nM3l9PMuA3iXRisDfC8Hbj52gZWEx/PJRn5vRFImdmOVCor/TpLy6oC4hjonhy9JS1YvNMYvvfBcFTIGXdVCUzcywnZzxCBccES3dLBSMgp/iV0axfc1ox7g+tnkLc2huf5LYGAFg0A98EX613jFyC72nHq5gg/twsilTIpfxoCpJb4nnqrhx48jNgZHJAq6i/U0uNAg9NL7D8rGcteijiETTQR1CUJ88BiD+laDywUtrK0s5pmn9ZTHluE6iZRIU7xE6nEKx7ZmA==
X-YMail-OSG: zNW.MYkVM1m37fnpt5WBmY96lBCZNzFKV7IJtXyqeZzZdKvM0lh37HpLMd.uTHp
 JKs_zFgVNLR7p8mQTnQmgOpjaVPxvSxLCHMZl3QvYhBCbbCQwXFVf9REUO_ntXeXKUumzmPicC53
 KqtMJ7aw2yGJN_hoAkZ_q4KiVrtT0X_ace0Owpt5ArA57WxXsdFhloLqaxGxcI8iNIh8Svtv4hMY
 ElaqLaNzWHHug8hcYdO9mWZYyY3QcsNOH.P05bxr16wxeLFhAla58kJid.3KVzfibZSV5AtIr0H4
 P4vGYQkOozyQ4.l7RuqhZopcpNhRg4mbPZTHinl9DLD1LGlIs7w.QKRpfTXC.pZ4kouLsW9OpWhC
 ATbu2InSWwsqY3B4.5dmTiKGOJ7Ena941JVstXF1_rIjUE3E17CY5_65_M2wKP9mH7xTwzZaxBVK
 d3B3AXGN4_EIGDGtZY8K7cv2mYaKfTLKWgjGj17YoDOxvOyp5bxa6dU8Dw3l0Gjsteb7bKRJ4wIj
 PGqpqprvyCZhqBZG4unH3YrdHmxDjjkmxY1Hx0oaoqYWowwidkVKMniEh81WSoyLOl5P4R8ixEql
 8dBIpXRidwKx3ycM1YnS1GI8gbxkyXWMlxHGKw2i4.S.Ok2jRgJArgy4Pj0qjfoOOzwGPbiVpUS1
 gJAT0APBzcKLfett9jGEKdqz9ptEv6yqzY2HO1Tp23IBnRE4JdXODbAUfF8e7zk8eyu7XOPq9w5d
 nmLtlZutMLcxxne_T1Hgb3_46fvyh.2PtFwTiSrKsxIFTC3GHCyI.8jJN_0R1nvDPhZAFR7fnCtS
 j0OgTD9LWc8DD5nMwJiHIG8hb9npw.dgLBPbaGXlswO1Ej9xZlvh4UxKhD3T95jHxwNwB3RUGU.6
 JJe2bcRN2y08CVRT6LBJM4N8pfCgrrZAmtzJ3L3PKv2kD8.R78TKz1z0yDmxAfzXpFczURXcKVcn
 lX5m_TFi0uMQu0MzhFhN5c8GzM6ErZAREwKFaULdEC4Ad0fraDpAnI1e93g7FLynS9KG1s9JgHP.
 NpGKLstmzEqTDSLrrOvfGJayWW7OSBu5LNd2kVWjJXN6L0WzHBY7VPRamr2P.PgHLtanLWIGGzr6
 wEg0lr_kvRoyAA1w3fd.fbNqT1Zz8IAc0TOk1nAuGhaZ8gR2NB8EZ5GMnf8whTonfFlNUQfsKnZ0
 _WwfXbu4JLLk0HDH.F3r7jnHRaLLHmEjySKTbol0mX8tzIiJAfHcOXN6rB8DWwFBodKBqF6GYVjl
 XccYJuFxq1olJ7F28mGvzg3glxBks_mdNb9oPmfUf74IdYV0lQuKL6eXtQ_FR3WDXWlEd6qqAenW
 LSp7UFpqKuRcW8KgmIqThnGws0HmHibDdUmPOKtZK9ab.z1OTjSG9GGcqABnl9pnr.dr6DreCuLY
 CfrtNr_3nVB4F8G6RovDiGwoCEKuKamzJn1gVCEy1vmeBLmSiV4huI3Vk9rMUCtL4At0lfpMumBU
 4oWSzzHETFFGzapT3cXWGjsXG3r3BWZFQQCMgw2dzsin3HIoZsu_CLSSgrKSG8.wfbjxtsBaqGB.
 PrYTYeBbp64tBgDjhhYZj6mFM30TYnDySGnJi2BDiNTcfSsaS3UhhocgG97tSjFaxXw7aeQ3fs2M
 zCz816U2vrIY8oEJPEpMhQWQR7uO_58CM4_4lGcg5Fo2LcTxwCeQPDZ4zs9LebUU0F8uRc4.y7EK
 9Ib.9YHfMlKkDpIZ9c11u22KNugVZeG8qWloJ5ZXMwdCMS.W9c.Dt77cUtesEpw0idzSlJvQYuni
 m7Ny9CCKtzZjfqo5kjGUJbUpgR4dQD0VdFUyPw_cCpF67jTFX6HBdW.oVP3uPZ2DWAzIcS59luEf
 y_qT5CIfZFMkHYciNR7uOPmWy78WCcutEiBuhA.rFXziFnWg6Jj9D5HeMkNbX4q74F2WJl3Bdjk4
 hK3xzE0xuQqtXrljtYSvOaVGeiqt3vBuCT3MEh9vk0YN9HSjeGaXSsjmjYnKtzMYKZEzi6Fv2LEV
 LYBEGaexyGd7W8VnsUjCRUnol3zLBJnXChdrRaEeKJYzTACCFGvqsMK59KLM85dWFvlg3yLvatWQ
 FXmzAeqshjYsMXuu27FSzJwqH4bQNn9Vsee8G1TGYKRiomogUGQxykg0stuoFCvJP6FmWYWMCXA4
 euU9vlsB4dpLFvp4oO49mbt9drYW8wlY0eR6IzeRDNybPzZlGCZ5dyGuUfr_gld4Ezj0gZaDtZdu
 rrHGMIZZT_QkuEbZISBTMJkstNVrwgSgvIuV_.joxROjt8qoxesUHU8QQUM9UcBTIXN1aXgFNCzs
 zkA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 92634577-2ff3-459e-b6f3-b23512c6b436
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Mar 2024 23:03:37 +0000
Received: by hermes--production-gq1-5c57879fdf-nxlqc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cb2ef116ac057bab74653b6bcc710c7b;
          Tue, 19 Mar 2024 22:53:27 +0000 (UTC)
Message-ID: <41f73ba5-7d43-4a19-a373-84f05c03d95b@schaufler-ca.com>
Date: Tue, 19 Mar 2024 15:53:26 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: selinux@vger.kernel.org
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Where to look for system services modified for SELinux
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <41f73ba5-7d43-4a19-a373-84f05c03d95b.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

It would be very helpful if I could find documentation about, or even a
list of, system services that have been enhanced in support of SELinux.
I'm doing this as part of the LSM stacking effort, looking for things that
may require additional work for the multiple LSM environment. I already
know about systemd, dbus and the pam module.

Thanks.
 

