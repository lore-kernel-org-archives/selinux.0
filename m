Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6OGmFfj001064
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 12:48:15 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6OGmEqo011050
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 16:48:14 GMT
In-Reply-To: <1153755260.6122.85.camel@moss-spartans.epoch.ncsc.mil>
References: <44BFECE8.80501@us.ibm.com> <1153748747.1641.18.camel@moss-terrapins.epoch.ncsc.mil> <A5B53838-B8A8-47B0-9E4A-72A794702EBD@nall.com> <1153751437.6122.74.camel@moss-spartans.epoch.ncsc.mil> <3CA9DB29-D76C-41BE-ABE7-2F710F6658D2@nall.com> <1153755260.6122.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FA715F0C-F9E5-4F23-807A-A3F97F1402A3@nall.com>
Cc: David Quigley <dpquigl@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
From: Joe Nall <joe@nall.com>
Subject: Re: Existence of "helper" functions (specifcally MLS)
Date: Mon, 24 Jul 2006 11:48:06 -0500
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jul 24, 2006, at 10:34 AM, Stephen Smalley wrote:

> On Mon, 2006-07-24 at 10:25 -0500, Joe Nall wrote:
>>> Only the policy engine can interpret the security labels.  So you  
>>> have
>>> two choices:  ask the kernel's policy engine via selinuxfs or use
>>> libsepol on the on-disk policy file.  Advantage of the former is
>>> that a)
>>> the kernel has already parsed and loaded the policy into memory, so
>>> you
>>> avoid that cost again, and b) you ensure that you are dealing  
>>> with the
>>> same exact policy that the kernel is enforcing.
>>
>> I understand this if you include non-MLS components, but how does the
>> interpretation of the MLS component of a context vary with policy  
>> on one
>> machine?
>
> The relationship between s0 and s1 is not implicit in the names; s0
> could dominate s1; that is entirely defined by the policy itself.

I had totally missed that. I mapped the s[n] to the integers we
use on the CMW without any thought that they were arbitrary.

> Also, in general, we try to avoid MLS-specific logic outside of the
> policy engine; in many cases, applications that might historically  
> have
> done a specific MLS dominance check on a traditional trusted OS should
> instead be performing a SELinux permission check via avc_has_perm or
> security_compute_av, and then you can internally map that  
> permission to
> a MLS relationship via the mlsconstrain statements in the policy.  So
> the first question is whether this application should be performing a
> MLS label comparison at all, or whether we can abstract that to a
> service permission check.

We have an application that combines data of multiple levels and has to
compute the aggregate classification before saving it to a file or  
sharing
it with another process. Will there be a function to compute an  
aggregate
context from a list of contexts?

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
