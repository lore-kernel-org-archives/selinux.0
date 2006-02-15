Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1GDxgXf026697
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 08:59:43 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1GDwITW000720
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 13:58:18 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k1GDwbPU016706
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 08:58:37 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k1GDwbqB016705
	for selinux@tycho.nsa.gov; Thu, 16 Feb 2006 08:58:37 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1FIE9Xf015186
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2006 13:14:09 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1FIE6tx008281
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2006 18:14:06 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: Linda Knippers <linda.knippers@hp.com>
Subject: Re: [RFC][PATCH] collect security labels on user processes generating audit messages
Date: Wed, 15 Feb 2006 13:14:34 -0500
Cc: linux-audit@redhat.com, "Timothy R. Chavez" <tinytim@us.ibm.com>,
   James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com> <200602151122.37945.sgrubb@redhat.com> <43F36244.7040000@hp.com>
In-Reply-To: <43F36244.7040000@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602151314.34956.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 15 February 2006 12:17, Linda Knippers wrote:
> How can I tell from the audit records that the file name was "(null)"
> vs. having "(null)" manufactured by the audit system?

ls -i "(null)"

and then compare inode values.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
