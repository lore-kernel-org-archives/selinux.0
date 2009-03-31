Subject: Re: [PATCH] Permissive domain in userspace (Re: Some ideas in
 SE-PostgreSQL enhancement)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, method@manicmethod.com,
        jmorris@namei.org, selinux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <49D175C6.2050001@ak.jp.nec.com>
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com>
	 <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>
	 <49CB3CEB.1070505@ak.jp.nec.com> <49CD8E68.9090004@tycho.nsa.gov>
	 <49D034B9.9080406@ak.jp.nec.com>  <49D175C6.2050001@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 31 Mar 2009 12:46:33 -0400
Message-Id: <1238517993.2484.123.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-03-31 at 10:45 +0900, KaiGai Kohei wrote:
> KaiGai Kohei wrote:
> > If we have an entry something like "/selinux/permissive" to return
> > whether the given domain is permissive or not, I think we don't need
> > to have the flags field on security_compute_av(). It can be checked
> > on the creation of userspace avc entry, and checked it on later access
> > controls.
> 
> The attached patch exposes a new entry in selinuxfs, which enables
> userspace stuff to make a query whether the given context is permissive
> domain, or not.
> If the given context is permissive domain, userspace stuffs can mark
> its entry as a permissive one on creation of avc entries, to avoid
> policy enforcement on permissive domains.
> 
> It now checks security:{check_context} permission, but it should be
> discussed what permission to be checked here.
> 
> The attached check_permissive.c is an example to use the interface.
> 
>   [kaigai@saba ~]$ ./check_permissive staff_u:staff_r:staff_t:s0
>   staff_u:staff_r:staff_t:s0 is a permissive domain
>   [kaigai@saba ~]$ ./check_permissive user_u:user_r:user_t:s0
>   user_u:user_r:user_t:s0 is NOT a permissive domain
> 
> Thanks,

I actually preferred your earlier patch - making the permissive
determination as part of the compute_av.  I'd suggest posting your
earlier kernel patch as a separate posting with the patch inline,
following the usual guidelines, and make sure you cc James and Eric.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
