Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i725IbrT009923
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 01:18:39 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i725IWKV002337
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 05:18:36 GMT
Subject: Re: /etc/qt3/.qt*
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040801194006.GF20103@lkcl.net>
References: <20040801194006.GF20103@lkcl.net>
Content-Type: text/plain
Date: Sun, 01 Aug 2004 22:19:13 +0200
Message-Id: <1091391553.7861.17.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> gawd only knows what kde (actually libqt) is doing needing to write 
> lock files to /etc/qt3 but there y'go.

I don't have a /etc/qt3. And if i had it, it certainly would be mode
0755, so no user can write there (and i don't think running qt apps as
root is a good idea) - something must be wrong with your setup.

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  A polar bear is a rectangular bear after a coordinate transform.   //\
  Wenn zwei gute Freunde sind, die einander kennen, Sonn' und Mond   V_/_
    begegnen sich, ehe sie sich trennen. --- Clemens von Brentano


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
