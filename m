Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CDWxrT001929
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 09:32:59 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CDWcDC006035
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 13:32:38 GMT
Subject: Re: device_type vs file_type
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407111900.33374.russell@coker.com.au>
References: <200407111900.33374.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089639171.22449.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Jul 2004 09:32:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-11 at 05:00, Russell Coker wrote:
> The attached patch removes the file_type attribute from the types for device 
> nodes.
> 
> In most cases rules using file_type are not intended to catch the types for 
> device nodes as well so this should make things simpler.

Ok, merged, along with the setfiles diff.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
