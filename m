Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9HfRc9031978
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 12:41:27 -0500
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA9HfRf4006385
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 17:41:27 GMT
Received: by an-out-0708.google.com with SMTP id c31so90446ana
        for <selinux@tycho.nsa.gov>; Fri, 09 Nov 2007 09:41:17 -0800 (PST)
Reply-To: w.chimiak@ieee.org
To: selinux@tycho.nsa.gov
Subject: allow statement OK?
Date: Fri, 9 Nov 2007 12:38:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711091238.34883.w.chimiak@ieee.org>
From: Bill Chimiak <wch1m1@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I got a

	avc: denied { search } for comm="pam_console_app" dev=sdb6 egid=650 euid=0 
exe="/sbin/pam_console_apply" exit=-13 fsgid=650 fsuid=0 gid=650 items=0 
name="gdm" pid=2693 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 
sgid=650 subj=system_u:system_r:pam_console_t:s0-s0:c0.c1023 suid=0 
tclass=dir tcontext=system_u:object_r:xserver_log_t:s0 tty=(none) uid=0 


audit2allow recommended:

	allow pam_console_t xserver_log_t:dir search;

Is this a reasonable module for me to add?  To me it seems benign.

-- 
William Chimiak
Laboratory for Telecommunications Sciences
8080 Greenmead Road
College Park, MD
240-949-2778

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
