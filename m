Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6L2jImN031436
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2011 22:45:18 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6L2jC5r009807
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2011 02:45:12 GMT
From: Stephen Lawrence <slawrence@tresys.com>
To: "russell@coker.com.au" <russell@coker.com.au>,
        SE-Linux
	<selinux@tycho.nsa.gov>
Subject: RE: subs_dist and libselinux releases
Date: Thu, 21 Jul 2011 02:43:13 +0000
Message-ID: <C14BECD185F28F4DB71F78DE6559C53E0AF512@Exchange10.columbia.tresys.com>
References: <201107141611.41063.russell@coker.com.au>
In-Reply-To: <201107141611.41063.russell@coker.com.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm very sorry for the late response. A release containing the subs_dist patch is planned once we get the roleattribute patch merged, which should be within the week.

- Steve

________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of Russell Coker [russell@coker.com.au]
Sent: Thursday, July 14, 2011 2:11 AM
To: SE-Linux
Subject: subs_dist and libselinux releases

http://userspace.selinuxproject.org/trac/browser/libselinux/src?order=date&desc=1
http://userspace.selinuxproject.org/trac/wiki/Releases

The patch for the subs_dist file was first proposed in April, when will there
be a new upstream release that includes it?

Currently we have a need for this in Debian, but it doesn't seem that there is
an upstream release with it.  I would prefer to avoid maintaining my own patch
set for libselinux in this regard if possible.

--
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
