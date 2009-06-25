Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5PCxZYg012831
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 08:59:35 -0400
Received: from e36.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5PCxL0s016389
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 12:59:21 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5PCw6E1020311
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 06:58:06 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5PCxYqL172360
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 06:59:34 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5PCxWbe028446
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 06:59:34 -0600
Date: Thu, 25 Jun 2009 07:59:36 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
Message-ID: <20090625125936.GA30349@us.ibm.com>
References: <20090620013216.GA4435@us.ibm.com> <1245779751.27538.14.camel@localhost.localdomain> <20090623181810.GA23644@us.ibm.com> <20090623195703.GA25469@us.ibm.com> <1245849008.9669.13.camel@moss-pluto.epoch.ncsc.mil> <20090624220736.GA21134@us.ibm.com> <1245933275.9669.100.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1245933275.9669.100.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> On Wed, 2009-06-24 at 17:07 -0500, Serge E. Hallyn wrote:
> > Oh, no.  I wasn't thinking right.
> > 
> > The objects are actually restored through calls to do_shmget() etc,
> > so that security_xyz_alloc() already gets called.
> 
> Does this mean that the objects temporarily exist in the wrong security
> context and are accessible to other threads during the interval between
> creation and when they get "restored" to the right security context?

They get restored in a private IPC namespace so they aren't accessible
to any live tasks.  Also, the objects will be created using the default
context for the program doing sys_restore(), running as app_restore_t or
something, so presumably a policy could ensure that such temporary
objects aren't readable by anyone else, just in case something goes
wrong before the security_ipcxyz_restore(), right?

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
