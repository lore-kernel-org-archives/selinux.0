Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SKEfe6028867
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 16:14:41 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SKE5QW026228
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 20:14:06 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Subject: Re: [PATCH] newrole auditing of failures due to user actions
Date: Thu, 28 Sep 2006 16:15:22 -0400
Cc: Linux Audit <linux-audit@redhat.com>, lspp-list <redhat-lspp@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <451C2473.7050102@us.ibm.com> <451C2B03.1060300@us.ibm.com>
In-Reply-To: <451C2B03.1060300@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609281615.22315.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 28 September 2006 16:05, Michael C Thompson wrote:
> > This patch introduces two new point in the code where audit records are
> > generated for newrole. Both points are when the attempt to newrole fails.

>From an audit perspective I think it does the right thing. ACK.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
