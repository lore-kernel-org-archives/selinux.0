Message-ID: <52715741.4060405@tresys.com>
Date: Wed, 30 Oct 2013 15:00:17 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-NSA <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Joshua Brindle <brindle@quarksecurity.com>
Subject: Re: Pruning dead/obsolete branches?
References: <5271566F.4070207@tycho.nsa.gov>
In-Reply-To: <5271566F.4070207@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/30/2013 02:56 PM, Stephen Smalley wrote:
> Hi,
>
> There are a number of old branches in the selinux repo that I think can
> be safely pruned, but I wanted to confirm first.
>
> The branches other than master are:
> - autotools:  last attempt to convert over to using autotools.  Last
> commit 2008.
>
> - integration: last attempt to integrate src-policy into master?  Last
> commit 2011.
>
> - queue:  Eric's branch for changes queued for merging to master, kind
> of a next branch.  Last commit Feb 2013.
>
> - src-policy:  source policy module work.  Last commit 2010.
>
> - src-revert:  Not really sure.  Last commit 2011.
>
> - stable_1_0:  attempt to provide a long term stable series tracking the
> 1.x versions of selinux userspace for long term distro users.  Last
> commit 2008.  Turned out to be pointless because the long term distros
> did their own backporting and maintenance.
>
> Any reason to retain any of these branches at this point?
>
>
>

src-revert, src-policy, and integration are all related to CIL with the 
eventual goal of getting it upstreamed. There is ongoing work with these 
branches, just not yet committed, so we should at least keep these around.

- Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
