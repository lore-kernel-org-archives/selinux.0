Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93LRD0O027022
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 17:27:13 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93LQbGw016323
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 21:26:38 GMT
Date: Tue, 3 Oct 2006 16:26:59 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Linda Knippers <linda.knippers@hp.com>
Cc: Joy Latten <latten@austin.ibm.com>, paul.moore@hp.com,
        redhat-lspp@redhat.com, vyekkirala@TrustedCS.com, jmorris@namei.org,
        selinux@tycho.nsa.gov, Joshua Brindle <method@gentoo.org>,
        eparis@parisplace.org
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
Message-ID: <20061003212659.GA10195@w-m-p.com>
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com> <4522B79C.2060405@gentoo.org> <1159902988.29928.2.camel@faith.austin.ibm.com> <4522CAB7.6090109@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4522CAB7.6090109@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 03, 2006 at 04:40:23PM -0400, Linda Knippers wrote:
> If we go the auditallow route then we lose some audit record management
> features, like the ability to enable/disble/search for these records,
> don't we?  Do we care?

Well, you can permit admins to enable/disable the auditallow rule, that
way people who don't want it aren't bothered by the messages. I don't
think that the LSPP requirement to include/exclude messages by user
identity is intended to apply for administrative actions like this.

Can ausearch handle the auditallow AVC records in the audit log correctly
for common fields such as auid and subject MLS label?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
