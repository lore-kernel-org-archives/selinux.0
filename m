Message-ID: <555DE3A2.1070509@tycho.nsa.gov>
Date: Thu, 21 May 2015 09:54:42 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
References: <1428616130-14570-1-git-send-email-jeffv@google.com>	<1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555DD0CF.8070000@tycho.nsa.gov> <555DE0EF.3010402@tycho.nsa.gov>
 <555DE298.9020207@tycho.nsa.gov>
In-Reply-To: <555DE298.9020207@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/21/2015 09:50 AM, Stephen Smalley wrote:
> On 05/21/2015 09:43 AM, James Carter wrote:
>> On 05/21/2015 08:34 AM, Stephen Smalley wrote:
>>> On 05/20/2015 08:39 PM, William Roberts wrote:
>>>>
>>>>
>>>> On Wed, May 20, 2015 at 1:04 PM, Paul Moore <paul@paul-moore.com
>>>> <mailto:paul@paul-moore.com>> wrote:
>>>>
>>>>      First off, my apologies for such a long delay in providing
>>>>      feedback.  The
>>>>      delay wasn't due to any fault of yours, rather just a backlog on my
>>>>      todo list.
>>>>
>>>>      Comments below ...
>>>>
>>>>      On Thursday, April 09, 2015 02:48:50 PM Jeff Vander Stoep wrote:
>>>>      > ---- motivation ----
>>>>      > Ioctls provide many of the operations necessary for device
>>>>      control. The
>>>>      > typical driver supports a device specific set of operations
>>>>      accessible by
>>>>      > the ioctl system call and specified by the command argument.
>>>> SELinux
>>>>      > provides per operation access control to many system operations
>>>>      e.g. chown,
>>>>      > kill, setuid, ipc_lock, etc. Ioclts on the other hand are granted
>>>>      on a per
>>>>      > file descriptor basis using the ioctl permission, meaning that
>>>> the
>>>>      set of
>>>>      > operations provided by the driver are granted on an
>>>> all-or-nothing
>>>>      basis.
>>>>
>>>>      ...
>>>>
>>>>      > ---- Design constraints ----
>>>>      > Policy: Support existing policy, targeted whitelisting. The
>>>> ioctls
>>>>      commands
>>>>      > used on a system may not be completely known to a
>>>>      sysadmin/policywriter. It
>>>>      > is not reasonable to enforce that all needed commands be known in
>>>>      order to
>>>>      > use this feature in a targeted manner. Existing policy using
>>>> the ioctl
>>>>      > permission will continue to work as-is. Policy targeting a
>>>> specific
>>>>      > source/target/class will only be enforced on that particular
>>>>      > source/target/class. E.g. continue to allow init to access all
>>>> ioctls
>>>>      > provided by a driver, but only allow the browser to access a
>>>> subset.
>>>>      >
>>>>      > Performance: Many ioctl calls are performance sensitive, and some
>>>>      ioctls
>>>>      > have a large command set (e.g. sockets support hundreds of
>>>> commands).
>>>>      > Execution time on a filtered ioctl should be similar to execution
>>>>      time on
>>>>      > an unfiltered one and not related to the number of commands being
>>>>      filtered.
>>>>      > Performance numbers will be included in a separate document.
>>>>      >
>>>>      > Command space: The ioctl command is a 32 bit number comprised
>>>> of four
>>>>      > fields, number - sequence number of the command. 8 bits
>>>>      > type - magic number assigned to the driver. 8 bits
>>>>      > size - size of the user data involved. typically 14 bits (arch
>>>>      dependent)
>>>>      > direction - The direction of data transfer. typically 2 bits
>>>> (arch
>>>>      > dependent) The command is uniquely identified by the type and
>>>>      number, size
>>>>      > and direction are considered to be arguments and are not
>>>>      considered for
>>>>      > SELinux whitelisting.
>>>>      >
>>>>      > ---- Policy format ----
>>>>      > allow <source> <target>:<class> { 0x8910-0x8926 0x892A-0x8935 }
>>>>      > auditallow <source> <target>:<class> 0x892A
>>>>
>>>>      I agree with only specifying the lower 16 bits (command,type) when
>>>>      specifying
>>>>      the individual ioctls, I even like the '-' shortcut, but I'm a
>>>> little
>>>>      concerned about specifying a number directly in the permission
>>>> field
>>>>      without
>>>>      any sort of qualifier.  Specifically I'm worried that it hurts the
>>>>      readability
>>>>      of the policy and could pose problems with future work.
>>>>
>>>>      I'd be much happier if we could add some sort of syntax which would
>>>>      qualify
>>>>      the numbers as ioctls, for example:
>>>>
>>>>        allow <source> <target>:<class> { ioctl(0x8910-0x8926)
>>>> ioctl(0x892A) }
>>>>
>>>>
>>>> If you want additional syntax couldn't we move that burden to m4 rather
>>>> then making it a part of the compiler core?
>>>
>>> It has to be handled by checkpolicy and encoded in the kernel binary
>>> policy as an additional field if we want to support other uses of these
>>> operation structures for purposes other than just ioctl.
>>>
>>
>> Do you have something else in mind that might use the operation structures?
>>
>>
>> In CIL we will probably make the syntax something like this:
>>
>> ((allowop <source> <target> <class> <ioctl expression>)
>>
>> So the above rule might look like:
>>
>> (allowop <source> <target> <class> ((range 0x8910 0x8926) 0x892A))
> 
> Paul asked to generalize it so it can be reused for other purposes.  One
> example would be netlink message types.  Today, there is a hardcoded
> table in SELinux (security/selinux/nlmsgtab.c) that maps specific
> netlink message type values to nlmsg_read (i.e. reads public kernel
> state), nlmsg_readpriv (i.e. reads potentially sensitive kernel state),
> nlmsg_write (i.e. modifies kernel state), and a few other audit-specific
> values so we can distinguish e.g. who can read vs write routing table
> entries or audit configuration, as the normal socket read/write checks
> merely control the ability to send/recv on the socket, which is always
> required for any user of it.  That has limited flexibility and isn't
> generally well maintained for newer netlink protocols.

So the proposal would be to just add an additional field specifying how
to interpret/apply the operation list, e.g.
(allowop <source> <target> <class> <ioctl|netlink|...> ((range 0x8910
0x8926) 0x892A))
