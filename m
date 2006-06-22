Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5MHQqcu019726
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 13:26:52 -0400
Received: from web51512.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k5MHQpuc014520
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 17:26:51 GMT
Message-ID: <20060622172536.41778.qmail@web51512.mail.yahoo.com>
Date: Thu, 22 Jun 2006 10:25:36 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] libselinux: add support for keycreate attribute
To: Michael LeMay <mdlemay@epoch.ncsc.mil>, sds@tycho.nsa.gov,
        eparis@parisplace.org, David Howells <dhowells@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1150987778.3400.9.camel@moss-tarheels.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Just a couple of comments...

diff -X dontdiff -uprN libselinux.orig/src/getkeycreatecon.c 
libselinux/src/getkeycreatecon.c
--- libselinux.orig/src/getkeycreatecon.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux/src/getkeycreatecon.c	2006-06-02 09:38:23.000000000 -0400
+int getkeycreatecon_raw(security_context_t *context)
+{

<snip>
+	ret = read(fd, buf, size-1);
+	if (ret < 0)
+		goto out2;

Shouldn't this be wrapped in a do...while loop to avoid early exit due to EINTR?

do {
  ret = read(fd, buf, size-1);
} while (ret < 0 && errno == EINTR);
if (ret < 0)
  goto out2;

+	*context = strdup(buf);
+	if (!(*context)) {
+		ret = -1;
+		goto out2;
+	}

buf was malloc'ed above...why strdup it? To me its just another chance for error.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
