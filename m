Message-ID: <1481033405.16934.1.camel@btinternet.com>
Subject: Re: [RFC][PATCH] selinux: support distinctions among all network
 address families
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.net
Date: Tue, 06 Dec 2016 14:10:05 +0000
In-Reply-To: <CAHC9VhReQ0-Yb+r=uL5UmWUj_1VmTGVFVASfGghf1TgF9sYEvw@mail.gmail.com>
References: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
 <f89685d0-2088-6b27-2671-bfaafea57786@tycho.nsa.gov>
 <d6892b99-64b8-838e-f024-aeacb35df6e1@tycho.nsa.gov>
 <CAHC9VhSh3v_u1hKvZAt0sdGm-PykApdu1j21Q56K036R7oN=Og@mail.gmail.com>
 <5c66b64e-19f1-3fe3-5efe-13083151f9bd@tycho.nsa.gov>
 <CAHC9VhReQ0-Yb+r=uL5UmWUj_1VmTGVFVASfGghf1TgF9sYEvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2016-12-05 at 17:54 -0500, Paul Moore wrote:
> On Mon, Dec 5, 2016 at 9:11 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On 12/02/2016 05:39 PM, Paul Moore wrote:
> > > On Fri, Dec 2, 2016 at 12:40 PM, Stephen Smalley <sds@tycho.nsa.g
> > > ov> wrote:
> > > > I suppose a further question on this patch is whether it should
> > > > also add
> > > > new classes for ICMP, IGMP, and SCTP sockets (any others that
> > > > are
> > > > presently mapped to SECCLASS_RAWIP_SOCKET that ought to be
> > > > given their
> > > > own class?).  In the SCTP case, this would at least allow them
> > > > to be
> > > > distinguished, but we would still lack the full support added
> > > > by the
> > > > separate SCTP patchset.
> > > 
> > > For the record, I'm okay with this patch and I agree that the
> > > compatibility concerns aren't likely to be significant.  However,
> > > I
> > > would like to continue the discussion on the idea to include
> > > classes
> > > for ICMP, IGMP, and SCTP.  I haven't looked into ICMP or IGMP,
> > > but
> > > considering the changes necessary for SCTP I think it is okay to
> > > leave
> > > SCTP out for now and add it in with proper SCTP support (and its
> > > own
> > > policy capability).
> > > 
> > > Stephen, I'm assuming you feel the same since you left that out
> > > of the patch?
> > 
> > It depends on whether we think full SCTP support will be merged
> > sooner
> > or later.  If there is the possibility that full SCTP support will
> > not
> > be merged for a while, then I think I'd rather just add a SCTP
> > socket
> > class as part of this patch so that we can at least distinguish
> > between
> > SCTP sockets and raw IP sockets in policy in the interim.
> 
> As I sit here I would like to think that we'll get proper SCTP
> support
> merged sooner rather than later, but well ... things happen.  I guess
> there is no harm in adding the SCTP socket class now just in case.
> 
> > The other question is whether you agreed with Guido's suggested
> > change
> > for readability/maintainability or prefer the current style. I have
> > no
> > strong opinion either way.
> 
> I really don't care too much either way which is why I didn't comment
> on it.  I suppose I have a slight preference for Guido's suggested
> style, but I wouldn't respin the patch just for that.  However, if
> you
> are going to add SCTP (which I'm guessing we should) go ahead and use
> Guido's style.

Not sure if helpful but I plan to submit the SCTP patch next week after
testing on Fedora 25 with kernel 4.8.11.

> 
