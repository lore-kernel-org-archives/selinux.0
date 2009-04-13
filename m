Message-ID: <49E3227F.1010805@redhat.com>
Date: Mon, 13 Apr 2009 07:31:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Alexey S." <selinux@udmvt.ru>
CC: Joe Nall <joe@nall.com>, jwcart2@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Policy infrastructure problems and improvement
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil> <49DEC8D0.2060105@schaufler-ca.com> <1239366882.27413.24.camel@moss-lions.epoch.ncsc.mil> <E92B8263-9FF8-4AD8-83C9-97113864D8E2@nall.com> <20090413072810.GQ9889@ruber.office.udmvt.ru>
In-Reply-To: <20090413072810.GQ9889@ruber.office.udmvt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/13/2009 03:28 AM, Alexey S. wrote:
> On Fri, Apr 10, 2009 at 09:51:46AM -0500, Joe Nall wrote:
>> On Apr 10, 2009, at 7:34 AM, James Carter wrote:
>>
>>> On Thu, 2009-04-09 at 21:19 -0700, Casey Schaufler wrote:
>>>
>>> That's easy to fix.  Make the system smaller. ;)
>>>
>>> I think that this would fit under complexity of SElinux policies.
>>>
>>> Again, better layering is needed.  It would be nice if I could just
>>> write policy for the particular domains and resources that I cared
>>> about
>>> without having to worry about the policy for the rest of the system.
>>> Unfortunately, policy writing differs from program writing in that
>>> while
>>> different programs that run on a system *share* resources and so it
>>> doesn't matter what the other programs do (for the most part) as long
>>> as
>>> my program gets to use those resources at some point, all of the
>>> policies work together to *control* resources.  In the end, you must
>>> have one policy.  The question is how to write the policies in a more
>>> layered way and have the policy infrastructure merge the layers
>>> together.
>> audit2allow needs to understand your layers of abstraction or they won't
>> be very useful. I've watched a number of developers in our group stall at
>> the audit2allow policy writing level and never really get the need to
>> understand the system macros and the 'why' of it all.
>>
>> Some of these same developers never get that some avcs are inevitable
>> and blithely grant privilege until they don't have any avcs - granting
>> user_t enormous new privs along the way. We use seinfo to look for
>> attribute diffs and source inspection, but we need better command line
>> tools to look for these issues in an automated way.
>
> Me as policy developer will benefit a lot if there will be a tool, that
> maps m4 macros to allows/denials and allows/denials back to m4 macros.
> The only thing that is available to me now is 'grep -r', but it does not help
> always.
> I would like a system, that will answer my questions like:
>   'What macros can be used to generate these "allows"?' (sorted by the level of invocation)
>   'What macro generate this denies and where it is invoked from?' (sorted the same way)
>   'How the permissions of the domain will be affected if I add/throw out this macro?' (in current context)
> Well, there is some tool, that does that. It is called human memory and experience.
> But sometimes that fails. And it takes a lot of time to (re)gather that experience.
>
> PS: Maybe have I missed something again? That tools will be so much useful.
>
sepolgen is supposed to do this, but it needs some tender loving care.

audit2allow -R

> --
> Alexey S.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
