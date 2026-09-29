Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F9D35200C
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697896; cv=pass; b=kCOege36R8ch90Ba5eiTa7y/9SSoOCmYAkdPmHikI//LdwD6GSRzpfa8gRCwPFdyMrsDRxJQoqeBTNLw8+yZEZZWcDhe1+IzpyXBm1dW7KQueKyUpDIW58H8hcFh7QlRryB2VsQNFSBP5UUVC15mu7BEd0diDxi39Z+1eLnb6no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697896; c=relaxed/simple;
	bh=UuHjb18il18eWa/+6oomqRYYhdMA4K2phzLLc+8kiS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWv1MrlMV0Q25OgIBwoYBEWE5crcCz7uVZOx7MPk7uVE/lwatlGWS8XDHg68iaOVjnlmulyHXCs0fcFqYvh4MsYXgQXpU5qup2OgmDNHQttvEvqV7C0tc/MkIIQfTl8GdoBep5K9fSO2MIpq+MjWzdsQQ8CqmGl0zMuhLNrDN9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfI9UAIH; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfI9UAIH"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3fa8a788so11370527b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697894; cv=none;
        d=google.com; s=arc-20260327;
        b=JTRfRSUjPHqsIzGyN4iv+1mtnVQfGqXbEVnZK0tZt3MxWe218D8ET9cCbQHEs+Abyz
         PVIj9OE0dAOWypVR1NzXPz6K/DpoZuuXo6IKiR+lzchz7wCFGlQfP0apww3qrEtXiirE
         N5mysNMDCtwlYKMK0UkLGOWhZSZPH1tCDTNjapR5J84I2bN3dfsvkc3jHJG4Yi5VjPH5
         S5vm4KNdw3VkTv1EsFumhoFDfQoBv1V5k2xntehc12kiTlmicz7bmlF12WyJxB1z6IfF
         qhXwiwsbnYaYgXFOKMomVmTBlJatrIgBGTpBRESM41pKg/F+7nnFe3STxpQhMhy44r+7
         iQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UuHjb18il18eWa/+6oomqRYYhdMA4K2phzLLc+8kiS4=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=Lvru+p7GzexRfz+mRjr8AzMG2rwk//7EkPvBxRF7TKnR159x9adXGjvNzdN5KXZrxA
         5fHng1Elrb8txWHkh+PFiJMvGLvNTb4GoGvks4JnEO8sRluhepaaj1OQb0JcOutAKYfO
         hY/lyxzoTJL1dT837Ic11uWLZQUii00SclMdMPWLG2tT5B8yRNTCmEAPcocoRFyVWyNm
         tSu/eg3s3pOlfJVg5ASVgEb936IQy6iNUP0ESjfsrEZugDe6Zq8VeF/xuapnxQzBEOpL
         S5Fli9KVXB+DpVmQgBw0Wi6O+x0Jx6RIgq6YRG6hCNIAkHE9EAp1YA44aqn1jbNyVaRF
         g/eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697894; x=1791302694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UuHjb18il18eWa/+6oomqRYYhdMA4K2phzLLc+8kiS4=;
        b=pfI9UAIHx18F22ks42lMVHcGCJ2tpjMuxH4exnrchzgngSrMjpz+dDT+5DRTBd1JL0
         +Zn1k41D9+fDgxH+y5eUxEJn/goj9ZNmB9lWYv3Gr2h6GpWVod4CoUWU0qHb2gde/YBt
         xSQJQXyOcpwd9yVmfOfHHvrVi0sWoMI06pN8ctDKb/H/oSme8yx3sdLShlAhaYpp/nxF
         4BCf2na8d81NOC3ftzk8Xb4t4H+U4Gci7skBCLfSdmaH5kG0B3zT4Q7BJbCIuo99FuuP
         k7Z+L6vsIGLN2EfcdB0ix+P94kly6qV3eY2Pnexd3T2JBgqbI3AAsyB594Zqy501Z9oW
         rRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697894; x=1791302694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UuHjb18il18eWa/+6oomqRYYhdMA4K2phzLLc+8kiS4=;
        b=qqYHlYKdJgm+VsRowGdoryHcLtjcuQv7lJlV8vc3/qoays2xbZrKIq7phe/UdLyL2o
         Z3220m+x5IhtVCEf1+VorTFlalFQ2R9OKcFX3ULUrGLf3W+Hk6a96nxNrlmRybmPBPpk
         VntELNu453c3j2Ju/zKhBgs06NF25/2MWTD681URhIXTxxSz/Un2GRrsTu8eaxffwERi
         kmstEEHN5x3YWH2ozSHf2258qGU/CK5LkF9GGaZK3AErKdWl7IDT3dSOeLerIT4TzUgx
         I2dWmAcPEwT75mNszR4vLv/XrTcE5dAi2MCAHlcBjBeiQ8mwExhHqTzhvD/HnRZH8I6L
         0HZw==
X-Gm-Message-State: AFq9FYI6TGa1PYaWEhoNMgmtVQAb/aqsAQ/w4SHLQTXjyisq+CksQ9u5
	ynRg0c5m9NFeK6iIsAx5Lrv4E2Io0p+rHb4vqXxTb/moqaE3/R96zUpd+ELD8HUWMoXMG6FQYgv
	qxWEbGBTlMgcFOXbsdKKYRPczMwABKXFNv4Bp
X-Gm-Gg: AYBFou289gTVgC7mYvqFVEivnDfwIGUA3o04GRE2X82CCZsfpSgpeoxOX9PttMHlbxA
	QCm1feYC5y6BNw46ZeceCR8nWsuI7Q1WZpflmOxD329V565yW8aqYnuwPbLne2BDmj+wIT0Vwns
	yDL/AQTIV8pHmEQLvt1T9Lpr+JIYBg1nBM9jY1hdVu/OpY2BuwOLC1421/Jza/hmheCBjNvba+A
	IOY37FKUbNzJuBYWEUKKAXMTWzdlwU0EOs3MlHKnTpEuNnEU8vzbJVPqRx0HVeY1DL5PyHfyKZv
	nsgz7VYqb6HD8Q0WtmysLHgQ/BXEHsjUBSmaazfhAPrJEbhH+x0fkYE=
X-Received: by 2002:a05:690c:348a:b0:8a8:85d7:265 with SMTP id
 00721157ae682-8a885d7c7f1mr47203367b3.36.1790697893970; Tue, 29 Sep 2026
 09:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-27-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-27-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:04:42 -0400
X-Gm-Features: AclHuK9ZKxKC9pW_RH8J1B2riPNmGcGxZxNllvXaWrwIMC5DxuXR6Wdbk7p2oDY
Message-ID: <CAEjxPJ4VKGUrJzq=wbNndCJTdw5q-dC6RcBZ2w8g7Sy=xuAtLw@mail.gmail.com>
Subject: Re: [RFC PATCH 28/32] selinux: pass inode number by value to sel_make_dir()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> sel_make_dir() and sel_make_swapover_dir() take a pointer to an inode
> number counter which they increment and assign. This forces
> sel_make_policy_nodes(), which wants to reuse the inode numbers of the
> existing booleans and class directories, to set a temporary counter to
> the desired value minus one.
>
> Pass the inode number to assign instead and let callers increment
> their counters themselves. All directories keep their inode numbers.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
