Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6VEp1fX015568
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 10:51:01 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6VEp05I006169
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 14:51:00 GMT
Received: by nf-out-0910.google.com with SMTP id k4so294775nfd
        for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 07:50:59 -0700 (PDT)
Message-ID: <911f42990707310750r349d11c4x9132c68d83cf8cfc@mail.gmail.com>
Date: Tue, 31 Jul 2007 16:50:27 +0200
From: "Jan-Frode Myklebust" <janfrode@tanso.net>
To: selinux@tycho.nsa.gov
Subject: setroubleshooter/sealert on central loghost?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We run a centralized syslog server, and separate all syslogged avc
into a separate log file. Is it possible to have setroubleshooter/sealert
use this log file ?

Also it would be nice if one could get the correct "Host Name" in
the setroubleshhot browser and alerts. Guess that also will have
to be added to the avc-log lines is some format.. I tried faking it
with:

type=AVC msg=audit(1185725759.359:2945): avc:  denied  { search } for
pid=2077 hostname="my.hostname.com" comm="snmpd" name="fs" dev=proc
ino=4026531869 scontext=system_u:system_r:snmpd_t:s0
tcontext=system_u:object_r:sysctl_fs_t:s0 tclass=dir

But the troubleshooter doesn't pick up the hostname. Any ideas ?


 -jf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
