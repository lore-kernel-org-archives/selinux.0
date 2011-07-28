Message-ID: <4E30D03B.8010707@windriver.com>
Date: Thu, 28 Jul 2011 10:58:03 +0800
From: Rongqing Li <rongqing.li@windriver.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Eric Paris
	<eparis@parisplace.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: "netstat -Z" reimplementation
References: <4E2FDA3A.5040408@windriver.com> <1311768565.23346.11.camel@moss-pluto>
In-Reply-To: <1311768565.23346.11.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/27/2011 08:09 PM, Stephen Smalley wrote:
> On Wed, 2011-07-27 at 17:28 +0800, Rongqing Li wrote:
>> SELinux folks, Stephen:
>>
>> I have some thoughts about reimplementation of 'netstat -Z', but I do
>> not know if it is valuable, or if there are other risks. Could you
>> evaluate my implementation, or give me your valuable advice?
>>
>> 1. From kernel, print the socket labels to tcp, udp, raw, unix
>> files under /proc/net/.
>>
>> Now the /proc/net/tcp /proc/net/udp ... include many socket's
>> information, like local address, remote address, inode, I think we can
>> put the socket's security context to these files.
>>
>> To avoid to expose these information to non-privileged users, security
>> checking should be done when expose the socket security context to procfs.
>
> We can already control the ability to read /proc/net files by labeling
> them via genfscon statements and then writing policy accordingly.  Do we
> think exposing the (raw) security context is any more of a concern than
> the rest of the information in the file?
>
> Can we add a field to those files without breaking compatibility with
> existing userspace?
>

Currently, if a user can access /proc/net/tcp, this user can get tcp socket
all information, I think this maybe a error.

Like below case:
-------------------------------------------------------
# id -Z
root:sysadm_r:sysadm_t:s0-s15:c0.c1023
#
# netstat -Za |grep "dev/log"
unix  2      [ ACC ]     STREAM     LISTENING     7263   508/syslog-ng 
system_u:system_r:syslogd_t:s15:c0.c1023          /dev/log
#
-------------------------------------------------------

This control can be implemented when kernel print this information to 
kernel.

-Roy

>> 2. reimplementation the "netstat -Z", "netstat -Z" will first parse the
>> security context from procfs's tcp, udp, raw files, and get the security
>> context, if this step fails, "netstat -Z" will try as legacy method.
>
> It should only fall back to the legacy method if the context is not
> present in the file; if there is any other reason for failure (e.g.
> permission denied to /proc/net/tcp), then we presumably want netstat -Z
> to fail rather than report a possibly incorrect result.
>
>> If this implementation could be accepted by mainstream, netstat could
>> print the correct socket label even if the type_transition has been
>> happen on socket, or application changes socket labels by setting
>> /proc/self/attr/sockcreate.
>>
>>
>> Do you think it is valuable?
>
> Yes, I think it would be useful.
>

-- 
Best Reagrds,
Roy | RongQing Li
-------------------------------------------------------------
WIND RIVER Beijing | China Development Center
Phone: +86-10-6483-5025, Cell: +86-135-2202-9864, Fax: +86-10-6479-0367

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
