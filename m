Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5G4mvCH003799
	for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2009 00:49:09 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5G4nMqh003434
	for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2009 04:49:23 GMT
Received: by ewy7 with SMTP id 7so6893516ewy.18
        for <selinux@tycho.nsa.gov>; Mon, 15 Jun 2009 21:48:55 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 16 Jun 2009 06:48:55 +0200
Message-ID: <aa22f0200906152148g77b0c37fo56c78fc5bb7dfa71@mail.gmail.com>
Subject: Possible bug with fd class?
From: Jason Johnson <jason.johnson.081@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,

I am using SELinux on the latest debian.  It has a few access
violations here and there, but the one that concerns me most is:

kernel: [1298522.518701] type=1400 audit(1245126419.780:229): avc:
denied  { use } for  pid=29944 comm="syslog-ng" path="/dev/null"
dev=tmpfs ino=634 scontext=system_u:system_r:syslogd_t:s0
tcontext=system_u:system_r:logrotate_t:s0-s0:c0.c1023 tclass=fd


/dev/null is:

# semanage fcontext -l|grep null_device_t
/dev/null                                          character device
system_u:object_r:null_device_t:s0
/dev/full                                          character device
system_u:object_r:null_device_t:s0


I don't see a way with semanage to set anything about class "fd" and
sesearch didn't seem to turn anything up.  How could /dev/null fd be
in context logrotate_t?

I could just add an allow for this on a local module, but my concern
is: can a user program just set arbitrary fd's to it's own target
context as well?

I appreciate any insight you all can give.

Sincerely,
Jason

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
