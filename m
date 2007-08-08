Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l78JDmAj031115
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 15:13:48 -0400
Received: from tresys-winxppro.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l78JDjSH027854
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 19:13:45 GMT
Received: from tresys-winxppro.columbia.tresys.com (localhost.localdomain [127.0.0.1])
	by tresys-winxppro.columbia.tresys.com (8.13.8/8.13.8) with ESMTP id l78KMrtB017102
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 16:22:53 -0400
Received: (from paul@localhost)
	by tresys-winxppro.columbia.tresys.com (8.13.8/8.13.8/Submit) id l78KMqtL017101
	for selinux@tycho.nsa.gov; Wed, 8 Aug 2007 16:22:52 -0400
Message-Id: <20070808202252.190491979@tresys.com>
Date: Wed, 08 Aug 2007 16:22:52 -0400
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Subject: [patch 0/3] libsemanage: genhomedircon replacement
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This replaces genhomedircon with equivalent functionality in
libsemanage. The homedir_template is also no longer installed, this leaves
some unused path functions in libselinux but removing those would break
the ABI.

This does the same things that genhomedircon did though some seemed
strange, like removing /sbin/nologin from the list of valid shells,
presumably to keep ftp users and such from getting file contexts generated
for them, I'm not sure how valid the assumption is but we didn't want
to change the functionality of genhomedircon in this patch set.

The first patch adds genhomedircon.c to libsemanage and calls it from
the semanage_store.c and removes the prior call to genhomedircon. This
version uses libustr for string manipulations, which creates an external
dependency available in the development yum repository. There is, however,
an option to embed the ustr code directly into the library and eliminate
the runtime dependency.

The second patch is a set of tests for the new functions

The third patch removes the old genhomedircon script.

Signed-Off-By: Todd Miller <tmiller@tresys.com>


-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
