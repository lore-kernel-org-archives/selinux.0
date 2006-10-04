Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94GVMuo021045
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 12:31:23 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94GUB5l018597
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 16:30:11 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
Date: Wed, 4 Oct 2006 12:25:28 -0400
Cc: Klaus Weidner <klaus@atsec.com>, Linda Knippers <linda.knippers@hp.com>,
        paul.moore@hp.com, selinux@tycho.nsa.gov, vyekkirala@TrustedCS.com,
        jmorris@namei.org, Joy Latten <latten@austin.ibm.com>,
        eparis@parisplace.org, Joshua Brindle <method@gentoo.org>
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com> <4522CAB7.6090109@hp.com> <20061003212659.GA10195@w-m-p.com>
In-Reply-To: <20061003212659.GA10195@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610041225.28836.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 03 October 2006 17:26, Klaus Weidner wrote:
> Can ausearch handle the auditallow AVC records in the audit log correctly
> for common fields such as auid and subject MLS label?

Yes it can, but there's no way to distinguish the message's proper meaning. 
You get an AVC with granted. How do you figure out that was a configuration 
change?

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
