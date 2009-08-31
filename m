Message-ID: <4A9BCEFF.8080600@martinorr.name>
Date: Mon, 31 Aug 2009 14:24:15 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Manoj Srivastava <srivasta@golden-gryphon.com>, selinux@tycho.nsa.gov,
        544215-forwarded@bugs.debian.org
Subject: Re: restorecon and symbolic links
References: <4A996106.4060604@martinorr.name>	 <87my5ijji4.fsf@anzu.internal.golden-gryphon.com>	 <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil> <1251721236.16143.18.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1251721236.16143.18.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 31/08/09 13:20, Stephen Smalley wrote:
> On Mon, 2009-08-31 at 08:17 -0400, Stephen Smalley wrote:
>> On Sat, 2009-08-29 at 18:19 -0500, Manoj Srivastava wrote:
>>> On Sat, Aug 29 2009, Martin Orr wrote:
>>>
>>>> With policycoreutils 2.0.71, "restorecon /dev/stdin" fails if stdin is a pipe:
>>>> martin@caligula:~$ echo hi | sudo restorecon /dev/stdin
>>>> realpath(/dev/stdin) failed No such file or directory
>>>>
>>>> Why would you want to do this?
>>>> The Debian udev init script does
>>>> ln -s /proc/self/fd/0 /dev/stdin
>>>> restorecon /dev/stdin
>>>> I am not sure why stdin is a pipe here but it is some consequence of the
>>>> boot process.
>>>>
>>>> The intention here (and what happened with policycoreutils 2.0.69) is to
>>>> relabel the symbolic link.  But the recent realpath patch changed this, and
>>>> I don't think there is a way now to ask restorecon to relabel an individual
>>>> symlink.
>>>         There are consequences to this change not mentioned above: when
>>>  booting with policycoreutils 2.0.71 /dev/pts (and several other device
>>>  nodes) are not created which causes all sorts of trouble.
>>>
>>>  This is a consequence of the realpath changes in restorecon, because
>>>  when /lib/udev/create_static_nodes does
>>>          ln -s /proc/self/fd/0 /dev/stdin
>>>          restorecon /dev/stdin
>>>  it now fails with the error
>>>          realpath(/dev/stdin) failed No such file or directory
>>>  This causes create_static_nodes to exit (due to set -e) before creating
>>>  /dev/pts.
>>>
>>>         I am planning on reverting the removal of special treatment of
>>>  symlinks from the debian  unstable version until this is resolved.
>> The particular commit was:
>>
>> commit 37c5c30998b73d9c6efe53fd0534256463991c5e
>> Author: Stephen Smalley <sds@tycho.nsa.gov>
>> Date:   Mon Aug 3 09:34:52 2009 -0400
>>
>>     setfiles: only call realpath() on user-supplied pathnames
>>     
>>     Change setfiles/restorecon to only call realpath() on the user-supplied
>>     pathnames prior to invoking fts_open().  This ensures that commands such
>>     as restorecon -R /etc/init.d and (cd /etc && restorecon shadow gshadow)
>>     will work as expected while avoiding the overhead of calling realpath()
>>     on each file during a file tree walk.
>>     
>>     Since we are now only acting on user-supplied pathnames, drop the
>>     special case handling of symlinks (when a user invokes restorecon
>>     -R /etc/init.d he truly wants it to descend /etc/rc.d/init.d).  We can
>>     also defer allocation of the pathname buffer to libc by passing NULL
>>     (freeing on the out path) and we can drop the redundant exclude() check
>>     as it will now get handled on the normal path.
>>     
>>     Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>
>> What behavior would you like instead?  I'd still like to have restorecon
>> -R /etc/init.d to do what the user expects, which isn't just relabel the
>> symlink.
> 
> Also, I'm a little unclear as to why we need the restorecon /dev/stdin
> above.  Why isn't /dev/stdin created in the right type to begin with?

The same script creates various links, directories and device nodes which
need to be created before udev starts.  Some of these do need to be
relabelled, and it would increase complexity to relabel some but not others.
 Just doing restorecon -R /dev at the end of the script might be an
alternative however.

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
