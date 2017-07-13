Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6D0RYs1011199
 for <selinux@tycho.nsa.gov>; Wed, 12 Jul 2017 20:27:35 -0400
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <20170710202553.20668-1-sds@tycho.nsa.gov>
 <CAHC9VhQ_uQid=iqetWk3mpehn82sts9NW6oeZzFk0Fq3Td7xFA@mail.gmail.com>
 <1499866012.23108.3.camel@tycho.nsa.gov>
 <CAHC9VhTYY-3po8KzYCAKqYX-t2EkMo548dOu2ufe3MODQ=V3QA@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <7596a965-4283-94ae-eb34-796e5979f288@ieee.org>
Date: Wed, 12 Jul 2017 20:27:27 -0400
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTYY-3po8KzYCAKqYX-t2EkMo548dOu2ufe3MODQ=V3QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/12/2017 05:38 PM, Paul Moore wrote:
> On Wed, Jul 12, 2017 at 9:26 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Tue, 2017-07-11 at 17:00 -0400, Paul Moore wrote:
>>> On Mon, Jul 10, 2017 at 4:25 PM, Stephen Smalley <sds@tycho.nsa.gov>
>>> wrote:

> While I think splitting the NNP/nosuid transition restrictions might
> be a good idea under the new policy capability, I'm not sure it is
> worth the cost of a "process2" object class.
>
> With that in mind, let's do two things with this patch:
>
> * Mention the nosuid restrictions in the patch description.  It
> doesn't need much text, but something would be good so we have
> documentation in the git log.
>
> * Let's pick a new permission name that is not specific to NNP or
> nosuid.  IMHO, nnpnosuid_transition is ... less than good.
> Unfortunately, I'm not sure I'm much better at picking names; how
> about "protected_transition"?  "restricted_transition"?
> "enable_transition"?  "override_transition"?

I vote for nnp_transition anyway.  "No New Privileges" encompasses 
nosuid in my mind.  If the two perms had been separated I would have 
been inclined to allow both every time one of them was needed, to make 
sure no one was surprised by the behavior difference.


-- 
Chris PeBenito
