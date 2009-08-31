Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7VDbFpZ010809
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 09:40:21 -0400
Received: from e34.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7VDaSXG018822
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 13:36:28 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7VDWxtD020211
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 07:32:59 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7VDavWe260468
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 07:36:59 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7VDasJV026613
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 07:36:56 -0600
Date: Mon, 31 Aug 2009 08:36:56 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2/5] cr: checkpoint the active LSM and add
	RESTART_KEEP_LSM flag
Message-ID: <20090831133656.GC4837@us.ibm.com>
References: <20090828210041.GA27878@us.ibm.com> <20090828210208.GA28048@us.ibm.com> <4A98B1D7.9050108@schaufler-ca.com> <20090829225923.GB12549@hallyn.com> <4A99C1B6.6080504@schaufler-ca.com> <20090830134809.GA14699@hallyn.com> <4A9ACBD4.4020804@schaufler-ca.com> <20090830202412.GA16222@hallyn.com> <4A9AF28D.2030803@schaufler-ca.com> <20090831132258.GB4837@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090831132258.GB4837@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Quoting Casey Schaufler (casey@schaufler-ca.com):
> > Serge E. Hallyn wrote:
> > > Quoting Casey Schaufler (casey@schaufler-ca.com):
> > > So do you think that adding a policy version check in the kernel
> > > at restart would help this?
> 
> For the moment I intend to add a patch on top of these adding two
> security calls:
> 
> 	security_may_checkpoint(ctx) which will authorize the
> 		ability to checkpoint at all, and

I meant:

	security_may_restore(ctx).

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
