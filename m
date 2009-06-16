Message-ID: <4A36EAA7.5090408@ak.jp.nec.com>
Date: Tue, 16 Jun 2009 09:43:19 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        sgrubb@redhat.com, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: type bounds audit messages
References: <1244730288.10762.120.camel@localhost.localdomain>	 <4A31A33F.2040504@ak.jp.nec.com>	 <1244807594.18947.62.camel@localhost.localdomain>	 <4A35F091.6000202@ak.jp.nec.com>	 <1245071835.3247.57.camel@dhcp231-142.rdu.redhat.com> <1245074488.4078.18.camel@localhost.localdomain>
In-Reply-To: <1245074488.4078.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>>> 2. When a set of permissions are masked due to the bounds violations,
>>>    it shall be reported on the type_attribute_bounds_av() invoked from
>>>    context_struct_context_av(), but it keeps silent on any AVC denials.
>>>    It may make unclear what permissions were in violation of the boundary.
>>>    This patch adds the "masked" field on av_decision, and it reports
>>>    violated permissions on AVC denials.
>>>
>>>    Example:
>>>    type=AVC msg=audit(1245046439.315:72): avc:  denied  { create }     \
>>>      for pid=3080 comm="httpd" name="hoge"                             \
>>>      scontext=unconfined_u:system_r:user_webapp_t:s0                   \
>>>      tcontext=unconfined_u:object_r:httpd_sys_content_t:s0 tclass=file \
>>>      bounds: { create }
>>>      ^^^^^^^^^^^^^^^^^^
>> This one I'm still unhappy about but since it is continuing the
>> tradition of hard to parse audit rules I'm ok if it stays (assuming
>> tools like audit2allow don't get confused)
>>
>> Now might be a perfect time to start emitting permissions in a better
>> format though, maybe someday the rest of selinux could convert to an
>> easier to parse format (ha ha, ok, I know it's funny)
>>
>> bounds="create"
>>
>> someday we might have perms="read write create open ioctl" instead of
>> { ... } ???
>>
>> ???
> 
> This is interesting - I was expecting KaiGai to just add the masked
> permissions to the existing av boundary violation message generated
> during compute_av processing, not export the information up to the AVC.

It might be discussed where/when/what we should generate the audit message
on bounds violation prior to the patch.

I don't have any strong idea about message format, so I'll follow the
conclusion of the suggestion. :)

> On the one hand, this approach is nice in that it links the information
> directly to the particular AVC it caused.  However, if the masked
> permissions are never checked by the AVC, then we'll never get
> notification of the boundary violation in the policy.  Also, this only
> addresses kernel denials and would require an extension to
> the /selinux/access interface to export the same information to the
> userspace AVC, along with corresponding changes to the userspace AVC.

Yes, indeed, it also requires an extension on security_compute_av()
for userspaces, although we already have a derivative version :(

>From viewpoint of the architecture, who should report the masked
permissions? I reconsidered it should be a role of security server,
not AVCs.

> So I have to ask whether this is worth it, or if we should just add a
> simple helper function to map the masked permissions to strings and call
> it from the existing av boundary violation message generation?  See
> sepol_av_to_string() in libsepol for example code of mapping an access
> vector to string based on the policydb rather than using the kernel
> definition tables (required if we do it from compute_av since they might
> not be kernel permissions).

In my preference, all the masked permissions (including ones for userspaces)
should be notified on security_compute_av() time, because it is always
generated prior to actual AVC denials. It means audit log analyzer can
find the reason why AVC denials using past logs.
In addition, it is also possible to notify the reason why the permissions
were masked more than type boundary, such as RBAC, MLS, Constratins.

For example, how do you feel the example on security_compute_av() time?

type=SELINUX_INFO msg=audit(1245046106.725:65):       \
  op=security_compute_av masked=bounds                \
  scontext=system_u:system_r:user_webapp_t:s0         \
  tcontext=system_u:object_r:httpd_sys_content_t:s0   \
  tclass=file { setattr write }

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
