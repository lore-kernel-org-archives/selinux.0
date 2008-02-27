Message-ID: <47C5F3AA.7020809@manicmethod.com>
Date: Wed, 27 Feb 2008 18:35:06 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Speaking of networking...
References: <Xine.LNX.4.64.0802280057060.14155@us.intercode.com.au> <1204135320.31790.26.camel@moss-spartans.epoch.ncsc.mil> <Xine.LNX.4.64.0802280910390.19162@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0802280910390.19162@us.intercode.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Wed, 27 Feb 2008, Stephen Smalley wrote:
>
>   
>> On Thu, 2008-02-28 at 01:01 +1100, James Morris wrote:
>>     
>>> Any further thoughts on how to push the secmark integration forward?
>>>
>>> The secmark table patch should allow MAC rules to be administered 
>>> independently, and I know there has been some demand for the new (well, 
>>> now not so new) networking controls.
>>>       
>> Has the secmark table patch gone upstream yet?
>>     
>
> Nope.  I think we need to know that it's going to be useful first.
>   

Thats something of a chicken/egg problem. We need a separate table so 
that we can peacefully co-exist with user rules before we can deploy it 
widely (eg., to fedora users) to determine the viability of policy 
driven secmark labeling.

On a related note CLIP has a rebuilt iptables that they should be 
including in their next release because users of CLIP are very 
interested in secmark labeling as well. This obviously will be in the 
mangle table since they are using a RHEL5 kernel but it will still be 
available.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
