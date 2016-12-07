Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB7FEQHc024053
 for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2016 10:14:27 -0500
Received: by mail-ua0-f196.google.com with SMTP id b35so39357094uaa.1
 for <selinux@tycho.nsa.gov>; Wed, 07 Dec 2016 07:14:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4d02c906-b208-ffe8-8a56-46734d764c34@tycho.nsa.gov>
References: <1481036419-30057-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQgD_oYn2zCzJCvUzzD_zJYKiQVbG_YMfoPpjphJzTOHA@mail.gmail.com>
 <4d02c906-b208-ffe8-8a56-46734d764c34@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Dec 2016 10:14:23 -0500
Message-ID: <CAHC9VhT6E9vLebvBcTX7XtPkP6eGNM-7rxkKAydsDrUwO2Sj5Q@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support distinctions among all network
 address families
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.net,
 richard_c_haines@btinternet.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 7, 2016 at 8:25 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/06/2016 07:13 PM, Paul Moore wrote:
>> On Tue, Dec 6, 2016 at 10:00 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> Extend SELinux to support distinctions among all network address families
>>> implemented by the kernel by defining new socket security classes
>>> and mapping to them. Otherwise, many sockets are mapped to the generic
>>> socket class and are indistinguishable in policy.  This has come up
>>> previously with regard to selectively allowing access to bluetooth sockets,
>>> and more recently with regard to selectively allowing access to AF_ALG
>>> sockets.  Guido Trentalancia submitted a patch that took a similar approach
>>> to add only support for distinguishing AF_ALG sockets, but this generalizes
>>> his approach to handle all address families implemented by the kernel.
>>> Socket security classes are also added for ICMP and SCTP sockets.
>>> Socket security classes were not defined for AF_* values that are reserved
>>> but unimplemented in the kernel, e.g. AF_NETBEUI, AF_SECURITY, AF_ASH,
>>> AF_ECONET, AF_SNA, AF_WANPIPE.
>>>
>>> Backward compatibility is provided by only enabling the finer-grained
>>> socket classes if a new policy capability is set in the policy; older
>>> policies will behave as before.  The legacy redhat1 policy capability
>>> that was only ever used in testing within Fedora for ptrace_child
>>> is reclaimed for this purpose; as far as I can tell, this policy
>>> capability is not enabled in any supported distro policy.
>>>
>>> Add a pair of conditional compilation guards to detect when new AF_* values
>>> are added so that we can update SELinux accordingly rather than having to
>>> belatedly update it long after new address families are introduced.
>>>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>> v2 reworks the style based on comments from Guido Trentalancia and adds
>>> security classes for SCTP and ICMP sockets.  The security class support
>>> for SCTP sockets was based on Richard Haines' SCTP patch set.  For now,
>>> we only duplicate the class definition for rawip_socket for SCTP and ICMP
>>> sockets since that is how they were previously mapped.  The SCTP definition
>>> can be further fleshed out by the SCTP patch set itself.
>>>
>>>  security/selinux/hooks.c            | 73 +++++++++++++++++++++++++++++++++++++
>>>  security/selinux/include/classmap.h | 68 ++++++++++++++++++++++++++++++++++
>>>  security/selinux/include/security.h |  3 +-
>>>  security/selinux/selinuxfs.c        |  2 +-
>>>  security/selinux/ss/services.c      |  3 ++
>>>  5 files changed, 147 insertions(+), 2 deletions(-)
>>
>> You mentioned IGMP previously, if we have a class for ICMP, it seems
>> reasonable to have one for IGMP, don't you think?  Although this does
>> spiral a bit if we consider all the IPPROTO* protocols.
>
> I thought about it, but the kernel does not provide IGMP sockets per se,
> unlike ICMP or SCTP sockets (i.e. ipv4/af_inet.c:inetsw_array[] defines
> an entry for SOCK_DGRAM, IPPROTO_ICMP and sctp/protocol.c defines and
> registers inet_protosw entries for SOCK_STREAM, IPPROTO_SCTP and
> SOCK_SEQPACKET, IPPROTO_SCTP; there is no equivalent for IGMP unless I
> missed it).  So IGMP sockets are just raw IP sockets with a particular
> protocol value; they have no stream, seqpacket, or dgram semantics, and
> it is unclear it is worthwhile to distinguish them in policy.

Yes, sorry about that, it looks like you're right.  I thought there
might be some sort of IGMP routing daemon or something that would need
to create an IGMP socket, but it looks like you just configure the
kernel's multicast routing table and the kernel takes care of the IGMP
packets.

-- 
paul moore
www.paul-moore.com
