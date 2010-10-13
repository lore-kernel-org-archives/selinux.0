Subject: Re: [PATCH 1/2] SELinux: allow userspace to read policy back out
 of the kernel
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, kaigai@kaigai.gr.jp,
        method@manicmethod.com
In-Reply-To: <1286976052.2614.24.camel@localhost.localdomain>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
	 <1280177335.17036.5.camel@moss-pluto.epoch.ncsc.mil>
	 <1280254278.2788.7.camel@dhcp231-200.rdu.redhat.com>
	 <1280255967.4789.87.camel@moss-pluto.epoch.ncsc.mil>
	 <1286976052.2614.24.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Oct 2010 10:17:43 -0400
Message-ID: <1286979463.2614.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-10-13 at 09:20 -0400, Eric Paris wrote:
> On Tue, 2010-07-27 at 14:39 -0400, Stephen Smalley wrote:

> > Yes, I'd be in favor of that.  Just define the rangetr_cmp function in
> > the kernel to truly order the entries at load time and sort them in the
> > same manner in libsepol before writing.
> 
> Started working on this yesterday and still don't have a bit for bit
> identical policy.

[snip]

> These two show that the files are now identical outside of the avtab
> entries.  Now I'm trying to figure out why the avtab entries are not the
> same.  Anyone have guesses off the top of their head?

My first thought is that the avtab was allocated in expand_avtab() for
the policy.25 and thus was done with an expected # of rules equal to
MAX_AVTAB_SIZE, whereas the kernel builds a 'correctly' sized avtab
since it knows the correct number of rules.  If this is the case it
explains how things would get put in different buckets and we end up
with the same policy, but different ordering.

If this is the case (which seems likely) I'm wondering the best way to
fix this.  I don't really want to have to rebuild the userspace avtable
a second time just to get final ordering (as if userspace wasn't slow
enough) but we can't size the avtab correctly during expand either...

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
