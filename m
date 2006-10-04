Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94GXcF5021178
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 12:33:38 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94GX2Ux027332
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 16:33:02 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
Date: Wed, 4 Oct 2006 12:34:20 -0400
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Joshua Brindle <method@gentoo.org>, Joy Latten <latten@austin.ibm.com>,
        vyekkirala@TrustedCS.com, jmorris@namei.org, paul.moore@hp.com,
        selinux@tycho.nsa.gov, eparis@parisplace.org
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com> <4522D5C2.8060702@hp.com> <4522D667.5030401@mentalrootkit.com>
In-Reply-To: <4522D667.5030401@mentalrootkit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610041234.20175.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 03 October 2006 17:30, Karl MacMillan wrote:
> > I meant with the audit tools, so using auditctl to add/remove rules and
> > ausearch for looking for specific record types.
>
> As I said in my other mail the searching should be fine. Why does the
> addition or removal need to be handled by auditctl?

Because we want to teach admins to use the audit system to...audit. Its really 
awkward to tell them that you can audit almost everything, but if you need to 
do this one other thing, you need to change your policy to do it.

Also, the audit system records changes to itself so that you can see when that 
rule disappeared from the config. Doing it in policy, all you get a policy 
loaded message which doesn't tell you what in the policy changed.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
