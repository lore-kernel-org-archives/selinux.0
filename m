Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CDUgrT001865
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 09:30:42 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CDULDC005917
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 13:30:21 GMT
Subject: Re: initrc.te
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407111759.23107.russell@coker.com.au>
References: <200407111759.23107.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089639034.22449.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Jul 2004 09:30:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-11 at 03:59, Russell Coker wrote:
> This patch moves all the Red Hat specific stuff to one place, causes files the 
> administrator creates under the root directory to have type etc_runtime_t 
> (for /halt) and does not permit stat'ing device nodes of types that are used 
> for files.

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
