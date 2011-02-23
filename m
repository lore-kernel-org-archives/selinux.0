Subject: Re: [PATCH] selinux: drop unused packet flow permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <4D650E67.2040800@tresys.com>
References: <20110223025438.17536.15362.stgit@paris.rdu.redhat.com>
	 <4D650E67.2040800@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Feb 2011 08:57:46 -0500
Message-ID: <1298469466.13789.6.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-02-23 at 08:40 -0500, Christopher J. PeBenito wrote:
> On 02/22/11 21:54, Eric Paris wrote:
> > These permissions are not used and can be dropped in the kernel
> > definitions.
> > 
> > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> > 
> >  security/selinux/include/classmap.h |    3 +--
> >  1 files changed, 1 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> > index e9a8eb7..fffd855 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -132,8 +132,7 @@ struct security_class_mapping secclass_map[] = {
> >  	{ "appletalk_socket",
> >  	  { COMMON_SOCK_PERMS, NULL } },
> >  	{ "packet",
> > -	  { "send", "recv", "relabelto", "flow_in", "flow_out",
> > -	    "forward_in", "forward_out", NULL } },
> > +	  { "send", "recv", "relabelto", "forward_in", "forward_out", NULL } },
> >  	{ "key",
> >  	  { "view", "read", "write", "search", "link", "setattr", "create",
> >  	    NULL } },
> 
> I'm concerned about this.  Won't this break refpolicy?  I can't keep two
> sets of object class definitions around for systems that still have the
> flow_in and flow_out perms.

This just removes the entries in the kernel table so that the kernel
does not try to look up these permission strings in the policy.  As the
kernel is now dynamically mapping class/perm values, we don't need to
keep placeholders in its tables for obsolete permissions that are not in
use within the kernel (no hook function in the current kernel uses these
permissions).  But we will keep the definitions in refpolicy for older
kernels that predate the dynamic class/perm mappings.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
