Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5PE63Ak023172
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 10:06:03 -0400
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
In-Reply-To: <20090625125936.GA30349@us.ibm.com>
References: <20090620013216.GA4435@us.ibm.com>
	 <1245779751.27538.14.camel@localhost.localdomain>
	 <20090623181810.GA23644@us.ibm.com> <20090623195703.GA25469@us.ibm.com>
	 <1245849008.9669.13.camel@moss-pluto.epoch.ncsc.mil>
	 <20090624220736.GA21134@us.ibm.com>
	 <1245933275.9669.100.camel@moss-pluto.epoch.ncsc.mil>
	 <20090625125936.GA30349@us.ibm.com>
Content-Type: text/plain
Date: Thu, 25 Jun 2009 10:06:02 -0400
Message-Id: <1245938762.22128.9.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-06-25 at 07:59 -0500, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> > On Wed, 2009-06-24 at 17:07 -0500, Serge E. Hallyn wrote:
> > > Oh, no.  I wasn't thinking right.
> > > 
> > > The objects are actually restored through calls to do_shmget() etc,
> > > so that security_xyz_alloc() already gets called.
> > 
> > Does this mean that the objects temporarily exist in the wrong security
> > context and are accessible to other threads during the interval between
> > creation and when they get "restored" to the right security context?
> 
> They get restored in a private IPC namespace so they aren't accessible
> to any live tasks.  Also, the objects will be created using the default
> context for the program doing sys_restore(), running as app_restore_t or
> something, so presumably a policy could ensure that such temporary
> objects aren't readable by anyone else, just in case something goes
> wrong before the security_ipcxyz_restore(), right?

That could be confusing if the program ever needs to legitimately create
any objects of its own for other purposes.  But the private IPC
namespace should be sufficient.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
