Message-ID: <526FB2C0.4010506@tycho.nsa.gov>
Date: Tue, 29 Oct 2013 09:06:08 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: eparis@redhat.com, selinux@tycho.nsa.gov,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH 09/17] Have sepolgen return additional constraint information
References: <526EC096.109@redhat.com>
In-Reply-To: <526EC096.109@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/28/2013 03:52 PM, Daniel J Walsh wrote:
> This patch allows sepolgen to also display the constraint information.
>    This patch looks good to me. acked.

Patches 1-3 applied on master.
Patches 4-9 applied on a separate constraintnames branch for further
review/testing and to await the updated kernel patch.

I suspect we'll need to go ahead and add the module version anyway just
to avoid breaking compatibility?  Not optimal but I don't think we want
upstream SELinux userspace build to break a Fedora 19/20 box, or to
reuse the version number down the road for something completely
different.  Unless you are going to push an update to 19 and 20 that
will downgrade all modules to the prior version (what could possibly go
wrong?).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
