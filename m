Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p31GBBtX017401
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 12:11:11 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p31GBAmB019380
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 16:11:10 GMT
Received: by vws13 with SMTP id 13so3336056vws.12
        for <selinux@tycho.nsa.gov>; Fri, 01 Apr 2011 09:11:09 -0700 (PDT)
From: Bill Chimiak <wch1m1@gmail.com>
To: "selinux-mailing-list" <selinux@tycho.nsa.gov>
Subject: fwknop, fwknopd,  fwknop_serv
Date: Fri, 1 Apr 2011 12:10:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201104011210.36367.w.chimiak@ieee.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

fwknop is a single passphrase authorization system.
Fairly cool.  selinux did not like fwknop out of the box.
It wanted a new module:

module iptab2log 1.0;

require {
        type var_log_t;
        type iptables_t;
        class file write;
}

#============= iptables_t ==============
allow iptables_t var_log_t:file write;

It works now.  Was there another way to do this?
William J. Chimiak
Laboratory for Telecommunication Sciences 
8080 Greenmead Drive,  College Park, MD 20740
301-422-5217

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
