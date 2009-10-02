Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n92MF5EK019127
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 18:15:05 -0400
Received: from e34.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n92MGccF013195
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 22:16:38 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n92MASnN025269
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 16:10:28 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n92MEw4T213614
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 16:14:58 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n92MEvmJ005601
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 16:14:57 -0600
Date: Fri, 2 Oct 2009 17:14:56 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Oren Laadan <orenl@librato.com>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] cr: add selinux support (v4)
Message-ID: <20091002221456.GD7446@us.ibm.com>
References: <20091002034916.GA16871@us.ibm.com> <20091002035250.GC16920@us.ibm.com> <4AC66D47.5050305@librato.com> <20091002220556.GB7446@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091002220556.GB7446@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Quoting Oren Laadan (orenl@librato.com):
> > Please place this (and a few others also in other patches) debug-only
> > changes in a separate patch - it will make my life tremendously easier
> > when merging v18-dev to a nice and clean v19.
> 
> Ok, I'll resend those just to containers@ to spare the lsm folks.

Oops, I was thinking this was the patch 1/3.  I won't spare the
lsm folks from revised patches 2/3 or 3/3 :)

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
