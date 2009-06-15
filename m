From: Steve Grubb <sgrubb@redhat.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: type bounds audit messages
Date: Mon, 15 Jun 2009 10:08:18 -0400
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
References: <1244730288.10762.120.camel@localhost.localdomain> <4A35F091.6000202@ak.jp.nec.com> <1245071835.3247.57.camel@dhcp231-142.rdu.redhat.com>
In-Reply-To: <1245071835.3247.57.camel@dhcp231-142.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200906151008.19343.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 15 June 2009 09:17:15 am Eric Paris wrote:
> On Mon, 2009-06-15 at 15:56 +0900, KaiGai Kohei wrote:
> > The attached patch allows to generate audit messages on access violations
> > related to bounds types.
> >
> > 1. When a multithread process gives an unbounded domain to setcon(3)
> >    to change its domain dynamically, the current kernel denies it
> >    without any notification or audit messages.

Oops. This should be fixed. Eventually this will go through a CC evaluation and 
it will require access violations to be audited.


> >    This patch adds an audit_log() in the security_bounded_transition()
> >    to generate an audit message, when the dynamic type transition is
> >    failed due to the bounds violation.
> >
> >    Example:
> >    type=SELINUX_ERR msg=audit(1245046106.725:65): SELinux: bounds
> > violation: \ domain transition from httpd_t to guest_webapp_t

SELINUX_ERR audit type is for SE Linux error conditions and nothing else. This 
is an access violation so it should probably be an avc or a new type.

> Everything that includes audit_log_* from now on better be of the type
> key=value.

Agreed.


> How would people on list feel about?
>
> type=SELINUX_ERR msg=audit(1245046106.725:65): lsm="SELinux" \

The type should be changed. Also, the lsm field is not required because the 
audit type is in the SE Linux block.

>     op="bounds violation on domain transition" type1="httpd_t" \
>     type2="guest_webapp_t"
>
> This would be the only place I can remember that we only output the type
> instead of the complete context.  Why not ocontext= and ncontext=?  I
> don't care what we call it, but I want it all to be key=value pairs and
> I prefer that we (the audit system) starts making much heavier use of
> audit_log_string() which includes the ""

This is required if a non-admin can influence the field contents in any way. But 
we have to have information on the subject, object, what kind of access, and 
what the decision was. We also need to identify who did it and what session 
its related to. This can be done with a syscall audit record.


> > 2. When a set of permissions are masked due to the bounds violations,
> >    it shall be reported on the type_attribute_bounds_av() invoked from
> >    context_struct_context_av(), but it keeps silent on any AVC denials.
> >    It may make unclear what permissions were in violation of the
> > boundary. This patch adds the "masked" field on av_decision, and it
> > reports violated permissions on AVC denials.
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

That last field should be something like bounds=create. There is an audit 
parsing library that makes parsing audit events very easy. It has python 
bindings, too.


> Now might be a perfect time to start emitting permissions in a better
> format though, maybe someday the rest of selinux could convert to an
> easier to parse format (ha ha, ok, I know it's funny)
>
> bounds="create"
>
> someday we might have perms="read write create open ioctl" instead of
> { ... } ???

Make that comma separated instead of space separated and I'm happy.

Thanks,
-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
