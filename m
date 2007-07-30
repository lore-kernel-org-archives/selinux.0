Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6ULS28C022726
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 17:28:02 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6ULS1T4012964
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 21:28:01 GMT
Received: from smtp2.fc.hp.com (smtp.cnd.hp.com [15.11.136.114])
	by atlrel7.hp.com (Postfix) with ESMTP id 8C45E37139
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 17:20:03 -0400 (EDT)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 0659F193626
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 21:08:29 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id DDD1F39C194
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 15:08:28 -0600 (MDT)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FSiQ3OP-tYIL for <selinux@tycho.nsa.gov>;
	Mon, 30 Jul 2007 15:08:25 -0600 (MDT)
Received: from flek.americas.hpqcorp.net (flek.americas.hpqcorp.net [16.116.116.116])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ldl.fc.hp.com (Postfix) with ESMTP id BC13539C192
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 15:08:25 -0600 (MDT)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: restore proper NetLabel caching behavior
Date: Mon, 30 Jul 2007 17:08:23 -0400
References: <20070730203331.970255822@hp.com>
In-Reply-To: <20070730203331.970255822@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707301708.24181.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, July 30 2007 4:33:26 pm Paul Moore wrote:
> A small fix to the SELinux/NetLabel glue code to ensure that the NetLabel
> cache is utilized when possible.  This was broken when the SELinux/NetLabel
> glue code was reorganized in the last kernel release.

I forgot to add that this patch is against Linus' tree from earlier today and 
has been tested on a Rawhide box w/o any problems.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
