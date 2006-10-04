Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94GCmM5020307
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 12:12:48 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94GCCUx024840
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 16:12:13 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
Date: Wed, 4 Oct 2006 12:13:03 -0400
Cc: Linda Knippers <linda.knippers@hp.com>, Joy Latten <latten@austin.ibm.com>,
        paul.moore@hp.com, vyekkirala@TrustedCS.com, jmorris@namei.org,
        selinux@tycho.nsa.gov, Joshua Brindle <method@gentoo.org>,
        eparis@parisplace.org
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com> <1159902988.29928.2.camel@faith.austin.ibm.com> <4522CAB7.6090109@hp.com>
In-Reply-To: <4522CAB7.6090109@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610041213.03223.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 03 October 2006 16:40, Linda Knippers wrote:
> > Dang! Why didn't I think of that! :-)
> > Such a good idea. I will do a quick test and
> > show Klaus and see if it all looks ok to him.
> > Thanks!!!
>
> If we go the auditallow route then we lose some audit record management
> features, like the ability to enable/disble/search for these records,
> don't we?  Do we care?

Yes we care! And we should not do it with auditallow rules. The problem is 
that to SE linux, EVERYTHING is an AVC. There is no separation of meaning by 
using the message type. If an admin wants to query to see all the config 
changes made during a range of time, using AVC's will not be considered in 
the results.

There needs to be a new message type for this or we need to consolidate around 
the ones Paul used for netlabel and change them as needed. This allows better 
reporting and understanding of the system's real status.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
