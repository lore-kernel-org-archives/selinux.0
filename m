Message-ID: <4661ACEF.3000801@kaigai.gr.jp>
Date: Sun, 03 Jun 2007 02:46:23 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov, KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com> <1180631739.3340.309.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1180631739.3340.309.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-05-31 at 10:58 -0500, Joe Nall wrote:
>> I would like to label an ethernet interface so that all of the  
>> inbound connections are labeled with a range.
>>
>> semanage interface -a -t netif_t --range S-S eth1
>>
>> succeeds, but getpeercon fails with "Protocol not available"
>>
>> Is there any way to do this with what is in evaluation?
> 
> getpeercon() only returns a context if a labeled networking mechanism
> was used; we don't implicitly convey the netif label or secmark label to
> it.  So if you want a default labeling behavior, that has to be done in
> your application, e.g. the application would fall back to some default
> if getpeercon() failed.

Stephen,

How do you think necessity for generic fall back behavior in the case when
getpeercon() failed?

I think such a falling-back labeling behavior is worthwhile for appliablity
of SE-PostgreSQL, because RDBMS will be connected from MS-Windows'ed clients
which are impossible to set up network labeling, for example.

The current version of SE-PostgreSQL adopts the simplest way to handle
a connection from a client without any network labeling. Its connection
will be closed soon.

I got a question and a suggestion about SE-PostgreSQL's behavior in those cases
just after my speech in this year's SELinux Symposium.
He suggested me that it is possible to associate a security context and network
interfaces or network address/port.
For example, RDBMS server has two NIC. One is connected to internal network and
connections from there are defined as SystemLow-SystemHigh, the other is connected
to external network and defined as SystemLow, like the following image.

SystemLow-SystemHigh +--------+      SystemLow
            --> eth0 |SE-PgSQL| eth1 <---
---------------------= server =---------------
            INTERNAL +--------+ EXTERNAL

I think his suggestion is fair enough as a fall back of getpeercon(),
but we don't have any consensus.

Is it really necessary?
 - At least, I think the facility is worthwhile.

How is it implemented and described in the policy?
 - Is it possible to use the security context of netif/address/port of inbound
   connection as an entrypoint of domain transition?
   Those may be configurable with SECMARK.

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
