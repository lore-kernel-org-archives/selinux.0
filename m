Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA18765
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 15:53:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA00116
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 19:52:16 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
        by jazzband.ncsc.mil  with ESMTP id TAA00112 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 19:52:16 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Timothy Wood'" <timothy@hallcomp.com>,
        "'Stephen Smalley'" <sds@tislabs.com>
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: sysadm_tty_device_t
Date: Thu, 11 Jul 2002 15:53:44 -0400
Message-ID: <00dd01c22914$a9b23b30$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
In-Reply-To: <1026417306.1659.18.camel@phobos>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

That's what it seems to be.  It does look like an accident waiting to
happen as well.

Ed

=> -----Original Message-----
=> From: Timothy Wood [mailto:timothy@hallcomp.com]
=> Sent: Thursday, July 11, 2002 3:55 PM
=> To: Stephen Smalley
=> Cc: Ed Street; 'SE Linux'
=> Subject: RE: sysadm_tty_device_t
=> 
=> В Чтв, 11.07.2002, в 13:39, Stephen Smalley написал:
=> >
=> > On Thu, 11 Jul 2002, Ed Street wrote:
=> >
=> > > And sysadm_tty_device_t?
=> >
=> > That was my point.  The ttys start in tty_device_t.  If login or
=> newrole
=> > creates a sysadm_r:sysadm_t shell, then it relabels the tty to
=> > sysadm_tty_device_t.  If login or newrole creates a user_r:user_t
=> shell,
=> > then it relabels the tty to user_tty_device_t.  These relabeling
=> > operations are based on type_change rules in the policy
configuration.
=> >
=> > --
=> > Stephen D. Smalley, NAI Labs
=> > ssmalley@nai.com
=> >
=> 
=> So no matter what the file context is login and newrole relabel them
=> when they take control of the tty, correct?  If so, then it is really
up
=> to the controlling program (or program that needs control in this
case)
=> and so syslog needs premissions to relabel and/or control the tty,
=> yes/no?
=> 
=> Timothy,


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
