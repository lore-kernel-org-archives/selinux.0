Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083901C862F
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077267; cv=none; b=Ns1gPGMml9W4OV02M+iYjls8eG6+mvT5DlqnWAQdcaKPtFQu53hBZBj/AsXFpW6zQ6Yx41wo/+wJ0CggiSgQY72O3ttEC9+svR0GrafFfqmR/5W+366gbdcPJMIzZ1CDQBVX0KUwjDl1CVEQ5IaLJu+6dtmLYFIKCZyvYfMNQSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077267; c=relaxed/simple;
	bh=Cy17OANlRLomoKobnUjeQzQqngyMIEAwswTdLB1tCTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMjl4Fs3g5Qs0IVNC2f16dIPTOAaGAEVomIz2qvtQURXvkmJzQqpGUvOozJvIs12xAOaEhVz91/l+O02mVPZk9iYKdX1VzDdLbhBLDAnJVQuUpn+5y6Bn/qc3m0TYvg90GBcqY91FURVVaAV1LevaT25vkSvR3ts/kjoUr/pVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DGi7FwgW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9QrrOn4; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DGi7FwgW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9QrrOn4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DCC91D000C6
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 11:14:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 11:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792077265; x=
	1792163665; bh=SQEYBdRDNCml6Q6WnYSuut+c4d9tR/Ztnevu49o5WBU=; b=D
	Gi7FwgWJYDItRN4IN1FWNCz0BNV/Rqg8qortATqk00QNX7UuPqDkzD+ZOlJzeIM/
	gsJa6iisY+Gj39Fl40g0FVfckxpMbDKFF1MnIn5y7fijzG6P7FXPBIh64etOCfWD
	SIb/uzB//JUXSKtYEkb3czTth/w9Vrn+Ec0Vcj1ruk/zZ2K8aRNeXVX4qIEXinUg
	UtEvrVlKz6Ym8dWiD5xQqaD6RqI9rBEc5kPzVrLi46rJDvtNGxXfCFvDrhGZDc/g
	ZZcBlvhPHpXpu+XW3TalKAdwBJdx9P2JTL0LqrTQO9ukcPsz4ykt8yvjHUk6Rndo
	SXlmt0fwGiOuPRdwJCRVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792077265; x=1792163665; bh=SQEYBdRDNCml6Q6WnYSuut+c4d9t
	R/Ztnevu49o5WBU=; b=c9QrrOn4wZb+E3wsHBFycw5M8Q6le7kTecVTSRr6A3VZ
	OdRJ0PAoCfz24yiActt+WKGI7IX2hYLicGTuu1K8dXzb8X1fDumlvX3BOF2tsAxU
	ruonGSr8j9/zVPhNDHDh131L5iwOWpa728neRc5DORCzoXAeeyeVatHa9UUcfQq8
	RtVlOIIoWVdzjo4Xutp3qIXZkxUEgJkEzMFYE+ZRQbx9Wc8OXD6P77L1WH9lWteA
	uGeuAxp/RYAtlGhwq3Ktw9KJ6s1hLD15E7LGpoqCDWauwwF1lt0hUVBVaP2ibh2s
	sx7n9LeI2SqbuXr+cxYz+xcFICDEUk8YFsqcRi2kvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792077265; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+;
	rt=PHNlbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:bRHcm8KmLAcd94L65VrBrgtb3AdSJVaQjtD00IdAiynoUjh
	yaHBC4NTNNJ90kWauxhEHAiuBUN6d6QCPHCbswIJ6ThfDg+OXp4Wd/UqE0eKNy1Q
	Qr9t7xDZR80ULzJPseu4Ye9ctIfIVJ1INMwFuF6sMj40RoO3/bLZCDN2jyREbaYa
	qmBb8GqpSgRBvUR9Ws1DehItDH5wI/Nt8oHznpGcCe/72nJ1xLZt+Khka1MRHyMT
	d1VS6N3/1EvS5Oki2TI/YcewfG9Kw9L1VPUNaX6WCrHkms0q51H09Lg8cQ1hYhT1
	NZuTbWLou2+nmNNPwva0Eq7TDzYUnW17G+edrwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BH6feWRbobCk0lSEPnJff4j418RSW/pgSFTDU7lrkQw=:Cy17OANlRLomoKobnUjeQzQqngyMIEAwswTdLB1tCTM=;
X-ME-Sender: <xms:0e3QatMbYll8S7Hp4Ji-pJmdwFlY-d8-MTFX6ji_8M0nYX8RGc_8Pw>
    <xme:0e3Qam5_6XpmHc5uOEDAW6Lr69QKRlgtaTwr9cs6k-59Vl-jHh3CKqQMYwmYfKlHP
    aDjmtfCOqVYJyeDssUlTNdwlkMwuUbH3ctG5nar7QvxZU0aj3nkcVU>
