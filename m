Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TE5fGd010933
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 09:05:41 -0500
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TE6hfV013078
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 14:06:43 GMT
Received: by an-out-0708.google.com with SMTP id d33so470603and
        for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 06:06:43 -0800 (PST)
Message-ID: <45BDFF61.3050604@kaigai.gr.jp>
Date: Mon, 29 Jan 2007 23:06:25 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: busybox@busybox.net, selinux@tycho.nsa.gov, russell@coker.com.au,
        rob@landley.net, busybox@kaigai.gr.jp
Subject: Re: [PATCH 4/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp> <45B8C244.7040609@kaigai.gr.jp> <200701270059.34996.vda.linux@googlemail.com>
In-Reply-To: <200701270059.34996.vda.linux@googlemail.com>
Content-Type: multipart/mixed;
 boundary="------------070500050207080806010709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070500050207080806010709
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Denis, Thanks for your comments.

Denis Vlasenko wrote:
> On Thursday 25 January 2007 15:44, KaiGai Kohei wrote:
>> [4/8] busybox-libselinux-04-getsebool.patch
>>   getsebool reports the a particular or all SELinux
>>   boolean variable.
>>   SELinux boolean variable is a interface to configure
>>   the condition of security policy. We can enable or
>>   disable the part of the security policy via boolean
>>   variable.
>>
>> Signed-off-by: Hiroshi Shinji <shiroshi@my.email.ne.jp>
>> Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>
>>
>> --
>> KaiGai Kohei <kaigai@kaigai.gr.jp>
> 
> --- selinux/getsebool.c (revision 0)
> +++ selinux/getsebool.c (revision 0)
> @@ -0,0 +1,98 @@
> +/*
> + * getsebool
> + *
> + * Based on libselinux 1.33.1
> + * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
> + *
> + */
> +
> +#include "busybox.h"
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <selinux/selinux.h>

I removed above redundant headers.

> +#define GETSEBOOL_OPT_ALL      1
> +
> +int getsebool_main(int argc, char **argv)
> +{
> +       int i, rc = 0, active, pending, len = 0;
> +       char **names;
> +       unsigned long opt;
> +
> +       opt = getopt32(argc, argv, "a");
> +
> +       if(opt & BB_GETOPT_ERROR) {
> +               bb_show_usage();
> +       }
> 
> Is it needed? I mean, can you give an example where it is needed?

No. The above block is unnecessary.

> +
> +       if (!len) {
> +               if (argc < 2)
> +                       bb_show_usage();
> +               len = argc - 1;
> +               names = malloc(sizeof(char *) * len);
> +               if (!names) {
> +                       bb_error_msg_and_die("out of memory");
> +               }
> 
> xmalloc will do dying for you! :)
> 
> +               for (i = 0; i < len; i++) {
> +                       names[i] = strdup(argv[i + 1]);
> 
> xstrdup. Gotta love busybox. We love to die, and love to get rid
> of useless error paths.

Thanks for the useful information.
I replaced them with xmalloc() and xstrdup().

> +      out:
> +       for (i = 0; i < len; i++)
> +               free(names[i]);
> +       free(names);
> 
> 	Add if (ENABLE_FEATURE_CLEAN_UP) in front of for().

OK, I appended if (ENABLE_FEATURE_CLEAN_UP) { ... } block.

BTW, I found both '#if ENABLE_FEATURE_CLEAN_UP' and 'if (ENABLE_FEATURE_CLEAN_UP)'
in the source tree. Which manner is preferable?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------070500050207080806010709
Content-Type: text/x-patch;
 name="busybox-libselinux-04-getsebool.v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux-04-getsebool.v2.patch"

Index: selinux/getsebool.c
===================================================================
--- selinux/getsebool.c	(revision 0)
+++ selinux/getsebool.c	(revision 0)
@@ -0,0 +1,83 @@
+/*
+ * getsebool
+ *
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ */
+
+#include "busybox.h"
+#include <selinux/selinux.h>
+
+#define GETSEBOOL_OPT_ALL	1
+
+int getsebool_main(int argc, char **argv)
+{
+	int i, rc = 0, active, pending, len = 0;
+	char **names;
+	unsigned long opt;
+
+	opt = getopt32(argc, argv, "a");
+
+	if(opt & GETSEBOOL_OPT_ALL) {
+		if (argc > 2)
+			bb_show_usage();
+		if (is_selinux_enabled() <= 0) {
+			bb_error_msg_and_die("SELinux is disabled");
+		}
+		errno = 0;
+		rc = security_get_boolean_names(&names, &len);
+		if (rc) {
+			bb_error_msg_and_die("cannot get boolean names:  %s",
+					     strerror(errno));
+		}
+		if (!len) {
+			printf("No booleans\n");
+			return 0;
+		}
+	}
+
+	if (is_selinux_enabled() <= 0)
+		bb_error_msg_and_die("SELinux is disabled");
+
+	if (!len) {
+		if (argc < 2)
+			bb_show_usage();
+		len = argc - 1;
+		names = xmalloc(sizeof(char *) * len);
+		for (i = 0; i < len; i++)
+			names[i] = xstrdup(argv[i + 1]);
+	}
+
+	for (i = 0; i < len; i++) {
+		active = security_get_boolean_active(names[i]);
+		if (active < 0) {
+			bb_error_msg("error getting active value for %s", names[i]);
+			rc = -1;
+			goto out;
+		}
+		pending = security_get_boolean_pending(names[i]);
+		if (pending < 0) {
+			bb_error_msg("error getting pending value for %s", names[i]);
+			rc = -1;
+			goto out;
+		}
+		if (pending != active) {
+			printf("%s --> %s pending: %s\n", names[i],
+			       (active ? "on" : "off"),
+			       (pending ? "on" : "off"));
+		} else {
+			printf("%s --> %s\n", names[i],
+			       (active ? "on" : "off"));
+		}
+	}
+
+      out:
+	if (ENABLE_FEATURE_CLEAN_UP) {
+		for (i = 0; i < len; i++)
+			free(names[i]);
+		free(names);
+	}
+
+	return rc;
+}

--------------070500050207080806010709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
