Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866B4D8D9B
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338998; cv=none; b=Rdflk/isGPu7QzAK0Iar6z8uZINKVVuKisKi3OglJcigv4VGBMeGrWrxKiEsUp1G5g9H8l7dAIXrGE+gn9BlmPSDvzDkFcRig32BjwwOLrDQk5ha6JNquIv/7pu5qjj8hgQyVmpI7QyytTdcnsMtIkqlsitjwlD/dNmpJjegF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338998; c=relaxed/simple;
	bh=QhSfTEFvtq52c1qvrENhzt8PEDE2L04QgB7j9dDpiS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdYy8KjFj7IQAA/VrVfbwjtpl1tnAtyRC/HX1ilDKUceEuKsquNN7VtMbBHt4c0VPwQxecsGp7StBbmlJndTF/PnY9ZIShXzfEm4Cb483ibsrOitIS9lM3TEb6LcmiI/LJn3nDhSxcPiCmDr0SUJE/YndwI5Jd5/0frGpL30saQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YzpsFcpT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HAFpI5PD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t50jyM6w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A4B6e4Zi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YzpsFcpT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HAFpI5PD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t50jyM6w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A4B6e4Zi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F9AF7B8E3;
	Wed, 29 Jul 2026 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785338990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QhSfTEFvtq52c1qvrENhzt8PEDE2L04QgB7j9dDpiS8=;
	b=YzpsFcpTz496/rypa+BLkY6tiPum8PnBLr61FyWcojp1lZhB5SQfHCOykH0TProips/pQB
	ESWVdM9OjVhcn3R0atCae5fOFG7cY6nJi46yfseSXp0pgI10La0hKkWAKXDJ/DjbTWSWH5
	iCpm21VVvbREYwANZG7exnQm5FFghGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785338990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QhSfTEFvtq52c1qvrENhzt8PEDE2L04QgB7j9dDpiS8=;
	b=HAFpI5PDLBq23QQ/tHkGl7gwqpEfEIk9K2GOv7IcOmWnZ0Y39eSsA45EuoV1SHWAKt3VEo
	E1wRbtF8zaWSD6AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785338986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QhSfTEFvtq52c1qvrENhzt8PEDE2L04QgB7j9dDpiS8=;
	b=t50jyM6wnNVZy/2YLiX/imjPUkp3jgJNzSSMIzyDMJ9ke7AQPa9qxsJrnopVqelTpqp6GJ
	bfDzOcn5owo0/dAkQ+kj1Z68oOsLL+/oGmpBd9q0LjuDgHnUwr/zFlCCPYbLPzLKCdr5AN
	h4KP2i6w906M4m1wJvjrDBlDD7WP7mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785338986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QhSfTEFvtq52c1qvrENhzt8PEDE2L04QgB7j9dDpiS8=;
	b=A4B6e4ZiVbU77BPuAAUWN6yibAN+Kt4UHk7RJHelRW00GCzSXEPOp5T6PMJh2FK8GZIZCp
	bzgiMTNTS3U/gnAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37016779A1;
	Wed, 29 Jul 2026 15:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XMa4DGocamo2cwAAD6G6ig
	(envelope-from <cahu@suse.de>); Wed, 29 Jul 2026 15:29:46 +0000
Message-ID: <a67c0073-3c0b-4002-9c61-6f17e955fb11@suse.de>
Date: Wed, 29 Jul 2026 17:29:35 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] python/sepolicy: add a pyproject.toml file
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com,
 omosnace@redhat.com
