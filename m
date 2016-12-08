Subject: Re: [PATCH v2] selinux: support distinctions among all network
 address families
To: Paul Moore <paul@paul-moore.com>
References: <1481036419-30057-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQgD_oYn2zCzJCvUzzD_zJYKiQVbG_YMfoPpjphJzTOHA@mail.gmail.com>
 <4d02c906-b208-ffe8-8a56-46734d764c34@tycho.nsa.gov>
 <CAHC9VhT6E9vLebvBcTX7XtPkP6eGNM-7rxkKAydsDrUwO2Sj5Q@mail.gmail.com>
 <f0075276-99eb-5aba-c009-7c760581be14@tycho.nsa.gov>
 <CAHC9VhSEe_aXLob3oWtWDnijM5Ag8wNNA3_WLoU=7surmSXU7A@mail.gmail.com>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.net,
 richard_c_haines@btinternet.com
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <71adc3b1-e882-532c-de2a-7b9b7974d2ca@tycho.nsa.gov>
Date: Thu, 8 Dec 2016 14:42:13 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSEe_aXLob3oWtWDnijM5Ag8wNNA3_WLoU=7surmSXU7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/07/2016 06:32 PM, Paul Moore wrote:
> On Wed, Dec 7, 2016 at 10:24 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/07/2016 10:14 AM, Paul Moore wrote:
>>> On Wed, Dec 7, 2016 at 8:25 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 12/06/2016 07:13 PM, Paul Moore wrote:
>>>>> On Tue, Dec 6, 2016 at 10:00 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>> Extend SELinux to support distinctions among all network address families
>>>>>> implemented by the kernel by defining new socket security classes
>>>>>> and mapping to them. Otherwise, many sockets are mapped to the generic
>>>>>> socket class and are indistinguishable in policy.  This has come up
>>>>>> previously with regard to selectively allowing access to bluetooth sockets,
>>>>>> and more recently with regard to selectively allowing access to AF_ALG
>>>>>> sockets.  Guido Trentalancia submitted a patch that took a similar approach
>>>>>> to add only support for distinguishing AF_ALG sockets, but this generalizes
>>>>>> his approach to handle all address families implemented by the kernel.
>>>>>> Socket security classes are also added for ICMP and SCTP sockets.
>>>>>> Socket security classes were not defined for AF_* values that are reserved
>>>>>> but unimplemented in the kernel, e.g. AF_NETBEUI, AF_SECURITY, AF_ASH,
>>>>>> AF_ECONET, AF_SNA, AF_WANPIPE.
>>>>>>
>>>>>> Backward compatibility is provided by only enabling the finer-grained
>>>>>> socket classes if a new policy capability is set in the policy; older
>>>>>> policies will behave as before.  The legacy redhat1 policy capability
>>>>>> that was only ever used in testing within Fedora for ptrace_child
>>>>>> is reclaimed for this purpose; as far as I can tell, this policy
>>>>>> capability is not enabled in any supported distro policy.
>>>>>>
>>>>>> Add a pair of conditional compilation guards to detect when new AF_* values
>>>>>> are added so that we can update SELinux accordingly rather than having to
>>>>>> belatedly update it long after new address families are introduced.
>>>>>>
>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>> ---
>>>>>> v2 reworks the style based on comments from Guido Trentalancia and adds
>>>>>> security classes for SCTP and ICMP sockets.  The security class support
>>>>>> for SCTP sockets was based on Richard Haines' SCTP patch set.  For now,
>>>>>> we only duplicate the class definition for rawip_socket for SCTP and ICMP
>>>>>> sockets since that is how they were previously mapped.  The SCTP definition
>>>>>> can be further fleshed out by the SCTP patch set itself.
>>>>>>
>>>>>>  security/selinux/hooks.c            | 73 +++++++++++++++++++++++++++++++++++++
>>>>>>  security/selinux/include/classmap.h | 68 ++++++++++++++++++++++++++++++++++
>>>>>>  security/selinux/include/security.h |  3 +-
>>>>>>  security/selinux/selinuxfs.c        |  2 +-
>>>>>>  security/selinux/ss/services.c      |  3 ++
>>>>>>  5 files changed, 147 insertions(+), 2 deletions(-)
>>>>>
>>>>> You mentioned IGMP previously, if we have a class for ICMP, it seems
>>>>> reasonable to have one for IGMP, don't you think?  Although this does
>>>>> spiral a bit if we consider all the IPPROTO* protocols.
>>>>
>>>> I thought about it, but the kernel does not provide IGMP sockets per se,
>>>> unlike ICMP or SCTP sockets (i.e. ipv4/af_inet.c:inetsw_array[] defines
>>>> an entry for SOCK_DGRAM, IPPROTO_ICMP and sctp/protocol.c defines and
>>>> registers inet_protosw entries for SOCK_STREAM, IPPROTO_SCTP and
>>>> SOCK_SEQPACKET, IPPROTO_SCTP; there is no equivalent for IGMP unless I
>>>> missed it).  So IGMP sockets are just raw IP sockets with a particular
>>>> protocol value; they have no stream, seqpacket, or dgram semantics, and
>>>> it is unclear it is worthwhile to distinguish them in policy.
>>>
>>> Yes, sorry about that, it looks like you're right.  I thought there
>>> might be some sort of IGMP routing daemon or something that would need
>>> to create an IGMP socket, but it looks like you just configure the
>>> kernel's multicast routing table and the kernel takes care of the IGMP
>>> packets.
>>
>> Well, I think you can create an IGMP socket ala socket(PF_INET,
>> SOCK_RAW, IPPROTO_IGMP).  And we could map that to a IGMP socket class
>> if we really wanted to do so.  But that would be the first time we ever
>> mapped a (PF_INET, SOCK_RAW, proto) to something other than
>> SECCLASS_RAWIP_SOCKET.  And at that point we'd probably want to map
>> every individual protocol value.  Not sure we need/want to go there.
> 
> Yes, creating classes for each IPPROTO value is not something I think
> we want to do, although I have no problem doing it for key protocols
> as necessary.
> 
> I just merged this into selinux#next, the pull request for v4.10 was
> already sent up to James so this will go in during the v4.11 merge
> window (I think this can wait, it might give us time to get some of
> the policy ready).

Wanted to clarify one point and also mention a bug/deficiency of this
patch that I just realized:

- Clarification: At present, the patch will map PF_INET, SOCK_DGRAM,
IPPROTO_ICMP to icmp_socket, but will continue to map PF_INET, SOCK_RAW,
IPPROTO_ICMP to rawip_socket.  That's intentional, since the SOCK_DGRAM
IPPROTO_ICMP sockets were introduced to provide a more restricted form
of ICMP sockets that could be exposed to unprivileged users (based on a
sysctl), so distinguishing those in policy makes sense.  But it could be
surprising.

- Bug/deficiency:  I hadn't noticed that there is a separate
IPPROTO_ICMPV6, so I'll need to modify this patch or post a follow-on
that ensure that we map SOCK_DGRAM,IPPROTO_ICMPV6 to icmp_socket too.
