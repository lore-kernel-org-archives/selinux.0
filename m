Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l11LOgGc022115
	for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2007 16:24:42 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l11LPjTB018607
	for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2007 21:25:45 GMT
Message-ID: <45C25ACB.5070203@mentalrootkit.com>
Date: Thu, 01 Feb 2007 16:25:31 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: "Todd C. Miller" <Todd.Miller@sparta.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: PATCH: libselinux matchpathcon() eliminate %as scanf format
References: <200701252359.l0PNxMjc011991@tex.courtesan.com>
In-Reply-To: <200701252359.l0PNxMjc011991@tex.courtesan.com>
Content-Type: multipart/mixed;
 boundary="------------020101080000060400030505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020101080000060400030505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Todd C. Miller wrote:
> This is a patch I sent in last year but forgot to split up as
> requested; it still applies to the recently-released selinux-1.34.0.
> 
> THe patch replaces usage of the non-standard %as scanf() format
> (which conflicts with C99) with strtok_r().  This does mean that
> line_buf is modified but this variable is only used as an argument
> to process_line() and is freed thereafter.
> 
> I made this change as part of the port of libselinux to SEBSD and
> SEDarwin.
> 
>  - todd

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

I made a few updates for style (the !! thing was too clever for me) and 
merged into trunk and stable. Actual merged version is attached.

> --- matchpathcon.c	2007-01-25 14:19:39.000000000 -0500
> +++ matchpathcon.c	2007-01-25 14:21:32.000000000 -0500
> @@ -444,7 +444,7 @@
>  			int pass, unsigned lineno)
>  {
>  	int items, len, regerr, ret;
> -	char *buf_p;
> +	char *buf_p, *ptr;
>  	char *regex, *type, *context;
>  	const char *reg_buf;
>  	char *anchored_regex;
> @@ -459,7 +459,11 @@
>  	/* Skip comment lines and empty lines. */
>  	if (*buf_p == '#' || *buf_p == 0)
>  		return 0;
> -	items = sscanf(line_buf, "%as %as %as", &regex, &type, &context);
> +
> +	regex = strtok_r(buf_p, " \t", &ptr);
> +	type = strtok_r(NULL, " \t", &ptr);
> +	context = strtok_r(NULL, " \t", &ptr);
> +	items = !!regex + !!type + !!context;
>  	if (items < 2) {
>  		myprintf("%s:  line %d is missing fields, skipping\n", path,
>  			 lineno);
> @@ -470,6 +474,15 @@
>  		type = NULL;
>  	}
>  
> +	regex = strdup(regex);
> +	if (type != NULL)
> +		type = strdup(type);
> +	context = strdup(context);
> +	if (!!regex + !!type + !!context != items) {
> +		ret = -1;
> +		goto finish;
> +	}
> +
>  	reg_buf = regex;
>  	len = get_stem_from_spec(reg_buf);
>  	if (len && prefix && strncmp(prefix, regex, len)) {
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--------------020101080000060400030505
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Index: libselinux/src/matchpathcon.c
===================================================================
--- libselinux/src/matchpathcon.c	(revision 2209)
+++ libselinux/src/matchpathcon.c	(working copy)
@@ -444,7 +444,7 @@
 			int pass, unsigned lineno)
 {
 	int items, len, regerr, ret;
-	char *buf_p;
+	char *buf_p, *ptr;
 	char *regex, *type, *context;
 	const char *reg_buf;
 	char *anchored_regex;
@@ -459,7 +459,18 @@
 	/* Skip comment lines and empty lines. */
 	if (*buf_p == '#' || *buf_p == 0)
 		return 0;
-	items = sscanf(line_buf, "%as %as %as", &regex, &type, &context);
+
+	items = 0;
+	regex = strtok_r(buf_p, " \t", &ptr);
+	if (regex)
+		items += 1;
+	type = strtok_r(NULL, " \t", &ptr);
+	if (type)
+		items += 1;
+	context = strtok_r(NULL, " \t", &ptr);
+	if (context)
+		items += 1;
+	
 	if (items < 2) {
 		myprintf("%s:  line %d is missing fields, skipping\n", path,
 			 lineno);
@@ -470,6 +481,23 @@
 		type = NULL;
 	}
 
+	regex = strdup(regex);
+	if (!regex) {
+		return -1;
+	}
+	if (type) {
+		type = strdup(type);
+		if (!type) {
+			ret = -1;
+			goto finish;
+		}
+	}
+	context = strdup(context);
+	if (!context) {
+		ret = -1;
+		goto finish;
+	}
+
 	reg_buf = regex;
 	len = get_stem_from_spec(reg_buf);
 	if (len && prefix && strncmp(prefix, regex, len)) {

--------------020101080000060400030505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
