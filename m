Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1GDxgXf026699
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 08:59:42 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1GDxe8P006147
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 13:59:40 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k1GDwb5f016710
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 08:58:37 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k1GDwb1g016709
	for selinux@tycho.nsa.gov; Thu, 16 Feb 2006 08:58:37 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1FIKLXf015280
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2006 13:20:21 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1FIKItx009096
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2006 18:20:18 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: Linda Knippers <linda.knippers@hp.com>
Subject: Re: [RFC][PATCH] collect security labels on user processes generating audit messages
Date: Wed, 15 Feb 2006 13:20:50 -0500
Cc: linux-audit@redhat.com, "Timothy R. Chavez" <tinytim@us.ibm.com>,
   James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com> <200602151122.37945.sgrubb@redhat.com> <43F36244.7040000@hp.com>
In-Reply-To: <43F36244.7040000@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602151320.51016.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 15 February 2006 12:17, Linda Knippers wrote:
> type=PATH msg=audit(1140192875.311:3789): name="(null)" flags=1
> inode=6537222 dev=fd:01 mode=0100664 ouid=501 ogid=501 rdev=00:00

Wait a second...notice the quote marks around (null). When you have a genuine 
(null) they are not there.

type=PATH msg=audit(02/14/2006 08:54:27.096:24) : item=1 name=(null) 
inode=34681 dev=03:06 mode=dir,700 ouid=root ogid=root rdev=00:00 
obj=system_u:object_r:automount_tmp_t:s0


-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
