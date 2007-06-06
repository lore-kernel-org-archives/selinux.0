Message-ID: <4666260D.9060409@ak.jp.nec.com>
Date: Wed, 06 Jun 2007 12:12:13 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, paul.moore@hp.com
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
 interface)
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com>	 <1180631739.3340.309.camel@moss-spartans.epoch.ncsc.mil>	 <4661ACEF.3000801@kaigai.gr.jp> <1180966620.14220.57.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1180966620.14220.57.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> How do you think necessity for generic fall back behavior in the case when
>> getpeercon() failed?
> 
> I think it would be useful.  There was some discussion of it during the
> labeled networking discussions, but directly returning the secmark label
> or the netif/netmsg labels was viewed as problematic because they aren't
> peer/process contexts.

I agree the conclusion. Those labels don't represent domain's one.
But I think that using them an entrypoint of domain transition is
a considerable idea, like this:
  type_transition postgresql_t untrusted_network_t : packet sepgsql_client_t;
  type_transition ftpd_t untrusted_network_t : packet ftpd_client_t;

Is it different from Paul's idea, isn't it?
In my understanding, he intends to associate a domain's context directly with
network interfaces and/or network addresses.

If corrent, I have a question.
Is it possible to distinguish the fallback context for each server domain?
For example, when we want to label clients connected from unlabeled network
as 'sepgsql_unlabeled_client_t', how does the other server handle them?

>> The current version of SE-PostgreSQL adopts the simplest way to handle
>> a connection from a client without any network labeling. Its connection
>> will be closed soon.
> 
> X has a more graceful fallback, per Eamon - it defines a
> nonlocal_context in its own config and uses that as the default if
> getpeercon fails.

It is possible to implement similar fallbacks in SE-PostgreSQL, of course.
But we should obtain fallback context sourced from security policy, if possible.

>> How is it implemented and described in the policy?
>>  - Is it possible to use the security context of netif/address/port of inbound
>>    connection as an entrypoint of domain transition?
>>    Those may be configurable with SECMARK.
> 
> You can already define a netif (and a netmsg) context in policy and
> manipulate them via semanage_iface(3) in userland.  We don't presently
> have a way to convey the netif or netmsg context (or secmark label) to
> userland from the kernel.  There was some discussion of a separate
> getdatacon(3) and equivalent for SCM_SECURITY to convey a "data context"
> separate from the "peer context", but that doesn't exist yet and would
> take some work in the kernel.

I believe that secmark label is the easiest to manage.
If we need the facility, I'll post a patch. :)

At first, I like to see the detail of Paul's idea.

Thanks,

> It wouldn't be difficult to modify libselinux getpeercon(3) and/or
> introduce a new higher level interface in libselinux that queries policy
> in some manner and obtains a default if the underlying kernel interface
> cannot provide a context.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
