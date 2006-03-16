Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2GElkkt016183
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 09:47:46 -0500
Received: from smtp-mclean.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2GElh6o015058
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 14:47:43 GMT
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with SMTP id k2GElie27772
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 09:47:44 -0500
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (Postfix) with ESMTP id 8F44857939
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 09:47:11 -0500 (EST)
Received: from IMCFE1.MITRE.ORG (imcfe1.mitre.org [129.83.29.3])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with ESMTP id k2GEl7R27126
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 09:47:07 -0500
From: Brian Sniffen <bsniffen@mitre.org>
To: selinux <selinux@tycho.nsa.gov>
Subject: ANN: Polgen 1.3, now with PSL
Date: Thu, 16 Mar 2006 09:46:51 -0500
Message-ID: <m2ek12a1lw.fsf@raven-king.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

MITRE's SE Linux team is pleased to announce the latest release of our
tool suite for Guided Automated policy generation.  Polgen 1.3 is now
available at

    http://www.mitre.org/tech/selinux/

Our principal new feature is Polgen Specification Language (PSL),
an architecture description language that allows application authors
to leverage their knowledge of application's designs.  They can use PSL
and Polgen to easily produce high-quality SE Linux policy.  Much
information on using PSL can be found in the included manual, with
additional background available in our recent paper, "Guided Policy
Generation for Application Authors," published at the 2006 SE Linux
Symposium:

    http://www.selinux-symposium.org/

We're also excited about our new development environment at
Sourceforge.  Polgen development will now be conducted in the open.
We are hopeful that this will improve both the quality of the
Polgen code and the visibility to and involvement of the SE Linux
community.  You can see our freshly uploaded source tree, or
a copy of the recent paper, at

    http://polgen.sf.net/

By all means, stop by and subscribe to the polgen-user or 
polgen-devel mailing lists.


-- 
Brian T. Sniffen                                      bsniffen@mitre.org
The MITRE Corporation                                       781-271-2904

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
