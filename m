Date: Mon, 27 Sep 2010 10:50:34 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        netfilter-devel@vger.kernel.org, sds@tycho.nsa.gov, jengelh@medozas.de,
        paul.moore@hp.com, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org, netfilter@vger.kernel.org,
        mr.dash.four@googlemail.com
Subject: Re: [PATCH 3/6] secmark: export binary yes/no rather than kernel
 internal secid
In-Reply-To: <20100924204531.28355.20320.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1009271038280.25748@tundra.namei.org>
References: <20100924204517.28355.42822.stgit@paris.rdu.redhat.com> <20100924204531.28355.20320.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Sep 2010, Eric Paris wrote:

> Currently the nfconntrack export code sends the kernel internal secid to
> userspace in a couple of proc files and over netlink as an integer.  This
> is wrong.  This number is a kernel internal.

I wouldn't say wrong, exactly.

The secid is a 32-bit integer which each LSM maps to its own domain.  
It's unlikely to change from this format (we were v. lucky to get this 
field, btw).

There's really no difference between this and the various kernel addresses 
exported via procfs by the networking code -- it's an opaque token which 
you can use to identify the security marking of a packet without 
necessarily having any knowledge of the security model itself.

It's potentially useful for debugging and writing simple userland tools, 
and may be in use already by apps.

>  This patch changes the export
> code to output either 0 or 1 for this value.

This potentially breaks existing apps and does not seem to add any value 
itself.  If you want to determine if a packet is marked, then simply check 
for zero or not.

>  A future patch will implement sending the name rather than the number 
> in a new field.

For the reasons above, I think the secctx string needs to be exported in 
addition to this rather than instead of.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