X-ME-Received: <xmr:0e3Qah6Bcndo8U8RRNb3kfZEvlqFvVfaWj0wQafSL_qxsdaiEZHjRvraDD-gcI4DsREjXCR1Ikfg6OPfFNsKZ4eVbHmoO5PU69IjPSr4GC3wGH7MsnSHY90JCFEd2CDin9ciChcMkzEYjzH9>
X-ME-Proxy-Cause: dmFkZTGvzYVLZxzBED0c/WpDmVurWCaMM6ep2gLBg1hhNFZvr6fTbGhlnNWkPSFsU+PAda
    ufZ7IroiJh01v82kzwapurO3ZXqAIJ10Hfi3EQ6+2MPyD9QM6pbYp/y0UUC49PSDTVi76/
    C1b6XKXcpf3UKKowKmlcp9skOXwi15Sy9CWplUq73Uqb1vDYsprRXjdgcqphhH5EfuV/2y
    T0GmRVHkrqu70dGKxBeUzc1XeSr1SMHIlVyYv5shaQSqx9ORInpy1rU0ksHB8g1aTz+3JM
    I7pXTe5afxOqq5q8xAhc+d3kuN6uJYGySEr5ap+/or0HHKH7GhUiVtR4cwcXs7C2YNrFTY
    zbf43Hg41oHjxrUxNoTL55h1hgzWl5u3Khs0LWxmrvIQXGjQt0z0x0YU8VngzgfNXEGy1+
    nO+VSjpR0algg4jgDkZsMAAk5RXhUtbDFg5EvpU4ihe2/KQLHWVxlHapd6laBkZBLdHb1h
    ya34oubxEbWJTJiZ3ZBpqAukoTcMTBlq4W5a1oJSSqQH3mS/Bx98CzzPNLeOM8xX1jndiO
    JttUteFwPY6qlS82jy66OBnXosMy+yLMLoALDKctIuTx0cILq62Vo9uZKpIIEH+GSvAOKC
    WhkJ1ou+897V4QbazgTZNybjRzoAg5D/MQ0BmppINPlpEGSJHkbvuRtLDjgw
X-ME-Proxy: <xmx:0e3Qau1u3y_qJY7PEsPKOTJXNRaJLdd4n8u75lmSYUi7TX5PXQ6dcg>
    <xmx:0e3QalUebIkEgixaEUJWl1hD9NiY6CDuYbSvCFEhkWWeZDUc_fiM_Q>
    <xmx:0e3Qah41UBSdAq7wwz9nXnn4SY2ckHpe819kRXq3dMgsiz9Kw4tePw>
    <xmx:0e3QakKbhsBCJoT0OOVQ3rGu5TIl0uOlkykOLT7FEoWsjeMDgVCUuQ>
    <xmx:0e3Qap9T8Wsu_8vJFuZIWRnJMvgq9X9It8lyx4f1Bd0eAGgpiFYi-nXw>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <selinux@vger.kernel.org>; Thu, 15 Oct 2026 11:14:24 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2 0/3] libselinux: sefcontext_compile.8 updates
Date: Thu, 15 Oct 2026 11:14:17 -0400
Message-ID: <20261015151422.1057210-1-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015014457.877322-1-tmz@pobox.com>
References: <20261015014457.877322-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed a few missing entries in sefcontext_compile.8.
They are included in the usage string.  These patches add
them to the documentation.

I believe I've fixed all the issues noted with v1, but we
shall see.  Others may turn up still too.

