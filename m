Message-ID: <45AFB433.1010309@tresys.com>
Date: Thu, 18 Jan 2007 12:53:55 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] 0/4 - Hierarchal apache policy for reference policy
References: <45AFA08F.9080602@tresys.com> <45AFABC8.2050101@mentalrootkit.com>
In-Reply-To: <45AFABC8.2050101@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Joshua Brindle wrote:
>> This is an RFC for policy allowing management delegation through 
>> hierarchical types.
>>
>> Policy management often is handled by different administrators, based 
>> on the application or applications that are being governed. As a 
>> result, providing a means to delegate access to manage only certain 
>> aspects of policy is desirable, and can be accomplished using 
>> hierarchical types.
>>
>> The proof of concept apache policy module illustrates policy 
>> management delegation through hierarchical types. This example apache 
>> policy works together with an adds metapolicy to the apache module
> 
> It's good to see progress on this and a real fleshed-out example. I look 
> forward to seeing the prototype policy server.
> 
> I think the biggest hurdle to this gaining widespread use is the length 
> of the meta-policy, especially since it essentially repeats the policy 
> for the sub-types. Any ideas about how to shorten this policy?
> 

nit: the meta-policy is short (5 lines). The policy itself is longer due 
to the propagation of rules to children types.

> The other large issue, of course, is that this demonstrates how invasive 
> the policy changes are in order to support delegation. This makes it 
> very difficult for a policy admin to create a separate policy module 
> that a) places hierarchical restrictions on a set of types and b) 
> delegates administrative privileges to an admin type to make changes to 
> those types.
> 

I'm not sure how desirable ad-hoc delegation is. Just like normal policy 
meta policy needs to be well thought out in order to meet specific 
security goals (and do so without allowing bypass, etc).

> My guess is that for real administrative roles to become viable in 
> SELinux they are going to be largely site-defined in loadable modules 
> (and the work at RH along those lines is using that as a starting 
> assumption). So some way to support that seems necessary. At the very 
> least I think that decoupling the hierarchical restrictions from the 
> identifier names is needed. This also makes hierarchy work better with 
> reference policy scoping.
> 

I don't know if I believe this, all of our experience with making 
administrative roles is that it is difficult, we know, for example, that 
the secadm and sysadm roles are hardly separate and there are trivial 
bypasses that the sysadm role can use to gain secadm type access.

Decoupling the hierarchy from the identifier seems like it would make 
understanding the hierarchy and the resulting metapolicy very difficult.

I'm open to debate though, that is the purpose of sending this up at 
this time.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
