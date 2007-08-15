Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7FEXewU011602
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 10:33:40 -0400
Received: from tresys-winxppro.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7FEXX9K021779
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 14:33:34 GMT
Received: from tresys-winxppro.columbia.tresys.com (localhost.localdomain [127.0.0.1])
	by tresys-winxppro.columbia.tresys.com (8.13.8/8.13.8) with ESMTP id l7FKiCS2029063
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 16:44:12 -0400
Received: (from paul@localhost)
	by tresys-winxppro.columbia.tresys.com (8.13.8/8.13.8/Submit) id l7FKiCA9029062
	for selinux@tycho.nsa.gov; Wed, 15 Aug 2007 16:44:12 -0400
Message-Id: <20070815204411.705994826@tresys.com>
Date: Wed, 15 Aug 2007 16:44:11 -0400
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Subject: [patch 0/4] libsemanage: genhomedircon replacement
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This replaces genhomedircon with equivalent functionality in libsemanage. The
homedir_template is also no longer installed, this leaves some unused path
functions in libselinux but removing those would break the ABI.

This does the same things that genhomedircon did though some seemed strange,
like removing /sbin/nologin from the list of valid shells, presumably to keep
ftp users and such from getting file contexts generated for them, I'm not sure
how valid the assumption is but we didn't want to change the functionality of
genhomedircon in this patch set.

This patch also generalizes some functionality of genhomedircon so that it can
be extended in the future (ex: for policy server user contexts)

The first patch does some cleanup to make way for the new genhomedircon.

The second patch adds genhomedircon.c and utilities.c to libsemanage. It calls
the code in genhomedircon.c from semanage_store.c and removes the prior call
to genhomedircon. This version uses libustr for string manipulations, which
creates an external dependency available in the development yum repository.
There is, however, an option to embed the ustr code directly into the library
and eliminate the runtime dependency.

The third patch is a set of tests for the new functions in utilities.c.

The final patch removes the old genhomedircon script.

Signed-Off-By: Todd Miller <tmiller@tresys.com>

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