Todd Zullinger (3):
  libselinux: add -r option to sefcontext_compile.8
  libselinux: add -i option to sefcontext_compile.8
  libselinux: add -V option to sefcontext_compile.8

 libselinux/man/man8/sefcontext_compile.8 | 25 ++++++++++++++++++++++++
 libselinux/utils/sefcontext_compile.c    |  4 ++--
 2 files changed, 27 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  2c228939 ! 1:  f422645c libselinux: add -r option to sefcontext_compile.8
    @@ Commit message
         regular expressions.
     
         The man page was not updated for either commit, leaving this option
    -    documented only the usage string.
    +    documented only in the usage string.
    +
    +    Update the usage string to include "-r" as well.
     
         Signed-off-by: Todd Zullinger <tmz@pobox.com>
     
      ## libselinux/man/man8/sefcontext_compile.8 ##
    +@@ libselinux/man/man8/sefcontext_compile.8: sefcontext_compile \- compile file context regular expression files
    + .
    + .SH "SYNOPSIS"
    + .B sefcontext_compile
    ++.RB [ \-r ]
    + .RB [ \-o
    + .IR outputfile ]
    + .RB [ \-p
     @@ libselinux/man/man8/sefcontext_compile.8: that will be used to validate the context entries in the
      .br
      If an invalid context is found the pcre formatted file will not be written and
    @@ libselinux/man/man8/sefcontext_compile.8: that will be used to validate the cont
      
      .SH "RETURN VALUE"
      On error -1 is returned.  On success 0 is returned.
    +
    + ## libselinux/utils/sefcontext_compile.c ##
    +@@ libselinux/utils/sefcontext_compile.c: err:
    + static __attribute__((__noreturn__)) void usage(const char *progname)
    + {
    + 	fprintf(stderr,
    +-		"usage: %s [-iV] [-o out_file] [-p policy_file] fc_file\n"
    ++		"usage: %s [-riV] [-o out_file] [-p policy_file] fc_file\n"
    + 		"Where:\n\t"
    + 		"-o       Optional file name of the PCRE formatted binary\n\t"
    + 		"         file to be output. If not specified the default\n\t"
2:  fdce522e ! 2:  b9797123 libselinux: add -i option to sefcontext_compile.8
    @@ Commit message
         The -i option was added in 487d652e (libselinux: sefcontext_compile: Add
         "-i" flag, 2016-09-28) but the man page was not updated accordingly.
     
    +    Correct 'info end exit' to 'info and exit' in the usage string.
    +
         Signed-off-by: Todd Zullinger <tmz@pobox.com>
     
      ## libselinux/man/man8/sefcontext_compile.8 ##
    +@@ libselinux/man/man8/sefcontext_compile.8: sefcontext_compile \- compile file context regular expression files
    + .SH "SYNOPSIS"
    + .B sefcontext_compile
    + .RB [ \-r ]
    ++.RB [ \-i ]
    + .RB [ \-o
    + .IR outputfile ]
    + .RB [ \-p
     @@ libselinux/man/man8/sefcontext_compile.8: Omit precompiled regular expressions from the output.
      (PCRE2 only. Compiled PCRE2 regular expressions are not portable across
      architectures.  Use this flag if you know that you build for an incompatible
      architecture to save space.  When linked against PCRE1 this flag is ignored.)
     +.TP
     +.B \-i
    -+Print regular expression info end exit. That is, back end version and
    ++Print regular expression info and exit. That is, back end version and
     +architecture identifier.  Arch identifier format (PCRE2):
     +.br
     +.in +4n
    @@ libselinux/man/man8/sefcontext_compile.8: Omit precompiled regular expressions f
      
      .SH "RETURN VALUE"
      On error -1 is returned.  On success 0 is returned.
    +
    + ## libselinux/utils/sefcontext_compile.c ##
    +@@ libselinux/utils/sefcontext_compile.c: static __attribute__((__noreturn__)) void usage(const char *progname)
    + 		"         if you know that you build for an incompatible\n\t"
    + 		"         architecture to save space. When linked against\n\t"
    + 		"         PCRE1 this flag is ignored.)\n\t"
    +-		"-i       Print regular expression info end exit. That is, back\n\t"
    ++		"-i       Print regular expression info and exit. That is, back\n\t"
    + 		"         end version and architecture identifier.\n\t"
    + 		"         Arch identifier format (PCRE2):\n\t"
    + 		"         <pointer width>-<size type width>-<endianness>, e.g.,\n\t"
3:  738e1a7d ! 3:  bbeecfb0 libselinux: add -V option to sefcontext_compile.8
    @@ Commit message
         libselinux: add -V option to sefcontext_compile.8
     
         The -V option was added in 92306daf (libselinux: rework selabel_file(5)
    -    database, 2024-11-05), but the man page was not update accordingly.
    +    database, 2024-11-05), but the man page was not updated accordingly.
     
         Signed-off-by: Todd Zullinger <tmz@pobox.com>
     
      ## libselinux/man/man8/sefcontext_compile.8 ##
    +@@ libselinux/man/man8/sefcontext_compile.8: sefcontext_compile \- compile file context regular expression files
    + .B sefcontext_compile
    + .RB [ \-r ]
    + .RB [ \-i ]
    ++.RB [ \-V ]
    + .RB [ \-o
    + .IR outputfile ]
    + .RB [ \-p
     @@ libselinux/man/man8/sefcontext_compile.8: architecture identifier.  Arch identifier format (PCRE2):
      .br
      .in
-- 
2.56.0

