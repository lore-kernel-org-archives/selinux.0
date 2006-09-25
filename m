Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PFOEwd015905
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 11:24:14 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PFNfcl025367
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:23:42 GMT
Message-ID: <4517F48A.80506@redhat.com>
Date: Mon, 25 Sep 2006 11:23:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joy Latten <latten@austin.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        redhat-lspp <redhat-lspp@redhat.com>
Subject: [Fwd: How should we handle polmatch avcs?]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Seems like we have a problem with current OpenSwan/IPSec stuff.

I believe that some of these are bugs in the implementation.

-------- Original Message --------
Subject: 	How should we handle polmatch avcs?
Date: 	Sat, 23 Sep 2006 06:59:30 -0400
From: 	Daniel J Walsh <dwalsh@redhat.com>
To: 	Stephen Smalley <sds@tycho.nsa.gov>, "Christopher J. PeBenito" 
<cpebenito@tresys.com>



https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=207304

allow initrc_t self:association polmatch;
allow unlabeled_t initrc_t:association polmatch;
allow unlabeled_t self:association polmatch;




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
