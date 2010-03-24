Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2ODH7IO008230
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 09:17:07 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2ODHkFx025989
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 13:17:46 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o2ODH487027912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 09:17:04 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o2ODH3Hs022664
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 09:17:04 -0400
Message-ID: <4BAA10CF.4080206@redhat.com>
Date: Wed, 24 Mar 2010 09:17:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Patch to context_new to set errno to EINVAL on bad values
Content-Type: multipart/mixed;
 boundary="------------060904080408020602040907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060904080408020602040907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060904080408020602040907
Content-Type: text/plain;
 name="libselinux_context_new.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux_context_new.patch"

diff --git a/libselinux/src/context.c b/libselinux/src/context.c
index 8164104..b673733 100644
--- a/libselinux/src/context.c
+++ b/libselinux/src/context.c
@@ -22,6 +22,7 @@ typedef struct {
 context_t context_new(const char *str)
 {
 	int i, count;
+	errno = 0;
 	context_private_t *n =
 	    (context_private_t *) malloc(sizeof(context_private_t));
 	context_t result = (context_t) malloc(sizeof(context_s_t));
@@ -76,6 +77,7 @@ context_t context_new(const char *str)
 	}
 	return result;
       err:
+	if (errno == 0) errno = EINVAL;
 	context_free(result);
 	return 0;
 }

--------------060904080408020602040907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
