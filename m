Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94GdG48021529
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 12:39:16 -0400
Received: from e36.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94GceUx028345
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 16:38:41 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k94GdGPN002973
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 12:39:16 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k94GdF7R360510
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 10:39:15 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k94GdE27020119
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 10:39:15 -0600
Date: Wed, 4 Oct 2006 11:39:12 -0500
From: "George C. Wilson" <ltcgcw@us.ibm.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: redhat-lspp@redhat.com, paul.moore@hp.com,
        Joy Latten <latten@austin.ibm.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Klaus Weidner <klaus@atsec.com>, vyekkirala@TrustedCS.com,
        jmorris@namei.org, selinux@tycho.nsa.gov,
        Joshua Brindle <method@gentoo.org>, eparis@parisplace.org
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
Message-ID: <20061004163912.GA27779@us.ibm.com>
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com> <4522CAB7.6090109@hp.com> <20061003212659.GA10195@w-m-p.com> <200610041225.28836.sgrubb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200610041225.28836.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 04, 2006 at 12:25:28PM -0400, Steve Grubb wrote:
> On Tuesday 03 October 2006 17:26, Klaus Weidner wrote:
> > Can ausearch handle the auditallow AVC records in the audit log correctly
> > for common fields such as auid and subject MLS label?
> 
> Yes it can, but there's no way to distinguish the message's proper meaning. 
> You get an AVC with granted. How do you figure out that was a configuration 
> change?
> 
> -Steve
>

Agree.  Though the information is in the AVC records, it would be difficult for
an admin to use.  Also, we don't want admins to have to change the policy just
to audit in one particular case.  Joy is looking at adding hooks in the SPD add
and delete paths to fix this.

-- 
George Wilson <ltcgcw@us.ibm.com>
IBM Linux Technology Center

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
