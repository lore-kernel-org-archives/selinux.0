Subject: Re: type bounds audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        sgrubb@redhat.com, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <1245071835.3247.57.camel@dhcp231-142.rdu.redhat.com>
References: <1244730288.10762.120.camel@localhost.localdomain>
	 <4A31A33F.2040504@ak.jp.nec.com>
	 <1244807594.18947.62.camel@localhost.localdomain>
	 <4A35F091.6000202@ak.jp.nec.com>
	 <1245071835.3247.57.camel@dhcp231-142.rdu.redhat.com>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 10:01:28 -0400
Message-Id: <1245074488.4078.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-06-15 at 09:17 -0400, Eric Paris wrote:
> On Mon, 2009-06-15 at 15:56 +0900, KaiGai Kohei wrote:
> > The attached patch allows to generate audit messages on access violations
> > related to bounds types.
> > 
> > 1. When a multithread process gives an unbounded domain to setcon(3)
> >    to change its domain dynamically, the current kernel denies it
> >    without any notification or audit messages.
> >    This patch adds an audit_log() in the security_bounded_transition()
> >    to generate an audit message, when the dynamic type transition is
> >    failed due to the bounds violation.
> > 
> >    Example:
> >    type=SELINUX_ERR msg=audit(1245046106.725:65): SELinux: bounds violation: \
> >        domain transition from httpd_t to guest_webapp_t
> 
> No, no 1000 times no.  We've finally got a new SELinux audit message
> that tools don't understand.  I'm not about to suggest we continue to
> print them in some new non-standard arbitrary format.  Everything that
> includes audit_log_* from now on better be of the type key=value.
> 
> How would people on list feel about?
> 
> type=SELINUX_ERR msg=audit(1245046106.725:65): lsm="SELinux" \
>     op="bounds violation on domain transition" type1="httpd_t" \
>     type2="guest_webapp_t"

Do we really need lsm="SELinux" given type=SELINUX_ERR?  Or is that for
the case where auditd isn't running and we lose the type= prefix
information?

> This would be the only place I can remember that we only output the type
> instead of the complete context.  Why not ocontext= and ncontext=?  I
> don't care what we call it, but I want it all to be key=value pairs and
> I prefer that we (the audit system) starts making much heavier use of
> audit_log_string() which includes the ""
> 
> > 2. When a set of permissions are masked due to the bounds violations,
> >    it shall be reported on the type_attribute_bounds_av() invoked from
> >    context_struct_context_av(), but it keeps silent on any AVC denials.
> >    It may make unclear what permissions were in violation of the boundary.
> >    This patch adds the "masked" field on av_decision, and it reports
> >    violated permissions on AVC denials.
> > 
> >    Example:
> >    type=AVC msg=audit(1245046439.315:72): avc:  denied  { create }     \
> >      for pid=3080 comm="httpd" name="hoge"                             \
> >      scontext=unconfined_u:system_r:user_webapp_t:s0                   \
> >      tcontext=unconfined_u:object_r:httpd_sys_content_t:s0 tclass=file \
> >      bounds: { create }
> >      ^^^^^^^^^^^^^^^^^^
> 
> This one I'm still unhappy about but since it is continuing the
> tradition of hard to parse audit rules I'm ok if it stays (assuming
> tools like audit2allow don't get confused)
> 
> Now might be a perfect time to start emitting permissions in a better
> format though, maybe someday the rest of selinux could convert to an
> easier to parse format (ha ha, ok, I know it's funny)
> 
> bounds="create"
> 
> someday we might have perms="read write create open ioctl" instead of
> { ... } ???
> 
> ???

This is interesting - I was expecting KaiGai to just add the masked
permissions to the existing av boundary violation message generated
during compute_av processing, not export the information up to the AVC.
On the one hand, this approach is nice in that it links the information
directly to the particular AVC it caused.  However, if the masked
permissions are never checked by the AVC, then we'll never get
notification of the boundary violation in the policy.  Also, this only
addresses kernel denials and would require an extension to
the /selinux/access interface to export the same information to the
userspace AVC, along with corresponding changes to the userspace AVC.

So I have to ask whether this is worth it, or if we should just add a
simple helper function to map the masked permissions to strings and call
it from the existing av boundary violation message generation?  See
sepol_av_to_string() in libsepol for example code of mapping an access
vector to string based on the policydb rather than using the kernel
definition tables (required if we do it from compute_av since they might
not be kernel permissions).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
