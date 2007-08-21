Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LHhjLW009667
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 13:43:45 -0400
Received: from tresys-sp-eval (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7LHhgYx001399
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 17:43:43 GMT
Received: from tresys-sp-eval (localhost.localdomain [127.0.0.1])
	by tresys-sp-eval (8.13.8/8.13.8) with ESMTP id l7LJAhtf008228
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 15:10:43 -0400
Received: (from paul@localhost)
	by tresys-sp-eval (8.13.8/8.13.8/Submit) id l7LJAg4c008227
	for selinux@tycho.nsa.gov; Tue, 21 Aug 2007 15:10:42 -0400
Message-Id: <20070821191042.482612921@tresys.com>
Date: Tue, 21 Aug 2007 15:10:42 -0400
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Subject: [patch 0/5] libsemanage: genhomedircon replacement v2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This replaces genhomedircon with equivalent functionality in libsemanage. The
homedir_template is also no longer installed, this leaves some unused path
functions in libselinux but removing those would break the ABI.

This patch also generalizes some functionality of genhomedircon so that it can
be extended in the future (ex: for policy server user contexts)

The first patch does some cleanup to make way for the new genhomedircon.

The second patch adds genhomedircon.c and utilities.c to libsemanage. It calls
the code in genhomedircon.c from semanage_store.c and removes the prior call
to genhomedircon. This version uses libustr for string manipulations, which
creates an external dependency available in the development yum repository.
There is, however, an option to embed the ustr code directly into the library
and eliminate the runtime dependency.

* FIXED: memory leaks with getline()
* FIXED: botched SEUsers in strict policies
* FIXED: extra blank lines in context file

The third patch is a set of tests for the new functions in utilities.c.

The fourth patch removes the old genhomedircon script.

The Final patch adds a way to enable/disable genhomedircon via semanage.conf
by adding 'disable-genhomedircon = true'.

Since Genhomedircon is no longer an external program, took out the 
[genhomedircon] section from semanage.conf.

The old Genhomedircon script ignores some relevent entries in the template
file -- a patch for this bug has already been submitted.

Signed-Off-By: Todd Miller <tmiller@tresys.com>

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
