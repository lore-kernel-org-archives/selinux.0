Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72EZYrT012743
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:35:35 -0400 (EDT)
Received: from flame.hosts.ndo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72EZXKV012953
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 14:35:33 GMT
Date: Mon, 2 Aug 2004 15:45:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: /etc/qt3/.qt*
Message-ID: <20040802144542.GC4194@lkcl.net>
References: <20040801194006.GF20103@lkcl.net> <1091391553.7861.17.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091391553.7861.17.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 01, 2004 at 10:19:13PM +0200, Erich Schubert wrote:
> Hi,
> 
> > gawd only knows what kde (actually libqt) is doing needing to write 
> > lock files to /etc/qt3 but there y'go.
> 
> I don't have a /etc/qt3. And if i had it, it certainly would be mode
> 0755, so no user can write there (and i don't think running qt apps as
> root is a good idea) - something must be wrong with your setup.
 
 this is very strange.

 it's kde 3.2.2, bog-standard.
 
 and it's root that's trying to write there (xdm_t and xdm_server_t).

 debian/unstable, last dist-upgrade was done two, maybe three months
 ago.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
