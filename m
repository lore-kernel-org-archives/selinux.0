Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11230FC23
	for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627677; cv=pass; b=HBOaP8ey71TWdPqVC/TkvE/RNtUTZETIPxDBEj2UsXF9dwbzShW7RKKxVZigMlG6zYQrY7aForRGxSh12kvjvxEWZAr9SxHaWY34XBGJZHg7lc+unWLvQDEIZi3XXrN39IfY9W0b2/alS3cQy/GURgQnxFStp1Aav5PutujCQOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627677; c=relaxed/simple;
	bh=cSO5ddvam+3etx0tA+nKexvNvZkPWOiJ4oLj72nGz0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQVygIfmmGjHQ5g1z4yv2ctJ+3z+d/NIAjTlZ5l/k3Clm+0f8T9pYWRVErDRXs5U8+iqilOsXy21uH7CyamsLAoMk5iv0zjWLCdQxc9YvQhg9oReQh0Q/NP84AEsczF3BfBwAfIo5cn1dnkLlyhHxWQcDkKzQs40EajtAEVSuT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YdaW2WuQ; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YdaW2WuQ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso1100042a91.1
        for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 14:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771627676; cv=none;
        d=google.com; s=arc-20240605;
        b=XE1gS7KIPfgJP00IDSk10RGij1l1Yi6lLDu0YjwhT1tu6rkg+wwFtofqiYWH7DiPBG
         KkTcsW3B7fHkIkJB+VE19ukfLz1PRNU9vdB2u1hnIivO4Ify1p9dhIP9W6in/mwbCkpl
         YzhgL0lWnkXiySLBZi4RGgzG4jJpf2qNN2JVCJYpoMGoB678mo9E9ihU8WnSFksXy/9v
         zkLrSMRqyCuV/GeXwmLyKmXBkU2kwzMKCpbHlhzDIHuGYAJquZRdinO+7y6ZBDluql1P
         OnvlA2NyXyRvOUq7E3nLuygZwp75n6qAPq5riC/CizRUtEGaIztS2R2JiJ83i+cTJwdr
         PnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        fh=uHHNURaDqYguAgBgRH472tP/TzEYBqI7/Mo3MebKSgU=;
        b=P57suCMygsPMUkOhsS0gVBpv/7xbOCv2GjVRJm+gPF5CcYQ4ODU9n/twAq4Uk/lZfn
         q60IPl6XRXG1N5XL/Xf1oMWJ883bNvUSo76rrOlP6fZdOQEPmNaXRGOGZOWPvJFuUQ6m
         3tGPoTV7j3y5gpppXy7oPque6vP3RVDmLSQfZ1GshU3CJuqzCKjJF9AliDgZOyENmPu+
         MgGWNr+9K9ADg4LwvA5uLXsyHNscCLuwotm18bZmoY8b2VbTLIUbWgxpl2u8lnwhwRbm
         1jDiHB8UaqDm0HtcWBEsx/+PvKgGSHkCcJI9YTuxAEv76QogSR+7dBnsd7mpUL8xJy9I
         7xvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771627676; x=1772232476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=YdaW2WuQ41wM5N1ATcsiXfFOfi8o+6IN5OMQAoEAgbdAjJkGfZ63rBEdcJ8rnXF3yy
         zZPc6a4bONe+ldk+YsvYsyF2kj29Z3wp3gNZOieGr1bx02kYKEQmVczXkyhrdPBmsOu+
         02nizDc9/b0WQGtrOR1H3GqDf0CUX/xKMH2X8B4mZpv+1BEK8dbBgL7id+rR5kElX7Bx
         n0PhraKR1StZolJE3zbIKZZSH2znoCletYgDWkfimFsMFY3R/x3k3KRCEkMEvmLYEC89
         hBRTOgyFJXJMoXD0XtDvmQ6JKkjmqmwBDtqojqDUbUMVLPW7sn6eTqD1FLjRPj4//pn+
         8/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627676; x=1772232476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=w6fZnsjMpq1hC4K6DGgu/HjLtMYKIr/N9vRzNWT29areZOPLuYljVcEidQxZoMxQZj
         UE7oxYx4Kg4CTJzwjzd9hRtjUDFjX7co2D18alXQr64Cwv/EeflF5jfF4mlGSg6K0mBA
         2ynYOLVQ82Pd4qAl4gAfeB2LWad2Sg6/34XRNv+ErWSqJHY65LrEQKznalS6UzcHQ6cw
         mr9+xlDGemC7PuQiQmWKU8Y2lWdMlYTMyd5OTpgriojB5FmNVqD9hWNpBaup92zVR0/f
         NAwR5oK8/IYU7ecG7bnJMOCoW0ywoVrDKaNIwZISaW1K1BcRWB/7FmDp9qdML/2pL7UN
         0Rtg==
X-Forwarded-Encrypted: i=1; AJvYcCVk7sb0vLlFWDis7BLCRfzM1RDB89XIr+pYe19K+QEb1vhXcvFeD8j1Ycf4ZaCmRCXfYYZ04PDI@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRVDxrMFY3g+RusFwSQ+11ZYRQ7BoRv8vvngYW2TFVnHpeVTl
	wfIRjA3qHNv4gskLBen+dPcf6URkDg9FQTZvGiyaSRLluvrBVeki5HX3UFrpQrCWGJUUjJOuQBC
	6HU7aEdSNTC8WnxS8SIr4uyKFo3KRtoNHPqZ3PIpG
X-Gm-Gg: AZuq6aILOUOkm0fslIkADvT7DLMmVqkhoYQH15+w3sW108aqly3ej5O/l+P3K3QzPpU
	lWRJDxjs7nBbU5C6u5BZ+iNzd9Nrs41s5VuSm+Q2xYUGcEMK1Bpv/sb9q9jtAt0+au8wFjdi8gX
	aIetccL2eC5wc3cDYT27i9iPkuY3KhLbMN9GU5oiXXPlchBP9WC7pEEBcWroBQnVNB7eVt4qK+o
	yX+jrQd+9PDnaBIM6b52BhTs1jG6RdmYshpdyEfjPtJPMes/5DK/QW1gOOe7994TrvYbCHxVRgC
	w4sDAik=
X-Received: by 2002:a17:90b:3a08:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-358ae8c0983mr894544a91.28.1771627675691; Fri, 20 Feb 2026
 14:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-6-neilb@ownmail.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:47:42 -0500
X-Gm-Features: AaiRm531rz23NInLiaMybHfJxR35OGBc7KTvM6WC-U0WofFc5pma3F6ygsFUv1A
Message-ID: <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup.
> The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds.  Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  security/selinux/selinuxfs.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Unless I'm missing something, there is no reason why I couldn't take
just this patch into the SELinux tree once the merge window closes,
yes?

--=20
paul-moore.com
