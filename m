Date: Fri, 30 Jul 2010 19:22:34 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH -v3] selinux: convert the policy type_attr_map to
 flex_array
In-Reply-To: <20100730030233.18877.81076.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1007301922190.14581@tundra.namei.org>
References: <20100730030233.18877.81076.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Jul 2010, Eric Paris wrote:

> Current selinux policy can have over 3000 types.  The type_attr_map in
> policy is an array sized by the number of types times sizeof(struct ebitmap)
> (12 on x86_64).  Basic math tells us the array is going to be of length
> 3000 x 12 = 36,000 bytes.  The largest 'safe' allocation on a long running
> system is 16k.  Most of the time a 32k allocation will work.  But on long
> running systems a 64k allocation (what we need) can fail quite regularly.
> In order to deal with this I am converting the type_attr_map to use
> flex_arrays.  Let the library code deal with breaking this into PAGE_SIZE
> pieces.
> 
> -v2
> rework some of the if(!obj) BUG() to be BUG_ON(!obj)
> drop flex_array_put() calls and just use a _get() object directly
> 
> -v3
> make apply to James' tree (drop the policydb_write changes)
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
