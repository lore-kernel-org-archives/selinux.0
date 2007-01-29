Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TDh0Lo009940
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 08:43:00 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TDi2fV009047
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 13:44:02 GMT
Received: by wx-out-0506.google.com with SMTP id s17so1786041wxc
        for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 05:44:02 -0800 (PST)
Message-ID: <45BDFA0F.7020706@kaigai.gr.jp>
Date: Mon, 29 Jan 2007 22:43:43 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: busybox@busybox.net, selinux@tycho.nsa.gov, russell@coker.com.au,
        rob@landley.net, busybox@kaigai.gr.jp
Subject: Re: [PATCH 7/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp> <45B8C283.1020708@kaigai.gr.jp> <200701270050.27149.vda.linux@googlemail.com>
In-Reply-To: <200701270050.27149.vda.linux@googlemail.com>
Content-Type: multipart/mixed;
 boundary="------------030301010000060204070504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030301010000060204070504
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Denis,

Thanks for your comments.

Denis Vlasenko wrote:
> On Thursday 25 January 2007 15:45, KaiGai Kohei wrote:
>> [7/8] busybox-libselinux-07-matchpathcon.patch
>>   matchpathcon - get the default security context for
>>   the specified path from the file contexts configuration.
>>   Security context is a identifier for SELinux.
>>   Any files has a own security context, and SELinux use it
>>   to evaluate the attribute of the file.
>>   When we are setting up a system, we have to attach a security
>>   context for each files. so, we can obtain the most appropriate
>>   security context by using matchpathcon.
>>
>> Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>
>>
>> --
>> KaiGai Kohei <kaigai@kaigai.gr.jp>
> 
> 
> --- selinux/matchpathcon.c      (revision 0)
> +++ selinux/matchpathcon.c      (revision 0)
> @@ -0,0 +1,108 @@
> +/* matchpathcon  -  get the default security context for the specified
> + *                  path from the file contexts configuration.
> + *                  based on libselinux-1.32
> + * Port to busybox: KaiGai Kohei <kaigai@kaigai.gr.jp>
> + *
> + */
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <selinux/selinux.h>
> +#include "busybox.h"

I removed above redundant headers.

> +
> +static int printmatchpathcon(char *path, int header)
> +{
> +       char *buf;
> +       int rc = matchpathcon(path, 0, &buf);
> +       if (rc < 0) {
> +               fprintf(stderr, "matchpathcon(%s) failed: %s\n", path,
> +                       strerror(errno));
> +               return 1;
> +       }
> +       if (header)
> +               printf("%s\t%s\n", path, buf);
> +       else
> +               printf("%s\n", buf);
> +
> +       freecon(buf);
> +       return 0;
> +}
> +
> +#define MATCHPATHCON_OPT_NOT_PRINT     (1<<0)  /* -n */
> +#define MATCHPATHCON_OPT_NOT_TRANS     (1<<1)  /* -N */
> +#define MATCHPATHCON_OPT_FCONTEXT      (1<<2)  /* -f */
> +#define MATCHPATHCON_OPT_PREFIX                (1<<3)  /* -p */
> +#define MATCHPATHCON_OPT_VERIFY                (1<<4)  /* -V */
> +
> +int matchpathcon_main(int argc, char **argv)
> +{
> +       int i;
> +       int header = 1;
> +       int verify = 0;
> +       int notrans = 0;
> +       int error = 0;
> +       unsigned long opts;
> +       char *fcontext, *prefix;
> +
> +       if (argc < 2)
> +               bb_show_usage();
> +
> +       opts = getopt32(argc, argv, "nNf:p:V", &fcontext, &prefix);
> +       if (opts & BB_GETOPT_ERROR)
> +               bb_show_usage();
> +       if (opts & MATCHPATHCON_OPT_NOT_PRINT)
> +               header = 0;
> +       if (opts & MATCHPATHCON_OPT_NOT_TRANS) {
> +               notrans = 1;
> +               set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
> +       }
> +       if ((opts & MATCHPATHCON_OPT_FCONTEXT) && (opts & MATCHPATHCON_OPT_PREFIX))
> +               bb_error_msg_and_die("-f and -p are exclusive");
> 
> This can be forced by just setting opt_complementary.
> There are a lot of examples in the tree.

The fixed patch uses opt_complementary and omit unnecessary as follows:
          :
     opt_complementary = "?:f--p:p--f";
     opts = getopt32(argc, argv, "nNf:p:V", &fcontext, &prefix);
          :

> +       if (opts & MATCHPATHCON_OPT_FCONTEXT) {
> +               if (matchpathcon_init(fcontext))
> +                       bb_error_msg_and_die("Error while processing %s: %s",
> 
> "<applet>: Error while...."  -- 'E' shpould be 'e' (small letter) here
> (and everywhere in bb_[ph]errorXXX)

OK, fixed.

- <snip> -

> Typically I avoid excessive indentation:
> 
>                if (!verify) {
>                        error += printmatchpathcon(argv[i], header);
>                        continue;
>                }
>                ...here entire old "if(verify)" block needs no indent now:
>                if (selinux_file_context_verify(argv[i], 0)) {
>                        printf("%s verified.\n", argv[i]);
>                } else {
>                ....

OK, I changed the code path as follows:

     if (!verify) {
         error += printmatchpathcon(argv[i], header);
         continue;
     }
     if (selinux_file_context_verify(argv[i], 0)) {
         printf("%s verified.\n", argv[i]);
         continue;
     }
         :

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------030301010000060204070504
Content-Type: text/x-patch;
 name="busybox-libselinux-07-matchpathcon.v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux-07-matchpathcon.v2.patch"

Index: selinux/matchpathcon.c
===================================================================
--- selinux/matchpathcon.c	(revision 0)
+++ selinux/matchpathcon.c	(revision 0)
@@ -0,0 +1,98 @@
+/* matchpathcon  -  get the default security context for the specified
+ *                  path from the file contexts configuration.
+ *                  based on libselinux-1.32
+ * Port to busybox: KaiGai Kohei <kaigai@kaigai.gr.jp>
+ *
+ */
+#include "busybox.h"
+#include <selinux/selinux.h>
+
+static int printmatchpathcon(char *path, int header)
+{
+	char *buf;
+	int rc = matchpathcon(path, 0, &buf);
+	if (rc < 0) {
+		fprintf(stderr, "matchpathcon(%s) failed: %s\n",
+			path, strerror(errno));
+		return 1;
+	}
+	if (header)
+		printf("%s\t%s\n", path, buf);
+	else
+		printf("%s\n", buf);
+
+	freecon(buf);
+	return 0;
+}
+
+#define MATCHPATHCON_OPT_NOT_PRINT	(1<<0)	/* -n */
+#define MATCHPATHCON_OPT_NOT_TRANS	(1<<1)	/* -N */
+#define MATCHPATHCON_OPT_FCONTEXT	(1<<2)	/* -f */
+#define MATCHPATHCON_OPT_PREFIX		(1<<3)	/* -p */
+#define MATCHPATHCON_OPT_VERIFY		(1<<4)	/* -V */
+
+int matchpathcon_main(int argc, char **argv)
+{
+	int i;
+	int header = 1;
+	int verify = 0;
+	int notrans = 0;
+	int error = 0;
+	unsigned long opts;
+	char *fcontext, *prefix;
+
+	if (argc < 2)
+		bb_show_usage();
+
+	opt_complementary = "?:f--p:p--f";
+	opts = getopt32(argc, argv, "nNf:p:V", &fcontext, &prefix);
+	if (opts & MATCHPATHCON_OPT_NOT_PRINT)
+		header = 0;
+	if (opts & MATCHPATHCON_OPT_NOT_TRANS) {
+		notrans = 1;
+		set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
+	}
+	if (opts & MATCHPATHCON_OPT_FCONTEXT) {
+		if (matchpathcon_init(fcontext))
+			bb_error_msg_and_die("error while processing %s: %s",
+					     fcontext, errno ? strerror(errno) : "invalid");
+	}
+	if (opts & MATCHPATHCON_OPT_PREFIX) {
+		if (matchpathcon_init_prefix(NULL, prefix))
+			bb_error_msg_and_die("error while processing %s:  %s",
+					     prefix, errno ? strerror(errno) : "invalid");
+	}
+	if (opts & MATCHPATHCON_OPT_VERIFY)
+		verify = 1;
+
+	for (i = optind; i < argc; i++) {
+		security_context_t con;
+		int rc;
+
+		if (!verify) {
+			error += printmatchpathcon(argv[i], header);
+			continue;
+		}
+
+		if (selinux_file_context_verify(argv[i], 0)) {
+			printf("%s verified.\n", argv[i]);
+			continue;
+		}
+
+		if (notrans)
+			rc = lgetfilecon_raw(argv[i], &con);
+		else
+			rc = lgetfilecon(argv[i], &con);
+
+		if (rc >= 0) {
+			printf("%s has context %s, should be ", argv[i], con);
+			error += printmatchpathcon(argv[i], 0);
+			freecon(con);
+		} else {
+			printf("actual context unknown: %s, should be ", strerror(errno));
+			error += printmatchpathcon(argv[i], 0);
+		}
+	}
+	matchpathcon_fini();
+	return error;
+}

--------------030301010000060204070504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
