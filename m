Message-ID: <4A92AFB9.6070004@manicmethod.com>
Date: Mon, 24 Aug 2009 11:20:25 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>
Subject: Re: object context records for Xen
References: <1250865733.2390.85.camel@moss-pluto.epoch.ncsc.mil>	 <4A92A981.8000608@manicmethod.com>  <4A92AC4D.7080503@manicmethod.com> <1251127167.2428.44.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1251127167.2428.44.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2009-08-24 at 11:05 -0400, Joshua Brindle wrote:
>> Joshua Brindle wrote:
>>> Stephen Smalley wrote:
<snip>>>>
>> Also, is it an error condition if there are ocon's unrelated to the target
>> platform? Is it possible to create a general policy that may work on multiple
>> platforms and therefore have a superset of the ocons for each possible platform?
>
> I would plan to have checkpolicy reject invalid ocons for the specified
> target platform, much as it rejects mls statements (or requires them)
> depending on the MLS flag.
>

In retrospect I'm not sure it was a great idea to make it reject mls statements 
rather than just ignoring them :).

> There really isn't any sharing possible between the Xen policy and the
> Linux policy, given the significantly different resources and operations
> (thus classes and permissions), so I don't think it would be useful to
> support a unified policy.
>
> In the case of Linux, Solaris, and FreeBSD, it isn't clear that they
> actually need distinct ocontext records since they do happen to share
> the same Unix abstractions for the most part.
>

So even if they had same/similar policies they'd have to be rebuilt with a new 
--target? Would each have ocon sets that just happen to be the same?

The massive amount of branching in the current reader/writer is fairly 
discouraging, I hope we can do this in a flexible but straightforward way.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
