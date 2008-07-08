Message-ID: <48738471.50701@manicmethod.com>
Date: Tue, 08 Jul 2008 11:14:57 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Christian Kuester <c.kuester@tarent.de>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: Adding local nodecon's through semanage
References: <486CD88E.2000406@tarent.de> <1215450682.27975.108.camel@moss-spartans.epoch.ncsc.mil> <48733DCF.3000808@tarent.de>
In-Reply-To: <48733DCF.3000808@tarent.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christian Kuester wrote:
> Stephen Smalley schrieb:
>>> [ netmask semantic in nodecon ]
>> Ok, this isn't actually a bug in the code at all.
> 
> I see. Thanks for clearing that up for me!
> 
>> Arguably semanage and checkpolicy should apply the mask to the address
>> as a precaution against misconfiguration by the user.  That's easy
>> enough to do.
>>
>> Other tidbits on the semanage patch that I noticed:
>> - semanage node -l was broken, requires additional argument that has
>> been added to the list methods subsequently.  Also would be nice to
>> support locallist/-C option.
>> - semanage node -p option should take a string rather than an integer
>> and map it to the proper symbolic constant for ipv4/ipv6.
>> The ordering issue is a red herring at least for this example as the
>> sort is only applied to the local entries, and then they are merged to
>> the front of the policy-provided definitions.  Which may become an issue
>> down the road particularly if we move object contexts to modules. 
> 
> I think I could do the changes to at least the semanage code, if there
> is still interest in it.
> 
> But I must admit, that my understanding of the "ordering issue" is quiet
> limited and my list research on an explaination was unsuccessful so far.
> Is this a blocker for general semanage support of nodecons?
> 

The ordering issue only comes up when you have overlapping masks. This may not be an issue in practice though, I suppose we'll see.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
