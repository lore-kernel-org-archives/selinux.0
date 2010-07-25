Date: Mon, 26 Jul 2010 09:55:45 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 5/5] SELinux: Move execmod to the common perms
In-Reply-To: <1279919277.32473.48.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.1007260955330.788@tundra.namei.org>
References: <20100723154351.13217.85595.stgit@paris.rdu.redhat.com>  <20100723154415.13217.49052.stgit@paris.rdu.redhat.com> <1279919277.32473.48.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 23 Jul 2010, Stephen Smalley wrote:

> On Fri, 2010-07-23 at 11:44 -0400, Eric Paris wrote:
> > execmod "could" show up on non regular files and non chr files.  The current
> > implementation would actually make these checks against non-existant bits
> > since the code assumes the execmod permission is same for all file types.
> > To make this line up for chr files we had to define execute_no_trans and
> > entrypoint permissions.  These permissions are unreachable and only existed
> > to to make FILE__EXECMOD and CHR_FILE__EXECMOD the same.  This patch drops
> > those needless perms as well.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
> for the entire series.  Although I think I already did that before.

Thanks, all applied.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
