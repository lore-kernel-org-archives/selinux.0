Date: Thu, 9 Aug 2007 07:24:53 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Darrel Goeddel <DGoeddel@TrustedCS.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
In-Reply-To: <46BB200A.1080904@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0708090717580.16824@us.intercode.com.au>
References: <46BB200A.1080904@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Aug 2007, Darrel Goeddel wrote:

> Because of the position I am in (needing to find something workable for
> actual
> users), I have been trying to get my head aounrd the state of SELinux
> networking,
> the ideas that have been talked about in the past, and how we can prevent
> the
> SELinux networking infrastructure from resembling a Rube-Goldberg machine.
> I'll
> be presenting some of the problems I perceive along with some very high
> level
> ideas early next week.

I think the problem we have faced in this area here is not enough focus on 
general usability, and how to make this stuff useful beyond "lspp" 
customers.  It is essential for SELinux to succeed that it is generally 
useful, and capable of addressing general security requirements, otherwise 
we _effectively_ end up with a Trusted Solaris style fork, where you have 
this odd code in the corner that most people don't and won't use.

The proposal outlined in my last email is:

- Retain existing secmark facilities, allowing them to be used as a way to 
provide default/fallback labeling

- Allow external labeling (IPsec, CIPSO) to override the secmark labels

This gives us loopback labeling, the ability to retain the general 
usability of only local iptables-based labeling, and a very simple 
mechanism for integrating external labeling.

Does this address all of your requirements ?

If not, please explain what's missing.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
