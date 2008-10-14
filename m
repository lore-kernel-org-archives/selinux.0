Subject: Re: Capabilities audit field
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <200810130635.58500.sgrubb@redhat.com>
References: <200810120907.07511.sgrubb@redhat.com>
	 <alpine.LRH.1.10.0810131009520.16356@tundra.namei.org>
	 <200810130635.58500.sgrubb@redhat.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 09:35:30 -0400
Message-Id: <1223991330.5193.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-10-13 at 06:35 -0400, Steve Grubb wrote:
> On Sunday 12 October 2008 19:12:47 James Morris wrote:
> > On Sun, 12 Oct 2008, Steve Grubb wrote:
> > > I recently found out that the kernel now allows more than 32
> > > capabilities. This means I need to update the audit code that inteprets
> > > this value given from SE Linux. When I looked over the 2.6.27 kernel
> > > code, I found that SE Linux has not updated the capabilities code. Its
> > > still being kept as a simple integer in avc.h, but everywhere else I look
> > > in the kernel has moved to kernel_cap_t, which is an array. Are patches
> > > for moving to kernel_cap_t scheduled for 2.6.28? Are there security
> > > implications for not being able to access or control capabilities > 32?
> >
> > The AVC can opnly handle 32-bit vectors, so a capability2 class was added
> > to handle capabilities over 32-bits.
> >
> > See
> >
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h
> >=b68e418c445e8a468634d0a7ca2fb63bbaa74028
> 
> Then does this need some updating in avc.c ?
> 
>  570                case AVC_AUDIT_DATA_CAP:
>  571                        audit_log_format(ab, " capability=%d", a->u.cap);
>  572                        break;

Just to clarify:  this is reporting the simple integer value of the
capability (which is not a permission bitmask).  So it doesn't require
any changes.  For example, for capability 33, this will report
capability=33.  

That simple integer value is mapped to an index via CAP_TO_INDEX() and
to a bitmask via CAP_TO_MASK() in order to determine the right class and
permission bit to check for SELinux (see task_has_capability in
security/selinux/hooks.c), or to select the right word and bit within
the cap bitmap to check for capabilities (see cap_raised in
include/linux/capability.h).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
