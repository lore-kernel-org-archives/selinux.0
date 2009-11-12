Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nACGNIG2011674
	for <selinux@tycho.nsa.gov>; Thu, 12 Nov 2009 11:23:18 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nACGPIqM027164
	for <selinux@tycho.nsa.gov>; Thu, 12 Nov 2009 16:25:18 GMT
Message-ID: <4AFC3673.4020505@redhat.com>
Date: Thu, 12 Nov 2009 11:23:15 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Add modules support to semanage
References: <C7207217.AFD8F%csellers@tresys.com>
In-Reply-To: <C7207217.AFD8F%csellers@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------050903030402070602090808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050903030402070602090808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/11/2009 01:52 PM, Chad Sellers wrote:
> On 9/30/09 2:33 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> 
>> Includes enable and disable.
>>
> I presume I should hold off on this patch until you have a chance to
> resubmit the libsemanage support that it relies on. Let me know if that's
> not the case.
> 
> Thanks,
> Chad
> 
Lets do this patch.


Moves load_policy from /usr/sbin to /sbin

Removed cruft.

--------------050903030402070602090808
Content-Type: text/plain;
 name="selinux_load_policy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="selinux_load_policy.patch"

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 23661bf..931448f 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -263,7 +263,13 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	     calloc(1, sizeof(*(current_conf->load_policy)))) == NULL) {
 		return -1;
 	}
-	if ((conf->load_policy->path = strdup("/usr/sbin/load_policy")) == NULL) {
+
+	if (access("/sbin/load_policy", X_OK) == 0) {
+		conf->load_policy->path = strdup("/sbin/load_policy");
+	} else {
+		conf->load_policy->path = strdup("/usr/sbin/load_policy");
+	}
+	if (conf->load_policy->path == NULL)
 		return -1;
 	}
 	conf->load_policy->args = NULL;
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index 2dd2943..91dc6c8 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -1,6 +1,7 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
-SBINDIR ?= $(PREFIX)/sbin
+SBINDIR ?= $(DESTDIR)/sbin
+USRSBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
@@ -17,6 +18,8 @@ install: all
 	install -m 755 $(TARGETS) $(SBINDIR)
 	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
 	install -m 644 load_policy.8 $(MANDIR)/man8/
+	-mkdir -p $(USRSBINDIR)
+	ln -s /sbin/load_policy $(USRSBINDIR)/load_policy
 
 clean:
 	-rm -f $(TARGETS) *.o 

--------------050903030402070602090808--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
