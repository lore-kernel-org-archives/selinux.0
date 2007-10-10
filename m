Subject: Re: Are the reference policy abstractions the right ones?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 11:09:59 -0400
Message-Id: <1192028999.2898.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-09 at 11:08 -0400, James Carter wrote:
> I would like to start a discussion on whether reference policy is
> providing the right abstractions for writing policy.
> 
> This is not intended to be an attack on Chris or Dan, or their work.  I
> think that it is obvious that reference policy is much better organized,
> far more useful, and works way better than the old example policy.  We
> don't want to go back to example policy.
> 
> One of the goals of reference policy is to provide a more modern feel to
> the policy by eliminating the use of types in a global manner across the
> whole policy.  It does this by allowing interfaces to be defined through
> which permissions can be granted to the types of a module.  There seems
> to be several problems with this.
> 

Let me ask a different question. Both the old example policy and the
reference policy accomplish the same basic thing: comprehensive
least-privilege. The challenge with this approach is that the policy is
closely tied to applications and brittle in the face of application
changes.

So - are there other useful approaches that we could take? Some modified
form of integrity policies like BIBA? Perhaps just for portions of the
policy - things like hal/udev that are basically in the TCB but need to
be protected from applications.

Seems like a long-shot, but I thought I would ask.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
