Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA5MtUMY010094
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 17:55:30 -0500
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA5MtTZr008339
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 22:55:29 GMT
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel9.hp.com (Postfix) with ESMTP id 85CC7343BD
	for <selinux@tycho.nsa.gov>; Mon,  5 Nov 2007 17:55:17 -0500 (EST)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 41CCE1D372B
	for <selinux@tycho.nsa.gov>; Mon,  5 Nov 2007 22:55:17 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 248AD134003
	for <selinux@tycho.nsa.gov>; Mon,  5 Nov 2007 15:55:17 -0700 (MST)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QplDw53n9Go6 for <selinux@tycho.nsa.gov>;
	Mon,  5 Nov 2007 15:55:14 -0700 (MST)
Received: from flek.americas.hpqcorp.net (unknown [16.116.100.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ldl.fc.hp.com (Postfix) with ESMTP id A48FC134002
	for <selinux@tycho.nsa.gov>; Mon,  5 Nov 2007 15:55:14 -0700 (MST)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v5 2/8] SELinux: add secctx_to_secid() LSM hook
Date: Mon, 5 Nov 2007 17:55:13 -0500
References: <20071105213829.9361.58157.stgit@flek.americas.hpqcorp.net> <20071105214343.9361.67990.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071105214343.9361.67990.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711051755.13696.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 05 November 2007 4:43:44 pm Paul Moore wrote:
> +int security_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
> +{
> +	return security_ops->secctx_to_secid(char *secdata,
> +					     u32 seclen,
> +					     u32 *secid);
> +}

Ooops.  Luckily I was still able to see well enough through the brown paper 
bag to fix this ... Sorry about that.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
