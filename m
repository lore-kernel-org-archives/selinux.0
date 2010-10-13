Subject: Re: [PATCH 1/2] SELinux: allow userspace to read policy back out
 of the kernel
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, kaigai@kaigai.gr.jp
In-Reply-To: <1280255967.4789.87.camel@moss-pluto.epoch.ncsc.mil>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
	 <1280177335.17036.5.camel@moss-pluto.epoch.ncsc.mil>
	 <1280254278.2788.7.camel@dhcp231-200.rdu.redhat.com>
	 <1280255967.4789.87.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Oct 2010 09:20:52 -0400
Message-ID: <1286976052.2614.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-07-27 at 14:39 -0400, Stephen Smalley wrote:
> On Tue, 2010-07-27 at 14:11 -0400, Eric Paris wrote:
> > On Mon, 2010-07-26 at 16:48 -0400, Stephen Smalley wrote:
> > > On Mon, 2010-07-26 at 15:34 -0400, Eric Paris wrote:
> > > > There is interest in being able to see what the actual policy is that was
> > > > loaded into the kernel.  The patch creates a new selinuxfs file
> > > > /selinux/policy which can be read by userspace.  The actual policy that is
> > > > loaded into the kernel will be written back out to userspace.
> > > 
> > > Can you clarify exactly how comparable the output is to the original
> > > policy file that was loaded?  Last time you mentioned range transition
> > > rules may be reordered, KaiGai mentioned that ebitmaps might not be
> > > identical after conversion (losing the original startbit), and Chris
> > > pointed out that sediff isn't sufficient for comparison as it doesn't
> > > yet handle constraints.
> > > 
> > > 
> > > > Signed-off-by: Eric Paris <eparis@redhat.com>
> > 
> > The only two areas that I had to deviate in any reasonable way from the
> > userspace policy write code was ebitmaps and range transition rules.
> > 
> > I'm not certain that we actually lose the startbit since if we look at
> > ebitmap_read()
> > 
> > #define MAPTYPE uint64_t        /* portion of bitmap in each node */
> > #define MAPSIZE (sizeof(MAPTYPE) * 8)   /* number of bits in node bitmap */
> > 
> > if (n->startbit & (MAPSIZE - 1)) {
> >                         printf
> >                             ("security: ebitmap start bit (%d) is not a multiple of the map size (%zu)\n",
> >                              n->startbit, MAPSIZE);
> >                         goto bad_free;
> >                 }
> > 
> > Which indicated to me that it has to always be aligned to u64.
> > 
> > If you load the policy you pulled out you should get back bit for bit
> > the exact same policy.  The only issue I knew of was the range
> > transition rules being stored in kernel in a hashtab instead of the
> > random order they are stored in userspace policy.  I wonder if I could
> > do better testing by sorting the range transition rules in userspace
> > into the same order I expect to get them back out of the kernel hashtab
> > to prove things.
> 
> Yes, I'd be in favor of that.  Just define the rangetr_cmp function in
> the kernel to truly order the entries at load time and sort them in the
> same manner in libsepol before writing.

Started working on this yesterday and still don't have a bit for bit
identical policy.

#cat /selinux/policy > /tmp/policy
#dmesg
[snip]
[  128.977564] starting symtab: 224
[  128.978321] starting symtab: 1419
[  128.979366] starting symtab: 29892
[  128.980187] starting symtab: 34841
[  128.981490] starting symtab: 172150
[  128.982291] starting symtab: 173917
[  128.983133] starting symtab: 179548
[  128.983933] starting symtab: 179774
[  128.984825] starting avtab: 196080
[  128.990442] starting cond: 2657920
[  129.001478] starting role_trans: 5652888
[snip]

Where is a program which compares two files byte by byte between start
and end and reports the first byte that is different.

# ./where /tmp/policy /etc/selinux/targeted/policy/policy.25 0 5967956
i=196147

The above says the first byte that is different is byte 196147 which we
know is in the avtab (thanks to the instrumented kernel output)

# ./where /tmp/policy /etc/selinux/targeted/policy/policy.25 0 196080
# echo $?
0

#./where /tmp/policy /etc/selinux/targeted/policy/policy.25 2657920 5967956
# echo $?
0

These two show that the files are now identical outside of the avtab
entries.  Now I'm trying to figure out why the avtab entries are not the
same.  Anyone have guesses off the top of their head?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
