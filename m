Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969293AB27F
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787437; cv=none; b=L0se3HD9IcOUgUu1EcEV9A4vIz3NTEqfDQEoNHgz0xwiMglnhqfWGRPLMo02Fj3d7CAsGf6nsykxLVNU15HGbfEtBNUEeJ1obh9QNmpLKQRwKUqfVjFgiL+HS3sIcYVSQcF2FailZVidE18UXP49FfKMCCTO1Js863blsi1vUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787437; c=relaxed/simple;
	bh=UocPPSy64iVBry4L1IRP5elr7tlVgUQYhuZ5TiyZ0QA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=XjHsKNUWBcu1fA2nIz6XdDcvEgxxjLhkvkFrcQwc+HGJ/p/JowR6rSR1j8SROd6WdqHghORpygIhEBRclV2p9ukPVCYRNKRx/iH6yo0aUvdzTpJtnH0JHIH+xx9XnQO76wqcLZ6YspYw927Nx/kw+GYV5EqQrdL09yq3au8Bax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fshmK3fa; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fshmK3fa"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c05dcdf49so40482351cf.0
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785787435; x=1786392235; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQnkkq3ZYIQjsF1ZWL94ik6EYBuBLNxIxpOXmwtwvfo=;
        b=fshmK3faAenUBezq4tOxI6yZR5eZHGB3P8inhRRoGsVQmWTfR3dW2szHlHP3/uStX4
         xQc3+COQDmKhPDzLZ+vNw8lUjNu7WSnJXwGTpFUbzbJNfztcsCz+0t8suu7e2/NpAzNt
         6GPPsS6P6NWRKkDpE7AWMzJ9ynixjczrROgFN3rJ62x3vKQRblyvQvjRPqrVkcQOjo3F
         /APOTro8aqak7+4gQWpbqRWxmLQ6qvMNVd93f7uENmgKIQu7Q31QWM0eCwXyyK2Xr4NB
         xpEkO+PZ0Kveq0uIMq6ymKCq4gZiVNw4sMlSI3GlMdsNfXbp0Qh97H/FnvAqEXTqoCl9
         AoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785787435; x=1786392235;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQnkkq3ZYIQjsF1ZWL94ik6EYBuBLNxIxpOXmwtwvfo=;
        b=hivzRd+QqGoRoCOgHJFhWMsvDXlcvcq/F0Ku3wG9CzKJITS3yRlso3GiS2N9NFmJDF
         RcQlSu0Lvg/8fdvcJza09H1F6WcKPYBfckvAm9vQjgeo+wgPezzY6un4QRY7GPLnIEJR
         NKzMy6GMwWpWe8WSM8mawwpXGJeDKxlO6SMb+k4jI0cDCwoyNfEKngJ8adLxtNJi7ZUL
         zXl0HeznRa3VipY3ONcVWW2phdjhsPXLG/TCyp/Fu3NjqQ9ZxepG7/xtNJSR5vbTivFa
         I3CPpo/6SrNqyvma/AqfphMDe8kvzife98XOtLy6F5SUeBUzDENEPilmT94RsoMY4fGr
         RiPg==
X-Forwarded-Encrypted: i=1; AHgh+RrfFE+RLMbFD7H287UrB1+HzOOLDinxlF7NIQWsRjHgvUMvhjnsxs9HZH7S36E8EOnQ8PdWuSxW@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFs64HBcJv115MhrN202gbSHL8fcbXYdr7fBxb+H18gDHsCYr
	xTLLe39zho9d17b9G1bGHdTr1MxadSkKlzzdhWxNIyN3B6saDkBtNnlEjhr8PBOeTJALaH4WITX
	MoMG3Rg==
X-Gm-Gg: AR+sD11ixnEP4OkY/5zCXi/ie90y2tbYxKB7Ceu/Fff3TJa5cUmtuQyWGNRGEuhLrIh
	w3XXSQKXONWXvSpK9uZXQm8Ukr+mhcWLdyTn9srTdaZyEfIDMIa7GUWTFU+9vzdB6BNMGlKbums
	bgQMZoCyNGxB+CKycSZNbAO5It3JWY1acnk0CdAAMvPcyf1eQz22BnPK2ACaJGW3Kpy5Tw0l/WA
	o7Ct0TCVAX1WA4InXpziIUESAWQ18MCNLda/KErHUHe49qeyKWkA5l2CQUV3vVUT3NP6ffm2O6U
	YRy2+77E1u8KZmkAb8MsY+BAo0jkMHKp0qalsDzHnwtmxTJG8+wm8bol8H63GilXinciw6A2vRq
	8TvL3tOufNWddaA5EpBGvzj+vGR01npYpXd0mOGUKndpLUWkP4Sa2gcWbDTvPUQTaEviNNbZgE1
	Y4EdU7ctsBvux0Z95UDeg5+zVvFWAwTukS+G82GaenRJsMcBupehM2VXQsL5QoJ1Oq6zvAg/aSQ
	CKXBZpBZIcy0Mr4aK3hjoFnHd1DAoZ9GQ==
X-Received: by 2002:a05:622a:103:b0:51a:6feb:dc8a with SMTP id d75a77b69052e-52b566ae942mr216625471cf.18.1785787435406;
        Mon, 03 Aug 2026 13:03:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4ebe0c1fsm67016781cf.28.2026.08.03.13.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:03:54 -0700 (PDT)
Date: Mon, 03 Aug 2026 16:03:52 -0400
Message-ID: <f07bba9a6608ce54879149d91c152e1f@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260803_1511/pstg-lib:20260803_1500/pstg-pwork:20260803_1511
From: Paul Moore <paul@paul-moore.com>
To: Bryam Vargas <hexlabsecurity@proton.me>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH 4/4] selinux: require every boolean value to be defined
References: <20260731-b4-disp-d32e997b-v1-4-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-4-0341d038ee47@proton.me>

On Jul 31, 2026 Bryam Vargas <hexlabsecurity@proton.me> wrote:
> 
> p_bools.nprim comes from the policy image independently of how many
> booleans follow it, and cond_index_bool() fills bool_val_to_struct[] at
> value - 1, so a count larger than the values present leaves NULL entries.
> Every user of that array then walks it by index and dereferences each
> entry: cond_evaluate_expr() on the access-vector path,
> security_get_bools() and security_get_bool_value() behind selinuxfs, and
> security_set_bools(). A sparse class value is absorbed by
> policydb_class_isvalid() and its siblings; booleans have no such
> predicate, and no consumer that could use one.
> 
> Reject a boolean value that no boolean defines, once, where the array is
> built. Conforming policies define every boolean they declare and are
> unaffected.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Merged into selinux/stable-7.2, thanks!

--
paul-moore.com
