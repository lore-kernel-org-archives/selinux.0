Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KF8bNW028267
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 10:08:37 -0500
Received: from web51504.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1KF6sox028635
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 15:06:54 GMT
Message-ID: <20070220150528.49241.qmail@web51504.mail.yahoo.com>
Date: Tue, 20 Feb 2007 07:05:27 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: libselinux patch
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB0624.5060907@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>+static int readFD (int fd, char **buf)
>+{
>+    char *p;
>+    size_t size = 16384;

Why this number? Should it be a define somewhere or based off a kernel parameter?

+    int s, filesize;
+
+    *buf = calloc (16384, sizeof (char));

Why calloc? Its not as efficient as plain old malloc.

+    if (*buf == 0)
+        return -1;

0 or NULL? There's a difference on 64 bit machines.

+
+    filesize = 0;
+    do {
+        p = &(*buf) [filesize];
+	do {
+		s = read (fd, p, 16384);
+	} while (s < 0 && errno == EINTR);
+        if (s < 0)
+            break;
+        filesize += s;
+        /* only exit for empty reads */
+        if (s == 0)
+            break;
+        size += s;
+        *buf = realloc (*buf, size);

So, if you get a short read, why are we playing with memory? This is inefficiant
for the _normal_ case. The normal case is that you get about 400 bytes for a
succesful read. I'd say you are better off adjusting the read size on the fly and
only realloc when you have less that 512 bytes left in the buffer so that there
is some hysteresis.

+    } while (1);
+
+    if (filesize == 0 && s < 0) {
+        free (*buf);
+        *buf = NULL;
+        return -1;
+    }
+
+    return filesize;
+}
+



 
____________________________________________________________________________________
Don't pick lemons.
See all the new 2007 cars at Yahoo! Autos.
http://autos.yahoo.com/new_cars.html 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
