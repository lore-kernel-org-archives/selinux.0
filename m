Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LIR2Ig013766
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 14:27:02 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7LIQxYx012786
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 18:26:59 GMT
Subject: Re: [refpolicy] postfix changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <D7E6BD9F-1C0A-49F4-B95B-D311C691A90E@sf-net.com>
References: <D7E6BD9F-1C0A-49F4-B95B-D311C691A90E@sf-net.com>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 18:26:05 +0000
Message-Id: <1187720765.13874.32.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-08-18 at 02:26 -0400, Stefan Schulze Frielinghaus wrote:
--- /usr/src/refpolicy-20070629/policy/modules/services/postfix.if      2007-06-27 17:23:21.000000000 +0200
+++ policy/modules/services/postfix.if  2007-08-16 18:14:02.000000000 +0200
@@ -456,3 +456,11 @@
 
        typeattribute $1 postfix_user_domtrans;
 ')
+
+interface(`postfix_read_master_file',`
+       gen_require(`
+               type postfix_master_t;
+       ')
+
+       allow $1 postfix_master_t:file read;
+')

Needs XML documentation.  Also, its a domain type, so its not
master_file, its master_state.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
