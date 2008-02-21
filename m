Subject: Re: [RFS] Application changing remote policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shahbaz khan <shazalive@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7b740b700802210400k7251155at88cf77e761cb6248@mail.gmail.com>
References: <7b740b700802210400k7251155at88cf77e761cb6248@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 21 Feb 2008 08:38:48 -0500
Message-Id: <1203601128.9902.252.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-21 at 17:00 +0500, shahbaz khan wrote:
> I am working on an application that needs access to a remote selinux
> system and this application would like to change the policy for itself
> so that it can use some resources. Definitely it has to be trusted! I
> know its weird but in case it has to then what should basically be the
> sensible thing to do? Is there a possibility that my application can
> pick the policy that is relevant to itself from the remote selinux so
> that it can try to modify it? If the policy is not available in text
> form (monolithic/base or LPM) then what can be the possibilities?
> Something from the selinuxfs or maybe some tweaking module needed to
> handle the AVC. If anyone thinks I am stupid (especially Mr. Smalley)
> then I already know this ;-)

Can you clarify the real requirements?

If the application is truly trusted to change its own policy at will,
then it is effectively unconfined - so what is the purpose of not just
running it unconfined_t?  Just to reduce the likelihood of it
unintentionally exercising a permission?

What kinds of policy changes does it want to apply?  If they can be
expressed as conditional policy, then you can just write the policy once
and have the application or some other process just change booeans
rather than having to rewrite policy.

And in order to achieve any access control over changes to policy other
than boolean changes, you need to be using the policy management server.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
