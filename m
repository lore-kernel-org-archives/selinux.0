From: Paul Moore <paul.moore@hp.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: Are the reference policy abstractions the right ones?
Date: Wed, 10 Oct 2007 14:26:08 -0400
Cc: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>,
        Steve Smalley <sds@epoch.ncsc.mil>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil> <1192028999.2898.19.camel@localhost.localdomain>
In-Reply-To: <1192028999.2898.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710101426.08308.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 10 October 2007 11:09:59 am Karl MacMillan wrote:
> Let me ask a different question. Both the old example policy and the
> reference policy accomplish the same basic thing: comprehensive
> least-privilege. The challenge with this approach is that the policy is
> closely tied to applications and brittle in the face of application
> changes.
>
> So - are there other useful approaches that we could take? Some modified
> form of integrity policies like BIBA? Perhaps just for portions of the
> policy - things like hal/udev that are basically in the TCB but need to
> be protected from applications.
>
> Seems like a long-shot, but I thought I would ask.

I definitely think it's a valid question, and one that I think is worth 
pondering for a little bit.  One of the greatest strengths of SELinux, in my 
opinion, is it's decoupling of policy from enforcement.  We have the ability 
to offer many different types of policies yet we continue to focus on one 
common policy source.  While the reference policy does provide the ability to 
provide different variations, they are still rooted in the idea 
of "comprehensive least-privilege".  

The reference policy is a huge improvement over the old example policy, but 
I'm not convinced that it is the "everything to everyone" policy.  I think 
adopting the founding concepts of the reference policy (modularity, 
abstractions, etc.) and using these concept to start looking at alternative 
approaches to SELinux policy (in parallel to refpolicy) as Karl suggested 
would be a worthwhile exercise.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
