Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OJXiFX028711
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 14:33:44 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0OJVduq015082
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 19:31:40 GMT
Message-ID: <36282A1733C57546BE392885C061859269629F@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Casey Schaufler
	 <casey@schaufler-ca.com>
Cc: James Morris <jmorris@redhat.com>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: [patch] enhanced MLS support
Date: Mon, 24 Jan 2005 14:34:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
On Mon, 2005-01-24 at 11:38, Casey Schaufler wrote:

> You could certainly store handling caveats in
> the category bitmaps, but expressing NOFORN
> in categories has been tried and does not work.

I'm not sure of your exact desire, but categories can be used directly (not
sufficient for releasabilities) or grouped together for use by a higher
level language which can make more complex relationships.

-Chad
_______________________________________
Chad Hanson
Manager, Trusted Operating Systems Lab

Trusted Computer Solutions
121 W Goose Alley
Urbana, IL  61801

www.TrustedCS.com

V: 217.384.0028  ext.12
F: 217.384.0288
E: chanson@TrustedCS.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
