Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA25943
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 04:40:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA02401
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 09:37:17 GMT
Received: from unicorn.lemuria.org (c145075.adsl.hansenet.de [213.39.145.75])
	by jazzswing.ncsc.mil  with ESMTP id JAA02397
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 09:37:16 GMT
Date: Fri, 21 Feb 2003 10:33:59 +0100
From: Tom <tom@lemuria.org>
To: CNGUYEN <CNguyen@mykotronx.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Making OPIE/QTOPIA aware of SELinux
Message-ID: <20030221103358.M6291@lemuria.org>
References: <FD2221F5E1A8184DB61AFCE064C395F1C91CEF@torexch1.mykotronx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FD2221F5E1A8184DB61AFCE064C395F1C91CEF@torexch1.mykotronx.com>; from CNguyen@mykotronx.com on Thu, Feb 20, 2003 at 11:42:56AM -0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Feb 20, 2003 at 11:42:56AM -0800, CNGUYEN wrote:
> Applications <----
> ----              |
> OPIE/QTOPIA  <---------|
> ---                    |
> SELinux                |
> ---                    | 
> Device Drivers <-------|

There's no danger of this as SELinux works at the kernel level.

However, I can imagine that the qtopia software is so much "integrated"
that it won't work with any reasonably secure policy.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
