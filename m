Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4IKnWWm018684
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 16:49:32 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4IKnVl2029325
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 20:49:32 GMT
Subject: Re: correct way to set context in perl?
From: Erich Schubert <erich@debian.org>
To: Maria Iano <maria@iano.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20060518160656.V26098@iano.org>
References: <20060518160656.V26098@iano.org>
Content-Type: text/plain
Date: Thu, 18 May 2006 22:47:27 +0200
Message-Id: <1147985248.3617.2.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I'd recommend to use different directories for master and slave zones.
I used to do that back in kernel 2.0 days already.
It's nice to know you can nuke the contents of the slave dir and not
lose any data. ;-) Also I made the slave directory writable by the name
server, the master directory not. There are a couple of reasons to do
such things
(e.g. if you have zones with dynamic updates enabled, you might also
want to put them into a separate directory, while keeping the "root"
zone files protected.
I for example have a dyn.domain.tld zone which is updateable, and some
CNAMES
from the static zone file pointing in there)

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
   There was never a good war or a bad peace. - Benjamin Franklin   //\
    Mathematik: Das Alphabet, mit dessen Hilfe Gott das Universum   V_/_
                beschrieben hat. --- Galileo Galilei


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
