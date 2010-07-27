Subject: Re: [PATCH 1/2] SELinux: allow userspace to read policy back out
 of the kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, kaigai@kaigai.gr.jp
In-Reply-To: <1280254278.2788.7.camel@dhcp231-200.rdu.redhat.com>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
	 <1280177335.17036.5.camel@moss-pluto.epoch.ncsc.mil>
	 <1280254278.2788.7.camel@dhcp231-200.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 14:39:27 -0400
Message-ID: <1280255967.4789.87.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-07-27 at 14:11 -0400, Eric Paris wrote:
> On Mon, 2010-07-26 at 16:48 -0400, Stephen Smalley wrote:
> > On Mon, 2010-07-26 at 15:34 -0400, Eric Paris wrote:
> > > There is interest in being able to see what the actual policy is that was
> > > loaded into the kernel.  The patch creates a new selinuxfs file
> > > /selinux/policy which can be read by userspace.  The actual policy that is
> > > loaded into the kernel will be written back out to userspace.
> > 
> > Can you clarify exactly how comparable the output is to the original
> > policy file that was loaded?  Last time you mentioned range transition
> > rules may be reordered, KaiGai mentioned that ebitmaps might not be
> > identical after conversion (losing the original startbit), and Chris
> > pointed out that sediff isn't sufficient for comparison as it doesn't
> > yet handle constraints.
> > 
> > 
> > > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> The only two areas that I had to deviate in any reasonable way from the
> userspace policy write code was ebitmaps and range transition rules.
> 
> I'm not certain that we actually lose the startbit since if we look at
> ebitmap_read()
> 
> #define MAPTYPE uint64_t        /* portion of bitmap in each node */
> #define MAPSIZE (sizeof(MAPTYPE) * 8)   /* number of bits in node bitmap */
> 
> if (n->startbit & (MAPSIZE - 1)) {
>                         printf
>                             ("security: ebitmap start bit (%d) is not a multiple of the map size (%zu)\n",
>                              n->startbit, MAPSIZE);
>                         goto bad_free;
>                 }
> 
> Which indicated to me that it has to always be aligned to u64.
> 
> If you load the policy you pulled out you should get back bit for bit
> the exact same policy.  The only issue I knew of was the range
> transition rules being stored in kernel in a hashtab instead of the
> random order they are stored in userspace policy.  I wonder if I could
> do better testing by sorting the range transition rules in userspace
> into the same order I expect to get them back out of the kernel hashtab
> to prove things.

Yes, I'd be in favor of that.  Just define the rangetr_cmp function in
the kernel to truly order the entries at load time and sort them in the
same manner in libsepol before writing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
