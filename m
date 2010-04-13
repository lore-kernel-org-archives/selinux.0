Subject: Re: [PATCH 1/2] selinux: place open in the common file perms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1271161756.2815.211.camel@gorn.columbia.tresys.com>
References: <20100412231947.21118.77411.stgit@paris.rdu.redhat.com>
	 <1271161756.2815.211.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 13 Apr 2010 08:34:48 -0400
Message-Id: <1271162088.9577.1.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-04-13 at 08:29 -0400, Christopher J. PeBenito wrote:
> On Mon, 2010-04-12 at 19:19 -0400, Eric Paris wrote:
> > kernel can dynamically remap perms.  Drop the open lookup table and put open
> > in the common file perms.
> 
> So I need to move open into the common perms in the policy?  Thats going
> to be a nasty compatibility problem for older systems.

No, you don't have to change anything in the policy - that's the point
of the dynamic class/perm discovery support in the kernel.  The kernel
will map its notion of open permission to the policy values at policy
load time and will then map access vectors accordingly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
