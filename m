Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4UL9JI4001505
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2003 17:09:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4UL9ItV015524
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2003 21:09:18 GMT
Received: from smtp-out.comcast.net (smtp-out.comcast.net [24.153.64.109])
        by jazzband.ncsc.mil  with ESMTP id h4UL9Ial015521 for <selinux@tycho.nsa.gov>; Fri, 30 May 2003 21:09:18 GMT
Received: from comcast.net (pcp830001pcs.nrockv01.md.comcast.net [68.50.129.6])
 by mtaout05.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with ESMTP id <0HFP00BRAXDCBN@mtaout05.icomcast.net> for
 selinux@tycho.nsa.gov; Fri, 30 May 2003 17:08:01 -0400 (EDT)
Date: Fri, 30 May 2003 17:09:30 -0400
From: John Wolff <jrwolff@comcast.net>
Subject: Compaq DL-360
To: selinux@tycho.nsa.gov
Message-id: <3ED7C88A.7060209@comcast.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has anyone attempted to get SE Linux running on a Compaq DL-360 server?
I have been trying to get SE Linux running on said machine and have been 
having deficulty.  Specifically, while RH 7.3 runs fine, a kernel build 
based on the installed kernel with the SL Linux modules loaded (without 
the MLS at this point) fails to boot.  What I get is kernel panic when 
the boot sequence gets to the point where the OS attempts to mount the 
SCSI drives.  I have downloaded and installed the latest drivers from 
Compaq to no avail.  The DL-360 uses a proprietary SCSI/RAID system.  
Whether I have the RAID going or not, SE Linux dies in the same place in 
the boot sequence with the same kernel panic.

jc



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
