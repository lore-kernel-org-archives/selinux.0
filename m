Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6D503BC0
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794879; cv=none; b=s3JR4H2DL1yxNi46P4cfeZyv3vKjp9sOQiwMWhx7k3Tu0HIKA40khPsa8/mzlCAGrRNXOw7fhYXi58YTBqBXZh83j2vYOrRRNPyUwouavfwAsKzbnwcOEvMO8bpVVHecjzqGUDCBCYGKd2HElgdhEZZzh5XbMRT0aFSUkBdvjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794879; c=relaxed/simple;
	bh=3DqS7lcUjSDzkbzbdGjITSC+12tp8E60SNSgAs8+E54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJbjwKbelnJfx6XLrs8oYXwjs+FdG+M8iDzpaHBLakZE++gd6tKeDk02p2J1Kqk9MgBDIafQ/W7wgJqX6Zm+7/DglhwRwcTISptuMlDwUzGYHiTxfBylV+XSPRwAsHIcVnKKnIo5dqQqipwhxcj6X0tleY8OS0Uq4Dsjnptz2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ApkJGcnm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bTC8a076; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zw7BQr1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q5DTpbI3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ApkJGcnm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bTC8a076";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zw7BQr1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q5DTpbI3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 794161F794;
	Mon,  7 Sep 2026 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788794869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HI/Lx/7YnAUSmXOD1Pbgh0jRNiG310HV7hfQe06fwxU=;
	b=ApkJGcnmQomQMsTnV4m1CJM1JPeBx1WxgfOHr0CUJr8phD5sKBhR9iwtxNrHvJQQ7U8EQ5
	gjBG7122DrsZAmrKRSu9XHuOOyGf+b7Kceh9UpX3+mMeRVYSx28ubGv6Gw+ELi0iG/2Xg/
	vCDyY76DkqOg+AZC1vVQWdbBe4TTFD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788794869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HI/Lx/7YnAUSmXOD1Pbgh0jRNiG310HV7hfQe06fwxU=;
	b=bTC8a076ZqeCz4y+be8yAluYFUvhmS57RVMuTQrjCKQ/J9X3PhFBS9r7MJt9oQXqbSdSVl
	znbjpF7WIQxqL4CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zw7BQr1Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q5DTpbI3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788794865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HI/Lx/7YnAUSmXOD1Pbgh0jRNiG310HV7hfQe06fwxU=;
	b=zw7BQr1QV3SD4oBu0/bYVD5uJoM9BAugNdhZ16n1pFPuNWgIDJDRpRiYrAu356kwCwQIvH
	y8ixhc5Mx5OLeQNSm+1LZD5INt0nz0zDhcGs2qv1aoCzo9cD7lkTF+NfIG42xBrtviNIe3
	FnnrIruXepSYrDhF178FB+bsSOseWPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788794865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HI/Lx/7YnAUSmXOD1Pbgh0jRNiG310HV7hfQe06fwxU=;
	b=Q5DTpbI3Wzbb+URdTEmmuQQ13vkRRa7m7R/Lrs5/ItmVuu5XwUdN0X09vpM1Yeq+Hepkf3
	Ni4Gyd6mfqiqPfAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E9321339B;
	Mon,  7 Sep 2026 15:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z2QfAvHXnmrOYQAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Mon, 07 Sep 2026 15:27:45 +0000
Date: Mon, 7 Sep 2026 17:27:39 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org, jwcart2@gmail.com,
	plautrba@redhat.com, omosnace@redhat.com, jason@perfinion.com,
	paul@paul-moore.com, Russell Coker <russell@coker.com.au>,
	Laurent Bigonville <bigon@debian.org>,
	=?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
	selinux@suse.de
Subject: Re: [PATCH v5] libsepol: drop support for policy versions before
 xperms_ioctl/xen_devicetree
Message-ID: <ap7X66Suk6ui4j7u@suse.com>
References: <20260827125511.19408-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com>
 <9b2939c5-7935-4d2a-b628-6c3ba961e16f@suse.de>
 <CAEjxPJ43LV4CHSCLc9mxvBJEOAY=+hYMZ8+8-cRvpWDTPmqqRQ@mail.gmail.com>
 <CAEjxPJ5203DeJ_38pT9Kw86FFACh00z3YegMDzedvv9OcpG1qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kWM/+gaZ2PttOJvA"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ5203DeJ_38pT9Kw86FFACh00z3YegMDzedvv9OcpG1qQ@mail.gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 794161F794
X-Spamd-Result: default: False [-5.11 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,gmail.com,redhat.com,perfinion.com,paul-moore.com,coker.com.au,debian.org,google.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:url,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -5.11


--kWM/+gaZ2PttOJvA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Fri, Sep 04, 2026 at 11:13:32AM -0400, Stephen Smalley wrote:
> On Fri, Sep 4, 2026 at 8:50=E2=80=AFAM Stephen Smalley <stephen.smalley.w=
ork@gmail.com> wrote:
> > Having heard no objections,  I plan to re-base and merge this today.
>=20
> This is now merged but can be reverted if distros report problems.

I was on a (long) holiday, so delayed feedback for me. At least for SUSE
this is not a problem since we will never update very old products like SLE
12 to this, so breaking changing of this nature are no problem for us.

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg,=
 Germany
www.suse.com, Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Abh=
inav Puri, (HRB 36809, AG N=C3=BCrnberg)


--kWM/+gaZ2PttOJvA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmqe1+sbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1m1joQAK+cFMsrXhVwrd/EQA3n
ppyhn8rTNybYc/G9XhX8EHxhuIXPDL0J7xIF4Vr4mI+PyONaJyOl2K7nFGv47K4k
Nk12EmJIIbNE91yGIxgDHHPQg0iVB8LOFjio9OuMU/uaozQXXeJJfz6rvBKXzqZO
83LiIeA/T08oR+2LhdSgI5x49jGdlMarFKUffg1NdvNf1LaIdVL+vv7OdDXOyyiF
rhq79NSLcfkS8VVo/mBvxK3+WFZsn/qJGV8usv0sDt2YZeVn3wJRPU4ImZcNHbMu
qWuSLBCVH/wmec1pT48gb7TdUUkH4re0SvGykZWN4eP+UwFavSs1vTMr8HhnTUa4
QjeqvyhDdyYCSjlkpo60yMoc6XSRjSA8sUii9byDh/2+F0iqsg38TN0fLWEFIt2S
VuVViH5OXCqOd1Y38E3tEKh9zI+7nu44eRKkgFcDU9kwG7zGYMQEYryNpvXR2KJf
KA5cci8ha0NiljJJYgJoteaRt+YmTuH2WgsQ/U66KkLETCWFU1Tqmdb+aCcTr4Bp
c/lj8PY3JTHhsJkslFoS4Qt3IGk07BhHmvxk1kX+v6YqDIH0pBgMNvDiSceI7gVd
YLkF2mJ+ydChwKvS+g3lBEaQtt789u3d9oq9nuj9qsiDvFzswib3/OddlzkNPoiQ
ob0r4Zb3YwxHowiFSVtVWVwp
=Zsc5
-----END PGP SIGNATURE-----

--kWM/+gaZ2PttOJvA--
