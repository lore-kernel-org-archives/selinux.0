Message-ID: <45AFABC8.2050101@mentalrootkit.com>
Date: Thu, 18 Jan 2007 12:18:00 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] 0/4 - Hierarchal apache policy for reference policy
References: <45AFA08F.9080602@tresys.com>
In-Reply-To: <45AFA08F.9080602@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> This is an RFC for policy allowing management delegation through 
> hierarchical types.
> 
> Policy management often is handled by different administrators, based on 
> the application or applications that are being governed. As a result, 
> providing a means to delegate access to manage only certain aspects of 
> policy is desirable, and can be accomplished using hierarchical types.
> 
> The proof of concept apache policy module illustrates policy management 
> delegation through hierarchical types. This example apache policy works 
> together with an adds metapolicy to the apache module

It's good to see progress on this and a real fleshed-out example. I look 
forward to seeing the prototype policy server.

I think the biggest hurdle to this gaining widespread use is the length 
of the meta-policy, especially since it essentially repeats the policy 
for the sub-types. Any ideas about how to shorten this policy?

The other large issue, of course, is that this demonstrates how invasive 
the policy changes are in order to support delegation. This makes it 
very difficult for a policy admin to create a separate policy module 
that a) places hierarchical restrictions on a set of types and b) 
delegates administrative privileges to an admin type to make changes to 
those types.

My guess is that for real administrative roles to become viable in 
SELinux they are going to be largely site-defined in loadable modules 
(and the work at RH along those lines is using that as a starting 
assumption). So some way to support that seems necessary. At the very 
least I think that decoupling the hierarchical restrictions from the 
identifier names is needed. This also makes hierarchy work better with 
reference policy scoping.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
