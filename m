Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h96FeqWt005815
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 11:40:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h96Fej0p015256
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 15:40:45 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id h96Fejr7015253
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 15:40:45 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h96Fej130627
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 11:40:45 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h96Feic19894
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 11:40:44 -0400
Date: Sat, 4 Oct 2003 09:12:07 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: serial devices
In-Reply-To: <200310041420.21903.russell@coker.com.au>
Message-ID: <Pine.LNX.4.44.0310040911070.24442-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 4 Oct 2003, Russell Coker wrote:

> Another possibility is to have different types for the device as used by cups, 
> pppd, and minicom.  Then change the contexts of serial devices to indicate 
> which service they are for, but this could be painful to administer.
> 
> What do you think?

It would be good not to need to run so many things in sysadm_t, but 
complicated administration is also a security problem.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
