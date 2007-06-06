Message-ID: <4666ED96.8080508@kaigai.gr.jp>
Date: Thu, 07 Jun 2007 02:23:34 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
 interface)
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com> <1180966620.14220.57.camel@moss-spartans.epoch.ncsc.mil> <4666260D.9060409@ak.jp.nec.com> <200706060745.31980.paul.moore@hp.com>
In-Reply-To: <200706060745.31980.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Tuesday 05 June 2007 11:12:13 pm KaiGai Kohei wrote:
>>>> How do you think necessity for generic fall back behavior in the case
>>>> when getpeercon() failed?
>>> I think it would be useful.  There was some discussion of it during the
>>> labeled networking discussions, but directly returning the secmark label
>>> or the netif/netmsg labels was viewed as problematic because they aren't
>>> peer/process contexts.
>> I agree the conclusion. Those labels don't represent domain's one.
>> But I think that using them an entrypoint of domain transition is
>> a considerable idea, like this:
>>   type_transition postgresql_t untrusted_network_t : packet
>>     sepgsql_client_t;
>>   type_transition ftpd_t untrusted_network_t : packet 
>>     ftpd_client_t;
> 
> There was a discussion about using packet type transitions before, although it 
> was slightly different than what you are proposing here.  The basic idea was 
> to reconcile both the "internal" and "external" packet labels into a single 
> label using type transitions.  In the end it became to complex to write sane 
> policy so the idea was dropped.
> 
> Your proposal is slightly different in that I view it more as a per-domain 
> renaming scheme where you rename/relabel packets based on the receiving 
> domain.  Can you help me understand the advantage of 
> renaming "untrusted_network_t" to "sepgsql_client_t" from a policy point of 
> view?  For example, how would these two policy rules be different or have any 
> advantage over one another:
> 
>  allow sepgsql_t untrusted_network_t:<class> <perms>;
>  allow sepgsql_t sepgsql_client_t:<class> <perms>:

Paul,

I didn't intend to rename/relabel contexts of packets. The idea uses the context
of received packet as an entrypoint of domain transition. In other word, the
server process's context is renamed/relabeled based on packet's one.

The key issues in the discussion is how to determine the context of client process
connected via unlabeled network. My idea is generating an alternative client
context based on server process's one and packet's one, using domain transition.

 > Also, if it is decided that this idea does have merit and is worth
 > implementing I see it as being complimentary, and not mutually exclusive, to
 > static labeling of unlabeled hosts/networks.

The reason why I wanted to separate fallbacked client contexts per server domain
is not to give more permissions than necessary.
For example, fallbacked context for SE-PostgreSQL need to access database with
limited permission. It does not require permissions for any other services.

 >> Is it different from Paul's idea, isn't it?
 >> > In my understanding, he intends to associate a domain's context directly
 >> > with network interfaces and/or network addresses.
 >
 > Yes, that is correct.  It is similar to how existing trusted OSs provide
 > connection/packet labels for unlabeled hosts/networks.

Is it possible to apply onto TE label, not only MLS label?

Domain transition via packet class is a bit hard to understand.
It's preferable, if we can configure the fallbacked client context
directly, as follows:
    192.168.1.0/24 --> system_u:system_r:sepgsql_client_t
    192.168.2.0/24 --> system_u:system_r:sepgsql_trusted_client_t:SystemLow-SystemHigh

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
