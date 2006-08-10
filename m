Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7AEKfww005446
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 10:20:41 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7AEKVmM010617
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 14:20:31 GMT
Received: from megaweapon.nightmoose.net (HELO d.namei) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 10 Aug 2006 14:20:38 -0000
Date: Thu, 10 Aug 2006 10:20:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Labeled networking code now in Fedora rawhide kernel
Message-ID: <Pine.LNX.4.64.0608101018060.27442@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The MLS enhancements for xfrm labeling, and the Netlabel code, have now 
been backported to the Fedora rawhide kernel:

kernel-2.6.17-1.2543.fc6

Please test this and let me know the outcome.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
