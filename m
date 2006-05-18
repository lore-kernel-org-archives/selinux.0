Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4IMo1BG021114
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 18:50:03 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4IMo0l2011868
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 22:50:00 GMT
Subject: Re: correct way to set context in perl?
From: Erich Schubert <erich@debian.org>
To: Maria Iano <maria@iano.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20060518171245.Y26098@iano.org>
References: <20060518160656.V26098@iano.org>
	 <1147985248.3617.2.camel@wintermute.xmldesign.de>
	 <20060518171245.Y26098@iano.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 19 May 2006 00:47:55 +0200
Message-Id: <1147992475.3617.6.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
You should be able to setup a regexp to match the master and slave dirs
with appropriate contexts, then run the "restorecon" app to restore the
directory contexts after dir creation and it should work okay. You'll
need your app to be able to transition into restorecon, but thats
probably okay. I mean, it could be used to reset some file contexts
in /home that you'd like to keep...
Maybe restorecon will work on the files without domain transition, if
the old domain has the relabel permissions... I'm not that deep into
advanced SELinux use...

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
 Nothing prevents happiness like the memory of happiness. --- A. Gide //\
    Wo befreundete Wege zusammenlaufen, da sieht die ganze Welt für   V_/_
          eine Stunde wie eine Heimat aus. --- Herrmann Hesse



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
