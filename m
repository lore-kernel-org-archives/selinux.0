Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
	interface)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov, KaiGai Kohei <kaigai@ak.jp.nec.com>
In-Reply-To: <4661ACEF.3000801@kaigai.gr.jp>
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com>
	 <1180631739.3340.309.camel@moss-spartans.epoch.ncsc.mil>
	 <4661ACEF.3000801@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 10:17:00 -0400
Message-Id: <1180966620.14220.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-06-03 at 02:46 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-05-31 at 10:58 -0500, Joe Nall wrote:
> >> I would like to label an ethernet interface so that all of the  
> >> inbound connections are labeled with a range.
> >>
> >> semanage interface -a -t netif_t --range S-S eth1
> >>
> >> succeeds, but getpeercon fails with "Protocol not available"
> >>
> >> Is there any way to do this with what is in evaluation?
> > 
> > getpeercon() only returns a context if a labeled networking mechanism
> > was used; we don't implicitly convey the netif label or secmark label to
> > it.  So if you want a default labeling behavior, that has to be done in
> > your application, e.g. the application would fall back to some default
> > if getpeercon() failed.
> 
> Stephen,
> 
> How do you think necessity for generic fall back behavior in the case when
> getpeercon() failed?

I think it would be useful.  There was some discussion of it during the
labeled networking discussions, but directly returning the secmark label
or the netif/netmsg labels was viewed as problematic because they aren't
peer/process contexts.

> I think such a falling-back labeling behavior is worthwhile for appliablity
> of SE-PostgreSQL, because RDBMS will be connected from MS-Windows'ed clients
> which are impossible to set up network labeling, for example.
> 
> The current version of SE-PostgreSQL adopts the simplest way to handle
> a connection from a client without any network labeling. Its connection
> will be closed soon.

X has a more graceful fallback, per Eamon - it defines a
nonlocal_context in its own config and uses that as the default if
getpeercon fails.

> I got a question and a suggestion about SE-PostgreSQL's behavior in those cases
> just after my speech in this year's SELinux Symposium.
> He suggested me that it is possible to associate a security context and network
> interfaces or network address/port.
> For example, RDBMS server has two NIC. One is connected to internal network and
> connections from there are defined as SystemLow-SystemHigh, the other is connected
> to external network and defined as SystemLow, like the following image.
> 
> SystemLow-SystemHigh +--------+      SystemLow
>             --> eth0 |SE-PgSQL| eth1 <---
> ---------------------= server =---------------
>             INTERNAL +--------+ EXTERNAL
> 
> I think his suggestion is fair enough as a fall back of getpeercon(),
> but we don't have any consensus.
> 
> Is it really necessary?
>  - At least, I think the facility is worthwhile.

Yes, I think it would be worthwhile.

> How is it implemented and described in the policy?
>  - Is it possible to use the security context of netif/address/port of inbound
>    connection as an entrypoint of domain transition?
>    Those may be configurable with SECMARK.

You can already define a netif (and a netmsg) context in policy and
manipulate them via semanage_iface(3) in userland.  We don't presently
have a way to convey the netif or netmsg context (or secmark label) to
userland from the kernel.  There was some discussion of a separate
getdatacon(3) and equivalent for SCM_SECURITY to convey a "data context"
separate from the "peer context", but that doesn't exist yet and would
take some work in the kernel.

It wouldn't be difficult to modify libselinux getpeercon(3) and/or
introduce a new higher level interface in libselinux that queries policy
in some manner and obtains a default if the underlying kernel interface
cannot provide a context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
