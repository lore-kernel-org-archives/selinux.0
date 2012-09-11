Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8BKTl8k013291
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 16:29:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 75EB11A056
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 22:29:45 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hvzXuqOML8Jx for <selinux@tycho.nsa.gov>;
	Tue, 11 Sep 2012 22:29:44 +0200 (CEST)
Received: from fornost.bigon.be (unknown [79.132.232.233])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id E8AE71A025
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 22:29:43 +0200 (CEST)
Date: Tue, 11 Sep 2012 22:29:38 +0200
From: Laurent Bigonville <bigon@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Assertion `new_role != ((void *)0) && new_role->flavor == 1'
 when installing modules
Message-ID: <20120911222938.5a21a150@fornost.bigon.be>
In-Reply-To: <20120911121903.6ba2825d@eldamar.bigon.be>
References: <20120909191000.74e83c73@fornost.bigon.be>
	<1347280786.2480.3.camel@moss-pluto.epoch.ncsc.mil>
	<20120911011349.0ecc2f99@eldamar.bigon.be>
	<20120911063822.GA4390@telmora.telvanni>
	<20120911121903.6ba2825d@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Le Tue, 11 Sep 2012 12:19:03 +0200,
Laurent Bigonville <bigon@debian.org> a écrit :


> The patch here: http://marc.info/?l=selinux&m=132636024218187&w=2
> fixed the segfault when loading the policy with Stephen patch.
> 
> BUT, it seems that the initial assertion is not completely fixed.

OK, I was wrong. I didn't saw that checkpolicy was statically linked
against libsepol. So, Stephen's patch in conjunction with the patch
above are actually fixing my issues with both semodule and checkpolicy.

Cheers

Laurent Bigonville


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
