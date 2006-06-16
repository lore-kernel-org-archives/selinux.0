Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5GK18wu003451
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 16:01:08 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5GK17Ig017958
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 20:01:07 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5GK17sD009093
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 16:01:07 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5GK17f5022964
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 16:01:07 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Got up at 5 AM, and thought I would try to write a new role
Date: Fri, 16 Jun 2006 16:01:38 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <44930D28.2010103@redhat.com>
In-Reply-To: <44930D28.2010103@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606161601.38912.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 16 June 2006 15:57, Daniel J Walsh wrote:
> I wanted to try to create an auditadm_r.

Didn't you mean httpdadm_r  :)

I think we should bust up the systemadm role a little more and make it 
composed of some other roles. RBAC says we are supposed to support 
composition, so we can use it here.

Some other roles might be backup admin, db admin. mail admin.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
