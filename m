Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TDkeKd010051
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 08:46:40 -0500
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TDlgxX007466
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 13:47:42 GMT
Received: by wx-out-0506.google.com with SMTP id s17so1786900wxc
        for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 05:47:42 -0800 (PST)
Message-ID: <45BDFAEC.2050500@kaigai.gr.jp>
Date: Mon, 29 Jan 2007 22:47:24 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: busybox@busybox.net, selinux@tycho.nsa.gov, russell@coker.com.au,
        rob@landley.net, busybox@kaigai.gr.jp
Subject: Re: [PATCH 2/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp> <45B8C232.8030001@kaigai.gr.jp> <200701270054.34561.vda.linux@googlemail.com>
In-Reply-To: <200701270054.34561.vda.linux@googlemail.com>
Content-Type: multipart/mixed;
 boundary="------------040908050203080305010205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040908050203080305010205
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Denis, Thanks for your comments.

The attached patch uses bb_error_msg_and_die() instead of bb_error_msg()
and error exit, and remove redundant headers.

Thanks,

Denis Vlasenko wrote:
> On Thursday 25 January 2007 15:44, KaiGai Kohei wrote:
>> [2/8] busybox-libselinux-02-getenforce.patch
>>   getenforce - get the current mode of SELinux.
>>   SELinux has two mode. 'Enforcing' is the one, it enables
>>   mandatory access control based on the security policy.
>>   The other is 'Permissive' mode. It enables to evaluate
>>   security policy and output audit messages, if violated.
>>   But mandatory access control was not done. It was used
>>   to debug policy.
>>
>> Signed-off-by: Hiroshi Shinji <shiroshi@my.email.ne.jp>
>> Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>
>>
>> --
>> KaiGai Kohei <kaigai@kaigai.gr.jp>
> 
> --- selinux/getenforce.c        (revision 0)
> +++ selinux/getenforce.c        (revision 0)
> @@ -0,0 +1,40 @@
> +/*
> + * getenforce
> + *
> + * Based on libselinux 1.33.1
> + * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
> + *
> + */
> +
> +#include "busybox.h"
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <selinux/selinux.h>
> +
> +int getenforce_main(int argc, char **argv)
> +{
> +       int rc;
> +
> +       rc = is_selinux_enabled();
> +       if (rc < 0) {
> +               bb_error_msg("is_selinux_enabled() failed");
> +               return 2;
> 
> Will bb_error_msg_and_die work here?
> 
> +       }
> +       if (rc == 1) {
> +               rc = security_getenforce();
> +               if (rc < 0) {
> +                       bb_error_msg("getenforce() failed");
> +                       return 2;
> +               }
> +
> +               if (rc)
> +                       puts("Enforcing");
> +               else
> +                       puts("Permissive");
> +       } else {
> +               puts("Disabled");
> +       }
> +
> +       return 0;
> +}
> 
> 


-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------040908050203080305010205
Content-Type: text/x-patch;
 name="busybox-libselinux-02-getenforce.v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux-02-getenforce.v2.patch"

Index: selinux/getenforce.c
===================================================================
--- selinux/getenforce.c	(revision 0)
+++ selinux/getenforce.c	(revision 0)
@@ -0,0 +1,34 @@
+/*
+ * getenforce
+ *
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ */
+
+#include "busybox.h"
+#include <selinux/selinux.h>
+
+int getenforce_main(int argc, char **argv)
+{
+	int rc;
+
+	rc = is_selinux_enabled();
+	if (rc < 0)
+		bb_error_msg_and_die("is_selinux_enabled() failed");
+
+	if (rc == 1) {
+		rc = security_getenforce();
+		if (rc < 0)
+			bb_error_msg_and_die("getenforce() failed");
+
+		if (rc)
+			puts("Enforcing");
+		else
+			puts("Permissive");
+	} else {
+		puts("Disabled");
+	}
+
+	return 0;
+}

--------------040908050203080305010205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
