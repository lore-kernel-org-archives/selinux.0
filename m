Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB4HHHDR026116
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 12:17:17 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kB4HGYEC010141
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 17:16:35 GMT
Subject: [ANN] SETools - 3.0.1
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Cc: selinux-dev@tresys.com
Content-Type: text/plain
Date: Mon, 04 Dec 2006 12:19:59 -0500
Message-Id: <1165252799.2609.30.camel@Bishop.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new version of SETools is available on the Tresys Open Source Server,
http://oss.tresys.com/

SETools 3.0.1

SETools:

  * All code has been indented uniformly via the 'make indent' target.

SETools libraries:

  * All libraries now have a get_version() function.

libqpol:

  * Syntactic rule table is now off by default; it requires an
    explicit call to qpol_policy_build_syn_rule_table() to create it.

libapol:

  * apol_policy_t is now an opaque structure.  apol_permmap_t is no
    longer a public declaration.

  * avrule and terule queries now have full "syntactic" searching
    features.

apol & sesearch:

  * If loaded policy is source, the new syntactic search algorithm is used.


Jeremy A. Mowery
Tresys Technology
410-290-1411 x148


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
