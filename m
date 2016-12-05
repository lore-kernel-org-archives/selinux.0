Subject: Re: [RFC][PATCH] selinux: support distinctions among all network
 address families
To: Paul Moore <paul@paul-moore.com>
References: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
 <f89685d0-2088-6b27-2671-bfaafea57786@tycho.nsa.gov>
 <d6892b99-64b8-838e-f024-aeacb35df6e1@tycho.nsa.gov>
 <CAHC9VhSh3v_u1hKvZAt0sdGm-PykApdu1j21Q56K036R7oN=Og@mail.gmail.com>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.net,
 Richard Haines <richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5c66b64e-19f1-3fe3-5efe-13083151f9bd@tycho.nsa.gov>
Date: Mon, 5 Dec 2016 09:11:26 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSh3v_u1hKvZAt0sdGm-PykApdu1j21Q56K036R7oN=Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/02/2016 05:39 PM, Paul Moore wrote:
> On Fri, Dec 2, 2016 at 12:40 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> I suppose a further question on this patch is whether it should also add
>> new classes for ICMP, IGMP, and SCTP sockets (any others that are
>> presently mapped to SECCLASS_RAWIP_SOCKET that ought to be given their
>> own class?).  In the SCTP case, this would at least allow them to be
>> distinguished, but we would still lack the full support added by the
>> separate SCTP patchset.
> 
> For the record, I'm okay with this patch and I agree that the
> compatibility concerns aren't likely to be significant.  However, I
> would like to continue the discussion on the idea to include classes
> for ICMP, IGMP, and SCTP.  I haven't looked into ICMP or IGMP, but
> considering the changes necessary for SCTP I think it is okay to leave
> SCTP out for now and add it in with proper SCTP support (and its own
> policy capability).
> 
> Stephen, I'm assuming you feel the same since you left that out of the patch?

It depends on whether we think full SCTP support will be merged sooner
or later.  If there is the possibility that full SCTP support will not
be merged for a while, then I think I'd rather just add a SCTP socket
class as part of this patch so that we can at least distinguish between
SCTP sockets and raw IP sockets in policy in the interim.

The other question is whether you agreed with Guido's suggested change
for readability/maintainability or prefer the current style. I have no
strong opinion either way.
