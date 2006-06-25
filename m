Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5PDaWBv007459
	for <selinux@tycho.nsa.gov>; Sun, 25 Jun 2006 09:36:32 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5PDaVgf020127
	for <selinux@tycho.nsa.gov>; Sun, 25 Jun 2006 13:36:31 GMT
Subject: Re: moving modules into base
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200606252237.07080.russell@coker.com.au>
References: <200606181333.36369.russell@coker.com.au>
	 <1150728321.18657.104.camel@sgc>  <200606252237.07080.russell@coker.com.au>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 15:36:25 +0200
Message-Id: <1151242586.24639.3.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > I then built a module with just clamav in base.pp and got the following:

Did you _remove_ the old clamav.pp module before installing the new
base?
You should be able to do it in one pass, but make sure you removed
clamav.pp
e.g. semodule -r clamav -b /path/to/base.pp

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
    The infinite! No other question has ever moved so profoundly    //\
                the spirit of man. --- David Hilbert                V_/_
            Es lohnt sich nicht, die Augen aufzumachen,
                   wenn der Kopf im Sand steckt.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
