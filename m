Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HMDcrT016871
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 18:13:38 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HMCv2E022167
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 22:12:58 GMT
Subject: Re: hald
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <rcoker@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <20040817204957.GW18321@lkcl.net>
References: <1092716467.1684.304.camel@vpn>
	 <20040817204957.GW18321@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 18 Aug 2004 00:13:33 +0200
Message-Id: <1092780813.6531.7.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>  is this better than the hotplug+udev mess?

No, you usually use udev+hotplug+hal+dbus+gnome
They play together quite nicely: when you plugin a digital camera the
notification goes all the way up to the gnome-volume-manager which
mounts the drive and asks wheter you want to download the images from
the camera.
Dbus is the notification bus. Hal is the hardware layer, feeding this
information into dbus IIRC.

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
          There are only 10 types of people in the world:           //\
          Those who understand binary and those who don't           V_/_
      Computer rechnen vor allem damit, daﬂ der Mensch denkt.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
