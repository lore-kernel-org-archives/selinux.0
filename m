Subject: Re: [RFC][PATCH] selinux:  dynamic class/perm discovery
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <4ABB30CD.9060804@ak.jp.nec.com>
References: <1253739220.2870.3.camel@moss-huskers.epoch.ncsc.mil>
	 <4ABB30CD.9060804@ak.jp.nec.com>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 10:54:10 -0400
Message-Id: <1254149650.14478.31.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-09-24 at 17:41 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:
> > This needs more testing, but I thought I would circulate it for review.
> > 
> > Modify SELinux to dynamically discover class and permission values
> > upon policy load, based on the dynamic object class/perm discovery
> > logic from libselinux.  A mapping is created between kernel-private
> > class and permission indices used outside the security server and the
> > policy values used within the security server.
> 
> I'm grad to see this patch. I've been unable to pay my efforts for
> a few weeks due to the PostgreSQL works, although I mentioned this
> feature before. Thanks.
> 
> Some of random comments are bellow.
> 
> * It is confusable to use "tclass" always.
> When we get this patch, we need to handle the value stored within
> tclass carefully to distinguish whether it means the internal-code
> defined in the flask.h or the external-code defined in the current
> security policy.
> 
> In my opinion, we should not use the value of tclass to store the
> external-code, to avoid future possible confusion. For example,
> context_struct_compute_av() requires "tclass", but it implicitly
> assumes the external-code will be given.
> Is it possible to rename all the "tclass" which stores the external
> -code into "tclass_ex" instead?

context_struct_compute_av() only deals with the policy values.
security_compute_av() unmaps the kernel-private index value on entry and
maps the resulting decision on exit.  The functions that may require
mapping use orig_tclass vs tclass to distinguish them.

> * Audit denied messages due to the undefined permissions?
> When the loaded security policy does not have a definition of kernel
> object classes and its allow_unknown is false, the required kernel
> permission can be denied.
> In this case, context_struct_compute_av() initializes avd->allowed
> by 0UL and avd->auditdeny by 0xffffffffUL. Then, map_decision() drops
> bits from avd->auditdeny due to the undefined object class/access vector.
> This av_decision is inserted into the kernel AVC, then it will be refered
> at the avc_dump_av(). Finally, this policy will silently prevent kernel
> permissions being not defined in the security policy.
> What is the preferable behavior in this situation?

I've modified the logic to also add undefined permissions to the
auditdeny vector if !allow_unknown, so we should get audit messages for
their denials in that case.

> * What is the reason why "classmap.h", instead of "classmap.c"?
> The avc.c includes the classmap.h which defines secclass_map array.
> But it seems to me more straightforward manner to add classmap.c
> which provide only secclass_map[] array definition.

Needs to be included by mdp.c and genheaders.c as well.

> 
> * May be a short-tempered requirement.
> 
> It will be preferable, if userspace object manager can make a query
> using object class and access vectors with text representation, not
> the results of string_to_security_class(), because userspaces cannot
> make sure the string_to_security_class() and security_compute_av()
> are handled atomically.
> 
> The security policy may be reloaded between the string_to_security_class()
> and security_compute_av() in a corner case.
> BTW, SE-PostgreSQL checks sequencial number of security policy, and redo
> checks if the security policy reloaded. But it is not perfect. The netlink
> socket message can be delayed. :-(
>   http://code.google.com/p/sepgsql/source/browse/branches/pgsql-8.4.x/sepgsql/src/backend/security/sepgsql/avc.c#565
> 
> If the text -> code translation and lookups of security policy can be done
> within a single read_lock(&policy_rwlock) block, we can guarantee
> security_compute_av() is not invoked based on incorrect object class code.

We could either add a new node to selinuxfs that takes the string
representation, or just modify the existing handler functions to
automatically detect whether they were passed an integer or a string and
act accordingly.  But I'd view that as a separate follow-on patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