References: <20260724175059.18960-3-stephen.smalley.work@gmail.com>
 <20260724175059.18960-5-stephen.smalley.work@gmail.com>
 <2fe6f92f-0288-48bb-a49c-8519bcd1ebfa@suse.de>
 <CAEjxPJ6na3q8JMrCRmyfs6vLyGRO54CR_=35hQjeNKVBDs1-pw@mail.gmail.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 xsFNBF90UHUBEADUtdHBsvZam/KLgeriGeft36rqthD8ijzTSoKxai7x1e7SzcYGtOQT9bun
 eVyWp9raec7awo3z8UUBXDuIAnTM0a+pzYheSeTtDovoHNbb3cIB/NcRnqUrlVLI/ZhdK3x8
 0EXWZ9Hc8fiD7EyreTtNVBzmN40rOkHdQ9Kc+xJphV8/rinelEAachvw6c3bPzLs88Pv/IJ+
 Fjx7on1dS0I6ADEp8G/l3fU8f4Hxy/kLfJ28N1wNb1aLvWG/uztNrO8ed3KVs/NhzmL9WpTO
 mEpnpUDr9SH7flYAvKBquwXG/KWLBCB6T9+3I0LehRC14Z96CWWtofhOB3t3hlOZmstwSyfd
 zeYAhOXwm/yULb/MqHlWxE55rU7eSRYPCvtYfqZ8NfvrdeDIcz1en5Q76aaZNsPv/IvoWWhx
 jkQeT7sTSBWtk171sHp2nKKuqb2aHidSE6xFPLj8ZkyyN6SL0HxjJy+nYLeFAFnVyti/mLfz
 UVa6NBmFoAHDzp5PxAN7Ey9lALIWvlDFLYzeIRXVKvloCv1P8NwBgmVP3uETgcYQM1RNrICe
 yO46gBs3HUnLDRt11f2c1GK+STpLQmQffVNv3qx3dBNUWluO3KEyBvvoBvqKjiRYQnbQL2Qm
 xLBAB7+NxN97acczrdpknOS9FbsBvORU7B+/+h2w7gNTn02v+QARAQABzQxjYWh1QHN1c2Uu
 ZGXCwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQRYc8/RjA6m1Jy79sQG
 KhAWFQWgigUCYxXl/AIZAQAKCRAGKhAWFQWgir3rD/0TwrxmIDneIz25Reigzj0DNwDycflF
 RdQlnQRia8S5+NrZmbO8PM6Twss0FYCZS7LPKjesxBgbFdVBdHqS8RkPglK1+f1itDVxBRKN
 8nJDklsP2X7m5NGNs7fVmhnEwrTa4DPjGQgyHj+yoRuS76VSIU1IcuizAhsAAgcPBEotwFEj
 vsh3jLgauLDGYfFGyUzl+wKI1MieeKZoVc+r6cb8GXxhy1dOGSRxCsBoSRx+6wSSbHnBS45t
 2XhybCEhbV6sH8QauUtDyKp6ZaDTV+A50v5HsMoOTgZjYfiCW3AgOuNhXiQNTLFTvE7Tk442
 QssvoM5LVUWdJZzSNMuD/UxQUk7S+/y6AKkpKHejpJiWsgp9jiH9Qc7kg3/HKgzhPrR/zbGc
 2C3lY9yyJqG+6bX7lcgVQrg9UcQ8kX1PaXPuroO9O6Dm3Li2Ej7VX13ciraQpX7aOdDx+qDW
 sTlw8t96H3JzHpcBFSyTEbkPcESVyR5mLs1GRGIVjkKrMpF6tStGVkhgC4MRUsZT0k0dpG1A
 HxPrLIVUxZZz9q6+8Ss0J5C7pM58lW0fcjtw1HVHTTqyj98WI7YDwGegMayx+jW4KlAcygPk
 ZUoagrlU4SrfEXjcy+8tbbBPGzBI8Un24sxk2xubpQ9LZARBy7rNAxADzihD/RS6h+4S4r9T
 1BzAzM7BTQRfdFB1ARAAtXRfAKngaOB5ZbVK/sIqCscQftG6PBaJOpBLXsNSDvj2zH03We7r
 yzHuH7hhbcDtz8VtIn/ybNnB7QIMyx5MUieOEqr3FI2o9mRrYD/2XkXBITPJyFuZfVa3Ebdo
 5Huv+NyXbzu+nsEkrNdSZKlTTVJY1vF3ukFAvEs/MvBtAlGhSJWtEmVLotqUAlN3KnSyrg/C
 M5PNqrD3ZKs1dDW0LH/AwkzLlGoMJ9fUyKLHojujm+rY8nFnBqZu6kHM36YKiy/d3lbc0SJn
 z7d2kbtbW3yP10lDzAoi+gTXqpjeLxGDcNLBt79BobJLfGJ6cng91zbOxXfFI9giUZHR80jB
 foA19D4f2LJVD7Ofm0/HPSws2j1Bhnhp4L6anGk6Q0Uj0G9owycvwdOUIfMmAxaQ3ELJTQFr
 l9WwYFzkdS6z9BOR42HIVmxkLd0kzAJzTH/S0Ms5uRtXgDk8Fc8sspGvuque5sFcGM9dfWU3
 VZNy0o0KpS/xy048ZEbY/30YiyGnBZNIps8s+YwxU7nlEnmBGWK+sLZvvSd/kbyVtWIEXUGF
 6tWbaIs9/j4yLJuAvnxadiPoqZ8MfdrsIaQPGOsRt3Z4igEzh9HyDGr9vPGRA3tZOY1C63jL
 mPk/aVFIaV9qCv0lXl4BcE7cYDRcAmZ+q7ns3eLnSG6egglhRlyzGtkAEQEAAcLBdgQYAQgA
 IBYhBFhzz9GMDqbUnLv2xAYqEBYVBaCKBQJfdFB1AhsMAAoJEAYqEBYVBaCK9ogQAKFLRK90
 o/PlhRlUxMZ3ImSX5Oi0no16C1SoROPBOTsrYPYImgdlMJFqDTWdsrFNIS86NBcRWitEEp9v
 vzOIJd3Hf0XKAZpAMufRpK/zdMgjEMT5rMU2mqoPGaDoJpPjr2ldlY+JivXo9dPl2k+HQ+N6
 7UEU7c8Be1E+hIBYotjKsAQXusC+HQp2vZwy2kl9TdSkE7joWO2y419UquSCwGwAgA46JCrf
 grLxgL5UeZ9tO7KxBUmBzPCLbEj4d9u/Y1+r24AEQ8niCm5HyYg5YdPFuLYxD215Eb8dRvJt
 GDL2JH9WZUE45RYgPnSoPVGEHL67iTl7ltQdHtg1ncxMcf+xebQPvtkbRuLVQPDrUxf8jfcr
 dG12bsUqN/Vw+moB4IrAys/lZzVgyhrulbyKOVC23pPL5BiFLUiYw2dzfWa98qhhCx/JRUrm
 /ZNwam+MORvIcR4eW7+9PBC6iPboumcP4Xtj3ENfOKDlTZQuya1FT6rm7hY//enYFVhjqtjd
 q0GH2SgHbzjG1HhMHIT/LqzHB0JxJtBYyFSnHSns8XEIyVZc3WCQYKNhyPkzX2tIBOwZjadg
 GVgkG+LQb2a3WUQmCM4mH+WGMxWrdbOJOywtlguCZxcipt7Gk48cCtgrnbs5Gy6DfbrdqekD
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <CAEjxPJ6na3q8JMrCRmyfs6vLyGRO54CR_=35hQjeNKVBDs1-pw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tyFKZWMWWIohy8UnvzYjWHsj"
X-Spamd-Result: default: False [-6.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_BASE64_TEXT(0.10)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sepolicy.py:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,setup.py:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.30
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tyFKZWMWWIohy8UnvzYjWHsj
Content-Type: multipart/mixed; boundary="------------Onz40Wiq28Pf9S9NR0SozTza";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com,
 omosnace@redhat.com
Message-ID: <a67c0073-3c0b-4002-9c61-6f17e955fb11@suse.de>
Subject: Re: [PATCH v2 2/2] python/sepolicy: add a pyproject.toml file
References: <20260724175059.18960-3-stephen.smalley.work@gmail.com>
 <20260724175059.18960-5-stephen.smalley.work@gmail.com>
 <2fe6f92f-0288-48bb-a49c-8519bcd1ebfa@suse.de>
 <CAEjxPJ6na3q8JMrCRmyfs6vLyGRO54CR_=35hQjeNKVBDs1-pw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6na3q8JMrCRmyfs6vLyGRO54CR_=35hQjeNKVBDs1-pw@mail.gmail.com>

--------------Onz40Wiq28Pf9S9NR0SozTza
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNy8yOS8yNiAzOjEwIFBNLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6DQo+IE9uIFdlZCwg
SnVsIDI5LCAyMDI2IGF0IDg6MznigK9BTSBDYXRoeSBIdSA8Y2FodUBzdXNlLmRlPiB3cm90
ZToNCj4+DQo+PiBPbiA3LzI0LzI2IDc6NTEgUE0sIFN0ZXBoZW4gU21hbGxleSB3cm90ZToN
Cj4+PiBBZGQgYSBweXByb2plY3QudG9tbCBmaWxlIGZvciB0aGUgc2Vwb2xpY3kgcHl0aG9u
IG1vZHVsZS4gIFRoaXMNCj4+PiByZXF1aXJlZCBhbHNvIHVwZGF0aW5nIHNldHVwLnB5IHRv
IGF2b2lkIGRlZmluaW5nIGF1dGhvciBvdXRzaWRlIG9mDQo+Pj4gcHlwcm9qZWN0LnRvbWws
IGFuZCBJIGZ1cnRoZXIgdXBkYXRlZCB0aGUgYXV0aG9ycyB0byByZWZlciB0byB0aGUgbGlz
dA0KPj4+IGxpa2UgbGlic2VsaW51eCBzaW5jZSBEYW4gaXMgZW5qb3lpbmcgcmV0aXJlbWVu
dC4NCj4+Pg0KPj4+IEZpeGVzOiBodHRwczovL2dpdGh1Yi5jb20vU0VMaW51eFByb2plY3Qv
c2VsaW51eC9pc3N1ZXMvNTA1DQo+Pj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBTbWFsbGV5
IDxzdGVwaGVuLnNtYWxsZXkud29ya0BnbWFpbC5jb20+DQo+Pj4gLS0tDQo+Pj4gdjIgZHJv
cHMgdGhlIGRlcGVuZGVuY2llcyBzaW5jZSB0aG9zZSB3ZXJlIGJyZWFraW5nLCBwcmVzdW1h
Ymx5DQo+Pj4gYmVjYXVzZSB0aGUgbGlic2VsaW51eCBweXRob24gbW9kdWxlIGlzIGp1c3Qg
Y2FsbGVkICJzZWxpbnV4Ij8NCj4+PiBJIHJlbWFpbiB1bnN1cmUgYXMgdG8gdGhlIGNvcnJl
Y3RuZXNzL2NvbXBsZXRlbmVzcyBvZiB0aGVzZSBidXQNCj4+PiB0aGV5IGRpZCBwYXNzIHRo
ZSBDSSBmdWxseS4NCj4+DQo+PiBJIHRoaW5rIGRyb3BwaW5nIHRoZSBkZXBlbmRlbmNpZXMg
aXMgZmluZSBBVE0sIGFzIHNldHVwLnB5IGFsc28gZGlkIG5vdCBhZGQgdGhvc2UgZGVwZW5k
ZW5jaWVzLg0KPj4NCj4+IFRoZSB0ZXN0aW5nIGZhcm0gKGh0dHBzOi8vZ2l0aHViLmNvbS9T
RUxpbnV4UHJvamVjdC9zZWxpbnV4L2FjdGlvbnMvcnVucy8zMDA5OTk2MjAxMi9qb2IvODk1
MDMyMzgwMTMpIGZhaWxlZCBpIHRoaW5rIGJlY2F1c2U6DQo+PiAkIHB5dGhvbjMgLW0gcGlw
IGluc3RhbGwgLS1uby1idWlsZC1pc29sYXRpb24gLS1mb3JjZS1yZWluc3RhbGwgLS1wcmVm
aXg9L3VzciBgdGVzdCAtbiAiIiAmJiBlY2hvIC0tcm9vdCAgLS1pZ25vcmUtaW5zdGFsbGVk
IC0tbm8tZGVwc2AgZGlzdC8qLndobA0KPj4NCj4+IGFuZCB0ZXN0IC1uICIiIGlzIGZhbHNl
IChzaG91bGQgYmUgREVTVERJUiksIHNvIC0tbm8tZGVwcyBpcyBub3QgdXNlZCBhbmQgdGhl
IGRlcGVuZGVuY3kgc2VjdGlvbiBpcyBjaGVja2VkLg0KPj4NCj4+IEluIG91ciBidWlsZCBE
RVNURElSIGlzIHNldCB0byB0aGUgQlVJTERST09UIHNvIGl0IHdhcyBub3QgY2hlY2tpbmcg
dGhlIGRlcGVuZGVuY3kgc2VjdGlvbiBhbnl3YXkuDQo+Pg0KPj4+DQo+Pj4gICAgcHl0aG9u
L3NlcG9saWN5L3B5cHJvamVjdC50b21sIHwgMTUgKysrKysrKysrKysrKysrDQo+Pj4gICAg
cHl0aG9uL3NlcG9saWN5L3NldHVwLnB5ICAgICAgIHwgIDIgLS0NCj4+PiAgICAyIGZpbGVz
IGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4gICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHB5dGhvbi9zZXBvbGljeS9weXByb2plY3QudG9tbA0KPj4+DQo+
Pj4gZGlmZiAtLWdpdCBhL3B5dGhvbi9zZXBvbGljeS9weXByb2plY3QudG9tbCBiL3B5dGhv
bi9zZXBvbGljeS9weXByb2plY3QudG9tbA0KPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
Pj4gaW5kZXggMDAwMDAwMDAuLmQzM2U3OGM4DQo+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsr
KyBiL3B5dGhvbi9zZXBvbGljeS9weXByb2plY3QudG9tbA0KPj4+IEBAIC0wLDAgKzEsMTUg
QEANCj4+PiArW2J1aWxkLXN5c3RlbV0NCj4+PiArcmVxdWlyZXMgPSBbInNldHVwdG9vbHMi
LCAid2hlZWwiXQ0KPj4+ICtidWlsZC1iYWNrZW5kID0gInNldHVwdG9vbHMuYnVpbGRfbWV0
YSINCj4+PiArDQo+Pj4gK1twcm9qZWN0XQ0KPj4+ICtuYW1lID0gInNlcG9saWN5Ig0KPj4+
ICt2ZXJzaW9uID0gIjMuMTEiDQo+Pj4gK2Rlc2NyaXB0aW9uID0gIlB5dGhvbiB0b29scyBm
b3IgU0VMaW51eCBwb2xpY3kgYW5hbHlzaXMgKHNlcG9saWN5LCBzZXBvbGdlbikiDQo+Pj4g
K2xpY2Vuc2UgPSAiR1BMLTIuMC1vci1sYXRlciINCj4+PiArYXV0aG9ycyA9IFsNCj4+PiAr
ICAgIHsgbmFtZSA9ICJTRUxpbnV4IFByb2plY3QiLCBlbWFpbCA9ICJzZWxpbnV4QHZnZXIu
a2VybmVsLm9yZyIgfQ0KPj4+ICtdDQo+Pj4gKw0KPj4NCj4+DQo+Pj4gK1twcm9qZWN0LnNj
cmlwdHNdDQo+Pj4gK3NlcG9saWN5ID0gInNlcG9saWN5Ll9fbWFpbl9fOm1haW4iDQo+Pg0K
Pj4gSSBoYWQgYSBkZWVwZXIgbG9vayBhbmQgSSBhbSBub3Qgc3VyZSBpZiB0aGlzIHNjcmlw
dHMgcGFydCBpcyBuZWVkZWQuDQo+Pg0KPj4gQmVjYXVzZSBzZXBvbGljeSB3aWxsIHRocm93
IGFuIGVycm9yIHdoZW4gaW5zdGFsbGVkIHdpdGggcGlwIG9ubHk6DQo+Pg0KPj4gJCBjZCBw
eXRob24vc2Vwb2xpY3kNCj4+ICQgcHl0aG9uMyAtbSB2ZW52IC0tc3lzdGVtLXNpdGUtcGFj
a2FnZXMgZW52DQo+PiAkIHNvdXJjZSBlbnYvYmluL2FjdGl2YXRlDQo+PiAkIHBpcCBpbnN0
YWxsIC4NCj4+ICQgc2Vwb2xpY3kgLS1oZWxwDQo+PiBNb2R1bGVOb3RGb3VuZEVycm9yOiBO
byBtb2R1bGUgbmFtZWQgJ3NlcG9saWN5Ll9fbWFpbl9fJw0KPj4NCj4+IEJlY2F1c2UgYnkg
YWRkaW5nIHRoZSBbcHJvamVjdC5zY3JpcHRzXSB0YWcsIHNldHVwdG9vbHMgd3JpdGVzIHRo
aXMgaW50byBlbnYvYmluL3NlcG9saWN5Og0KPj4NCj4+IGltcG9ydCBzeXMNCj4+IGZyb20g
c2Vwb2xpY3kuX19tYWluX18gaW1wb3J0IG1haW4NCj4+IGlmIF9fbmFtZV9fID09ICdfX21h
aW5fXyc6DQo+PiAgICAgICBzeXMuYXJndlswXSA9IHN5cy5hcmd2WzBdLnJlbW92ZXN1ZmZp
eCgnLmV4ZScpDQo+PiAgICAgICBzeXMuZXhpdChtYWluKCkpDQo+Pg0KPj4gQnV0IF9fbWFp
bl9fLnB5IGFuZCBtYWluKCkgZG9lcyBub3QgZXhpc3QsIHNvIGl0IHdvbid0IHdvcmsgSSB0
aGluay4NCj4+DQo+PiBQcm9iYWJseSB0aGlzIHBhcnQgaXMgbm90IG5lZWRlZCBpbiB0aGlz
IGNhc2UgYW55d2F5IGJlY2F1c2Ugc2Vwb2xpY3kucHkgZ2V0cyBpbnN0YWxsZWQgIm1hbnVh
bGx5IiBoZXJlIElJVUM6DQo+Pg0KPj4gaHR0cHM6Ly9naXRodWIuY29tL1NFTGludXhQcm9q
ZWN0L3NlbGludXgvYmxvYi9hZDdlZmFjZWE5OTdlYmFkOGMxNGI2NDcyY2NhNTg5OTNhMzVk
MmQyL3B5dGhvbi9zZXBvbGljeS9NYWtlZmlsZSNMMzEtTDMyDQo+Pg0KPj4gU28gbWlnaHQg
bWFrZSBzZW5zZSB0byBkZWxldGUgdGhlIHNjcmlwdHMgc2VjdGlvbi4NCj4+DQo+Pj4gZGlm
ZiAtLWdpdCBhL3B5dGhvbi9zZXBvbGljeS9zZXR1cC5weSBiL3B5dGhvbi9zZXBvbGljeS9z
ZXR1cC5weQ0KPj4+IGluZGV4IGNhMDM5NmI1Li41YzRmMmU1ZCAxMDA2NDQNCj4+PiAtLS0g
YS9weXRob24vc2Vwb2xpY3kvc2V0dXAucHkNCj4+PiArKysgYi9weXRob24vc2Vwb2xpY3kv
c2V0dXAucHkNCj4+PiBAQCAtOCw4ICs4LDYgQEAgc2V0dXAoDQo+Pj4gICAgICAgIG5hbWU9
InNlcG9saWN5IiwNCj4+PiAgICAgICAgdmVyc2lvbj0iMy4xMSIsDQo+Pj4gICAgICAgIGRl
c2NyaXB0aW9uPSJQeXRob24gU0VMaW51eCBQb2xpY3kgQW5hbHlzZXMgYmluZGluZ3MiLA0K
Pj4+IC0gICAgYXV0aG9yPSJEYW5pZWwgV2Fsc2giLA0KPj4+IC0gICAgYXV0aG9yX2VtYWls
PSJkd2Fsc2hAcmVkaGF0LmNvbSIsDQo+Pj4gICAgICAgIHBhY2thZ2VzPVsNCj4+PiAgICAg
ICAgICAgICJzZXBvbGljeSIsDQo+Pj4gICAgICAgICAgICAic2Vwb2xpY3kudGVtcGxhdGVz
IiwNCj4+DQo+PiBJIHRob3VnaHQgbWF5YmUgdGhlIGR1cGxpY2F0ZSBkZWZpbml0aW9ucyAo
bmFtZSwgdmVyc2lvbiwuLi4pIGluIHNldHVwLnB5IGNvdWxkIGJlIGRyb3BwZWQsDQo+PiBi
dXQgSSB0ZXN0ZWQgaXQgYW5kIHRoZSAoZ2NjLHB5cHkzLjcpIHJ1bm5lciBbMF0gc3RpbGwg
dGFrZXMgdGhlIGRlZmluaXRpb25zIGZyb20gc2V0dXAucHkNCj4+IGV2ZW4gdGhvdWdoIHB5
cHJvamVjdC50b21sIGV4aXN0cyBiZWNhdXNlIHNldHVwdG9vbHMtNDcuMS4wIDwgNjEuMC4w
Lg0KPj4NCj4+IFdoaWNoIG1lYW5zLCBpdCBjYW4gbm90IGZpbmQgdGhlIGRlZmluaXRpb25z
IHdoZW4gc2V0dXAucHkgd2FzIGRyb3BwZWQuDQo+PiAgIEZyb20gdGhlIHJ1bm5lciAoaHR0
cHM6Ly9naXRodWIuY29tL2NhLWh1L3NlbGludXgvY29tbWl0LzNhMDgzNmI5OGY4NDZhZjM5
ODEwODFiODdhYjczZTVmNWVkM2Y5N2IpOg0KPj4+IFRlc3QgLmdpdGlnbm9yZSBhbmQgbWFr
ZSBjbGVhbiBkaXN0Y2xlYW4NCj4+ICAgICBlcnJvcjogbWlzc2luZyAuZ2l0aWdub3JlIGVu
dHJ5IGZvciBsaWJzZWxpbnV4L3NyYy9VTktOT1dOLmVnZy1pbmZvLw0KPj4gICAgIGVycm9y
OiBtaXNzaW5nIC5naXRpZ25vcmUgZW50cnkgZm9yIHB5dGhvbi9zZXBvbGljeS9VTktOT1dO
LmVnZy1pbmZvLw0KPj4NCj4+IF4gc2VlIFVOS05PV04gaW5zdGVhZCBvZiB0aGUgcGFja2Fn
ZSBuYW1lDQo+Pg0KPj4gV2hpY2ggbWFrZXMgbWUgd29uZGVyIGlmIHRoZSBhdXRob3IrYXV0
aG9yX2VtYWlsIG5lZWRzIHRvIGJlIGtlcHQgaW4gdGhlIHNldHVwLnB5IGFzIHdlbGwgaWYg
c2V0dXB0b29scyA8IDYxLjAuMCBpcyBzdGlsbCBzdXBwb3J0ZWQNCj4+IGFuZCBpdCBuZWVk
cyB0byBiZSBiYWNrd2FyZHMgY29tcGF0aWJsZS4NCj4+DQo+PiBJbiBjYXNlIHNldHVwdG9v
bHMgPCA2MS4wLjAgaXMgbm90IHN1cHBvcnRlZCBhbnltb3JlIGJ5IHRoZSBzZWxpbnV4IHRv
b2xjaGFpbiAoaXQgaXMgYXQgbGVhc3Qgbm90IGJ5IHNldHVwdG9vbHMgdXBzdHJlYW0pLCBp
dCBtaWdodCBiZSBwb3NzaWJsZSB0byBkcm9wIHRoZSBzZXR1cC5weSBlbnRpcmVseSBmb3Ig
c2Vwb2xpY3kgYW5kIHJlbHkgb24gcHlwcm9qZWN0LnRvbWwgYWxvbmUuDQo+PiBFeGFtcGxl
Og0KPj4gaHR0cHM6Ly9naXRodWIuY29tL2NhLWh1L3NlbGludXgvY29tbWl0LzNhMDgzNmI5
OGY4NDZhZjM5ODEwODFiODdhYjczZTVmNWVkM2Y5N2INCj4+DQo+PiBBdCBsZWFzdCBvbiB0
aGUgb3BlblNVU0UvU1VTRSBTTEVTIHNpZGUsIGlpdWMgd2UgaGF2ZSBzZXR1cHRvb2xzID49
IDYxLjAuMCBmb3IgYWxsIHN1cHBvcnRlZCB2ZXJzaW9ucywgYnV0IEkgZG9uJ3Qga25vdyBh
Ym91dCBvdGhlciBkaXN0cmlidXRpb25zLg0KPj4NCj4+DQo+PiBCdXQgZmVlbCBmcmVlIHRv
IGRpc3JlZ2FyZCBteSByZXZpZXcgYW5kIG1lcmdlIGl0LCBpdCBpcyBidWlsZGluZyBmaW5l
IGFzIGlzIG9uIG91ciBlbmQuDQo+IA0KPiBDb3VsZCB5b3UgY3JlYXRlIGFuZCBzdWJtaXQg
YSB2MyBvZiB0aGVzZSBwYXRjaGVzIGFmdGVyIHRlc3Rpbmcgb24NCj4geW91ciBlbmQ/IEkn
bSBiYXNpY2FsbHkgb3BlcmF0aW5nIGJsaW5kIHdpdGggdGhlc2Ugc2luY2UgSSBhbSBub3QN
Cj4gZmFtaWxpYXIgd2l0aCBweXByb2plY3QudG9tbCBvciBzZXR1cC5weS4NCg0Kc3VyZSwg
SSBzZW50IHRoZW0gbm93IHdpdGggdGhlIGFzc3VtcHRpb24gdGhhdCBzZXR1cHRvb2xzIDwg
NjEgbmVlZHMgdG8gYmUgc3RpbGwgc3VwcG9ydGVkLCB3aGljaCBtZWFucyBrZWVwaW5nIHNl
dHVwLnB5IGFzIGlzIGluIHlvdXIgcGF0Y2hlcy4NCg0KYWxzbywgcGxlYXNlIG5vdGUgdGhh
dCBJIGRvbid0IGhhdmUgdGhlIHBlcm1pc3Npb24gdG8gc3RhcnQgdGhlIHRlc3QgZmFybSwg
c28gSSBjYW4gb25seSBydW4gdGhlIGRpcmVjdCBnaXRodWIgQ0kgYW5kIHRoZSBvcGVuc3Vz
ZSBidWlsZHMsDQp3aGljaCBwYXNzIGJvdGguDQo=

--------------Onz40Wiq28Pf9S9NR0SozTza--

--------------tyFKZWMWWIohy8UnvzYjWHsj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmpqHF8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCKCI0QALIs7IIQh3Py7fdBCpTs
/yr3ERUlk05NdkWIuutsPw9Soni9TR5Hd+pAyLcEUaSdmmZsKOPVkz1IUVIKOgDg
zzeJJYVr6NVkHYAl0j9Il5hRAxoBkKc9kgiIyvX3oj31jZ1Irc/waVUBLMOOLURL
lzifNp5vHDgTKimPUFW47N0VzMGdUmV+TPT6HcOX7c9tcuJOxAnrG+7qYTL29qXq
aCDOSyqxK0r68uuyM7ESp7tU3Bw2kZat9K0TeWfgN6B8sqIeoy4offsepbi4j9jO
HegfROfHWr8lwCrJuRporIhUk5iSdDrIsyu+ZK7R3Clrr6JBmYuXCRgwPIIeDOqY
R3Rx2amGGxs6bE1YpE0zO+veNJVni6DR26TScSzNmcZk4yrPM5PiPWNDnHD8Du9z
xJO1htNgAfm9KfHlMmoFIKkgkLPfyvUM1OjCDn+9Us6cO79iNPqkCnrTFEgdespF
aohDMP/+EJpenWqwOUkjBtGxgPFWnufiW7uOxOjIqEKHvSyb7awtdMOugnp+SeAS
ySvG3IMgOrLONa6J0NelWinpXUNe6yRTcmxd17HyLR5RLtgjEtFZCEtYSMJOtqqT
4vpnANF8k6rTqqBi9YsnJw/TGMP48ko2BZbYF5Vp4y7SsRPLrlsE/VOjEf+VP/oG
FeEn071nxfqfKtGDPPT8RTTc
=QzKz
-----END PGP SIGNATURE-----

--------------tyFKZWMWWIohy8UnvzYjWHsj--
