Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0NDs7ou026672
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 08:54:07 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0NDs5lo020362
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 13:54:05 GMT
Subject: [patch 1/1] libsemanage: genhomedircon remove error on missing
	HOME_DIR or HOME_ROOT
From: Caleb Case <ccase@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 08:53:56 -0500
Message-Id: <1201096436.17665.15.camel@olympus.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Removing failure condition in write_context_file when HOME_DIR or
HOME_ROOT are not found in the contexts. This condition is not needed
(the case where the lists are empty is handled correctly) and stops
otherwise valid operations:

On a fresh policy store, without any modules loaded:

# semodule -s refpolicy -b /usr/share/selinux/refpolicy/base.pp
libsemanage.semanage_install_sandbox: semanage_genhomedircon returned
error code -1. No such file or directory.
semodule:  Failed!

---
 src/genhomedircon.c |    4 ----
 1 file changed, 4 deletions(-)

Index: libsemanage/src/genhomedircon.c
===================================================================
--- libsemanage.orig/src/genhomedircon.c
+++ libsemanage/src/genhomedircon.c
@@ -792,10 +792,6 @@ static int write_context_file(genhomedir
        homedir_context_tpl = make_template(s, &HOME_DIR_PRED);
        homeroot_context_tpl = make_template(s, &HOME_ROOT_PRED);
        user_context_tpl = make_template(s, &USER_CONTEXT_PRED);
-       if (!homedir_context_tpl || !homeroot_context_tpl) {
-               retval = STATUS_ERR;
-               goto done;
-       }

        if (setup_fallback_user(s) != 0) {
                retval = STATUS_ERR;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
