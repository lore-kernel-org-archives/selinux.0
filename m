Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9CFJ7rT012317
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 11:19:07 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9CFHksX011126
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 15:17:50 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id CC26EC4C08D
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 17:18:50 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 22264-07 for <selinux@tycho.nsa.gov>;
	Tue, 12 Oct 2004 17:18:50 +0200 (CEST)
Received: from wintermute.xmldesign.de (pD958F7A4.dip.t-dialin.net [217.88.247.164])
	by legolas.drinsama.de (Postfix) with ESMTP id 1C32DC4C089
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 17:18:50 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id 16A142340B2
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 17:18:49 +0200 (CEST)
Subject: Re: Asterisk on SELinux
From: Erich Schubert <erich@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1097499317.16758.40.camel@wintermute.xmldesign.de>
References: <1097499317.16758.40.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 12 Oct 2004 17:18:48 +0200
Message-Id: <1097594328.12801.20.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[NB: repost, since the other address was not subscribed]

Hi,
One further rule is missing for asterisk console mode
(use "asterisk -c -r" to attach) :

allow sysadm_t asterisk_t:unix_stream_socket { connectto
rw_stream_socket_perms };

Allows sysadm to use the asterisk console (i.e. show status etc.)

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   To understand recursion you first need to understand recursion.   //\
      Die einzige Hoffnung auf Freude liegt in den menschlichen      V_/_
              Beziehungen. --- Antoine de Saint-Exupéry



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
