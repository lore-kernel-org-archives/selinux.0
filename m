Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4V1Ne9a008804
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 21:23:41 -0400
Received: from smtp4.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4V1Nepq008525
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 01:23:40 GMT
Received: from BLUMS0022.bluelnk.net (blums0022.na.baesystems.com [10.40.96.145])
	by smtp4.na.baesystems.com (8.13.6/8.13.6) with ESMTP id l4V1NDPv009552
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 21:23:13 -0400 (EDT)
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by smtp1.na.baesystems.com (8.13.6/8.13.6) with ESMTP id l4V1Nc7V019912
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 21:23:39 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: pipefs issue
Date: Wed, 30 May 2007 18:23:38 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01DBEF78@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Cc: "Jensen, Curtis R \(US SSA\)" <curtis.jensen@baesystems.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've got a java process running in the datalabeler_t domain at the s2
mls level, which kicks off a c++ executable in the import_t domain. 

There appears to be some inter-process communication being set up using
pipefs between the parent and child process which is causing mls
constraint issues. I'm not familiar with pipefs and I'm not explicitly
creating this communication, either linux or java is implicitly creating
it for me.

Is this configurable so that I can prevent the pipefs from being
created?

Alternatively, can I satisfy the below AVC denial messages without
giving the import_t domain mlsfilereadup privilege? I don't mind giving
the datalabeler_t domain extra privileges like writedown or readup, but
I don't want to give the import_t domain those kind of mls privileges.

type=AVC msg=audit(1180552217.128:260021): avc:  denied  { read } for
pid=2585 comm="SimulatedImport" name="[4155253]" dev=pipefs ino=4155253
scontext=m2_u:system_r:import_t:s1
tcontext=m2_u:system_r:datalabeler_t:s2-s15:c0.c255 tclass=fifo_file

type=AVC msg=audit(1180552217.128:260021): avc:  denied  { write } for
pid=2585 comm="SimulatedImport" name="[4155252]" dev=pipefs ino=4155252
scontext=m2_u:system_r:import_t:s1
tcontext=m2_u:system_r:datalabeler_t:s2-s15:c0.c255 tclass=fifo_file

type=AVC msg=audit(1180552217.128:260021): avc:  denied  { write } for
pid=2585 comm="SimulatedImport" name="[4155254]" dev=pipefs ino=4155254
scontext=m2_u:system_r:import_t:s1
tcontext=m2_u:system_r:datalabeler_t:s2-s15:c0.c255 tclass=fifo_file

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
