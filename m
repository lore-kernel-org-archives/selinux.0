Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FEfnWt025755
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 10:41:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9FEff0p017296
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:41:41 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id h9FEfer7017293
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:41:40 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FEfl0F021333
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 10:41:47 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h9FEflX3021331
	for selinux@tycho.nsa.gov; Wed, 15 Oct 2003 10:41:47 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FE61Wt025436
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 10:06:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9FE5r0p013990
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:05:54 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id h9FE5rr7013984
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:05:53 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id C32B816FDB2E
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 16:05:55 +0200 (CEST)
Date: Wed, 15 Oct 2003 05:44:06 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: SELinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Question about chsh/chfn/passwd patches
Message-ID: <20031015034406.GA1644@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

I have a question about the passwd/chfn/chsh patches.

passwd only calls checkAccess. chfn/chsh additional calls 
setupDefaultContext. 

I don't understand what the last function makes. For what is it good,
and why don't we need to call it from passwd?

  Thanks,
    Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
