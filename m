Message-ID: <48D3F1B9.3070707@manicmethod.com>
Date: Fri, 19 Sep 2008 14:38:49 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: typebounds lookup from userspace
References: <48D3B220.1060903@manicmethod.com>	 <1221834373.25857.25.camel@moss-spartans.epoch.ncsc.mil>	 <48D3B802.1000505@manicmethod.com>	 <1221836842.25857.40.camel@moss-spartans.epoch.ncsc.mil>	 <48D3C995.4030808@manicmethod.com> <1221839645.25857.67.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1221839645.25857.67.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-09-19 at 11:47 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Fri, 2008-09-19 at 10:32 -0400, Joshua Brindle wrote:
>>>> Stephen Smalley wrote:
>>>>> On Fri, 2008-09-19 at 10:07 -0400, Joshua Brindle wrote:
>>>>>> For symbol labeling purposes for policy access control we need to be
>>>>>> able to look up symbol hierarchy relationships. I expect we'll do this
>>>>>> by exporting the symbol hierarchy via selinuxfs. Does anyone have
>>>>>> suggestions on what that should look like? Do we want to export
>>>>>> additional information on the symbols at the same time?
>>>>> I would have thought that the policy server would have its own internal
>>>>> policydb that it could consult to check hierarchy relationships?
>>>>>
>>>> We want to avoid loading more policydb's since RAM usage and
>>>> performance were issues with the expand-based access control.
>>> libsemanage already has to load the policydb into memory for its
>>> transactions.  Will this change in the future?  If not, then it seems
>>> that you could simply leverage that.
>>>
>> True, though that is currently only done when not building a policy.
> 
> What?  It constructs a policydb in memory when building a policy and
> then writes it out.  There is always an in-memory policydb, whether it
> is just loaded from the existing policy file (via Dan's enhancement) or
> generated via expand/link + merge local components.
> 
>>  For access control we will be building a policy but hope to do access
>> control far before that happens (thus saving time if it is going to
>> fail anyway). The rebuild code path doesn't currently open the old
>> policy so adding that would double the ram usage.
> 
> Ok.
> 
>>> I know that at one point the trend was toward one value per file, but
>>> that carries a cost of course, and I'm not sure the /selinux/class
>>> interface turned out to be ideal.  Maybe others have opinions.
>>>
>> was there anything specific about the class interface you didn't like?
>> I like it in the sense that once the tree is built the policydb never
>> has to be consulted. I don't think that is an option for this case
>> though.
>>
>> I like one value per file but we are talking about a large namespace for types.
> 
> Yes, I'm a little concerned about eating up kernel memory for all of
> those pseudo inodes, most of which will never be used by userspace.
> 

Ok, after thinking about this we really need the entire picture as far as typebounds goes in order to do access control because the modules being added and removed may also have typebounds that we need to incorporate into the labeling process, so that a user can declare a type and bound it to another type. 

So the options are keep a typebounds cache in the libsemanage store or have a node in selinuxfs that exports all the typebounds at once. Do you have a preference of which way to do it?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
