Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0S9fmRb004270
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 04:41:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0S9eWxr006189
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 09:40:32 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id i0S9eVYc006186
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 09:40:31 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 6BE43BDEDF
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 10:41:43 +0100 (CET)
Date: Wed, 28 Jan 2004 10:41:42 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: selinux@tycho.nsa.gov
Subject: libselinux/getpeercon/compiler warning on 64bit Archs
Message-ID: <20040128094142.GA24926@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

On 64bit architectures, I get the follwoing compiler warnings:

getpeercon.c:26: warning: passing arg 5 of `getsockopt' from incompatible pointer type
getpeercon.c:36: warning: passing arg 5 of `getsockopt' from incompatible pointer type

The fix is simple, the variable "size" in getpeercon() should be from
type "socklen_t", not "ssize_t".

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Maxfeldstr. 5                 D-90409 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
