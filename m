Date: Mon, 28 Jan 2002 09:43:53 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Thomas A Langan <tlangan@dsl.cis.upenn.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Policy Enforcement Question
In-Reply-To: <Pine.GSO.4.33.0201272204020.3875-100000@codex.cis.upenn.edu>
Message-ID: <Pine.GSO.4.33.0201280914250.24971-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 27 Jan 2002, Thomas A Langan wrote:

> I have a quick conceptual question about the role policies in the Flask
> architecture.
>
> When policies are defined by an admin --- using RBAC, TE or a
> combination thereof --  and parsed into the system, does rights-checking
> at the lowest level occur seperately for each policy defined (and in turn,
> seperately for each language such as RBAC or TE) or do all the policies
> compile down to an intermediate format that handles all of the languages
> and policies transparently?  If the latter, what is the intermediate
> representation?

>From the perspective of the object managers, the "intermediate
representation" is an access vector for a given SID pair and security
class.  The object managers have no knowledge of the inner workings of the
policy or even that there are multiple policies.  The Flask architecture
specifies the interfaces to the security server, not its implementation.

>From the perspective of the example security server, each policy has
some core logic that is driven by the corresponding configuration, and an
access vector computation involves combining the results of a computation
by each policy.  Most of the policy is expressed through the TE
configuration.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
