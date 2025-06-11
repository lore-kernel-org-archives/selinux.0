Received: from smtpcmd11116.aruba.it (smtpcmd11116.aruba.it [62.149.156.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF292874F2
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647726; cv=none; b=IP/EbBRFcLr8jXZiXPiRMqyVfST0L+c+TlRAXhJONr/O/2lrtPP0WNlgp6+WSNiuA0P7MpvdFiqqRBWOUEaXUPcOuK4SteLf46vldUC3mIeJRXdTT+y7SJAUjeXDZlSDiDqr2GFH70BPt63Z/PMAW7DsCOikKzxUI1BfZyLtl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647726; c=relaxed/simple;
	bh=LVhbpwtJh4SxLSArt+nB/5pbJ+ErxOIl3EaudxNDMOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=kIFWk3umD7Bc8PbPrPsofv/rzmM7nSapEi2/EHoGEvDz9lF+hDU6eZPi0K3o9myhlVkAnVQmEb3rIb5fs+oSxHLq+7cHmhGV0YKzwGpro25tD9SdBoRt50IufuaxtZM1j4xZzym4r9Vt4u2J4WnS/vRHToB8qCuit9+HYjFOCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=UjH0oybM; arc=none smtp.client-ip=62.149.156.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="UjH0oybM"
Received: from [192.168.43.2] ([109.54.115.248])
	by Aruba SMTP with ESMTPSA
	id PLFUuikh7tr9dPLFUuTLfm; Wed, 11 Jun 2025 15:12:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1749647533; bh=LVhbpwtJh4SxLSArt+nB/5pbJ+ErxOIl3EaudxNDMOo=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=UjH0oybMOoboEppdFOOhPCVNr4HCwu/scaT/KryfHa7AUIiUu9AvEB04REpkuuwPT
	 dS2chSoFsoQFazJ0ItnBu+8swti0wMUqZ1TImxwW3Cw7BnzAZalRIy8yyC7EVi5dwj
	 tbhXQjgQ/bYwnuALW77PoX/JUycVV759++dOdv7rNi0HleK/hfh4hhmVu98Py3GUOV
	 hdU4C3XJ5+4YEuBlcyxwkr7aM5gKBPalE1UBf6vgOY3uQ29PTOdn+vk+zms8p4arh2
	 uu3RZlL/1hYdInV1h2BsdL3g+T0tOO6q4d9c/8U5G4M8rUGx7LpVDUMoEmP84OYOWV
	 1R3Wo6O2fuq9g==
Message-ID: <1749647531.6091.5.camel@trentalancia.com>
Subject: Re: [PATCH v2] selinux: change security_compute_sid to return the
 ssid or tsid on match
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Date: Wed, 11 Jun 2025 15:12:11 +0200
In-Reply-To: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
References: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMA0oZNBonW5vd7MqOl8Qpa01JVlliQ5v/GKEy6fmWGZDPpDwS8iJnR4WsOp0Gv35Um66NNtPJWR1SUYxMKz5PKXsfBoOQVCBXAkLFybXh65xmxNnCc/
 jBlfy119Xz1rOMU77POi+mmoYv1RrUFgVazvSAZYDuibtF4edObc7CcOR26GdA4vaZvTeHuKlwLM780ZltV0MkWHEnCiAaLGiahK4rgdYeFQV1OcaE2XVNLJ
 35EEmC0Ra6OKL5wABp1eiZfSq4XrruFeeYf6zVU5XVWlAmYj9PVBI9UmIHGAYKYstJzVzooTtDbI4gRZR6FYDw==

Hello,

I have just tested Stephen's patch and it solves the problem as an
alternative to the dracut patch and other patches posted here along
with the issue description:

https://github.com/dracut-ng/dracut-ng/issues/377

Please note that I have only tested the success of the boot process
with sysvinit and not other aspects of the system functionality, other
init daemons or regressions that might be caused as a result of
applying this patch.

Guido

On Tue, 10/06/2025 at 15.48 -0400, Stephen Smalley wrote:
> If the end result of a security_compute_sid() computation matches the
> ssid or tsid, return that SID rather than looking it up again. This
> avoids the problem of multiple initial SIDs that map to the same
> context.
> 
> Reported-by: Guido Trentalancia <guido@trentalancia.com>
> Fixes: ae254858ce07 ("selinux: introduce an initial SID for early
> boot processes")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes a compiler error.
> 
>  security/selinux/ss/services.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 7becf3808818..d185754c2786 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1909,11 +1909,17 @@ static int security_compute_sid(u32 ssid,
>  			goto out_unlock;
>  	}
>  	/* Obtain the sid for the context. */
> -	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
> -	if (rc == -ESTALE) {
> -		rcu_read_unlock();
> -		context_destroy(&newcontext);
> -		goto retry;
> +	if (context_equal(scontext, &newcontext))
> +		*out_sid = ssid;
> +	else if (context_equal(tcontext, &newcontext))
> +		*out_sid = tsid;
> +	else {
> +		rc = sidtab_context_to_sid(sidtab, &newcontext,
> out_sid);
> +		if (rc == -ESTALE) {
> +			rcu_read_unlock();
> +			context_destroy(&newcontext);
> +			goto retry;
> +		}
>  	}
>  out_unlock:
>  	rcu_read_unlock();
