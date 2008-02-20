Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KJOqRH025899
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 14:24:52 -0500
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KJOoBs024220
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 19:24:51 GMT
Received: by fk-out-0910.google.com with SMTP id 18so5209143fkq.2
        for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 11:24:50 -0800 (PST)
Message-ID: <cadfc0e40802201124l5f8b2330x159eb3f7485687c4@mail.gmail.com>
Date: Wed, 20 Feb 2008 13:24:50 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: FC8 enforcing auditd, mcstransd, NFS statd fail to start
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

type=AVC msg=audit(1197625021.926:66): avc:  denied  { write } for
pid=1494 comm="audispd" path="socket:[7238]" dev=sockfs ino=7238
scontext=system_u:system_r:auditd_t:s15:c0.c1023
tcontext=system_u:system_r:auditd_t:s0-s15:c0.c1023
tclass=unix_stream_socket

type=AVC msg=audit(1203524274.667:562): avc:  denied  { use } for
pid=19909 comm="mcstransd" path="/lib/ld-2.7.so" dev=dm-0 ino=2359430
scontext=system_u:system_r:setrans_t:s15:c0.c1023
tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023 tclass=fd

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
