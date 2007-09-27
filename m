MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: I am concerned about putting genhomedircon changesinlibsemanage into Fedora 8.
Date: Wed, 26 Sep 2007 21:03:18 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588011446F4@exchange.columbia.tresys.com>
References: <200709262020.l8QKKDX7025382@tex.courtesan.com> <46FACCF8.2060500@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I see the issue, getpwnam_r() has surprising semantics when a user is not found.  I'll have a fix for that tomorrow AM.

 - todd


-----Original Message-----

But
/usr/sbin/semanage login -m -s guest_u __default__

Is causing a segfault in genhomedircon line 627


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
