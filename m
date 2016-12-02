Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB2MdrnD011129
 for <selinux@tycho.nsa.gov>; Fri, 2 Dec 2016 17:39:53 -0500
Received: by mail-vk0-f52.google.com with SMTP id p9so153488867vkd.3
 for <selinux@tycho.nsa.gov>; Fri, 02 Dec 2016 14:39:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d6892b99-64b8-838e-f024-aeacb35df6e1@tycho.nsa.gov>
References: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
 <f89685d0-2088-6b27-2671-bfaafea57786@tycho.nsa.gov>
 <d6892b99-64b8-838e-f024-aeacb35df6e1@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Dec 2016 17:39:50 -0500
Message-ID: <CAHC9VhSh3v_u1hKvZAt0sdGm-PykApdu1j21Q56K036R7oN=Og@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: support distinctions among all network
 address families
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.net
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 2, 2016 at 12:40 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> I suppose a further question on this patch is whether it should also add
> new classes for ICMP, IGMP, and SCTP sockets (any others that are
> presently mapped to SECCLASS_RAWIP_SOCKET that ought to be given their
> own class?).  In the SCTP case, this would at least allow them to be
> distinguished, but we would still lack the full support added by the
> separate SCTP patchset.

For the record, I'm okay with this patch and I agree that the
compatibility concerns aren't likely to be significant.  However, I
would like to continue the discussion on the idea to include classes
for ICMP, IGMP, and SCTP.  I haven't looked into ICMP or IGMP, but
considering the changes necessary for SCTP I think it is okay to leave
SCTP out for now and add it in with proper SCTP support (and its own
policy capability).

Stephen, I'm assuming you feel the same since you left that out of the patch?

-- 
paul moore
www.paul-moore.com
