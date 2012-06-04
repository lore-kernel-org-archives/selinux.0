Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q54IRrBn000416
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2012 14:27:53 -0400
Subject: SE Android: Middleware MAC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Jun 2012 14:27:52 -0400
Message-ID: <1338834472.28463.53.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

We have released a set of extensions to the Android middleware that
provide different forms of mandatory restrictions over the Android
permissions model.  As these extensions are experimental and we have not
yet settled on a final approach, we are keeping them on separate
branches from the base SE Android code.  Information about the current
set of extensions for middleware MAC can be found at:
http://selinuxproject.org/page/SEAndroid#Middleware_MAC

As always, we welcome community feedback and participation as we
continue to further develop these extensions and explore other possible
mechanisms in this space.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
