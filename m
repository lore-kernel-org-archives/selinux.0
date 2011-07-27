Message-ID: <4E3014A6.7060903@redhat.com>
Date: Wed, 27 Jul 2011 09:37:42 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Rongqing Li <rongqing.li@windriver.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: "netstat -Z" reimplementation
References: <4E2FDA3A.5040408@windriver.com> <1311768565.23346.11.camel@moss-pluto>
In-Reply-To: <1311768565.23346.11.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/27/2011 08:09 AM, Stephen Smalley wrote:
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

I tried once in the past and was told that no, I was not allowed to add
fields (seemed pretty stupid to me at the time and I don't remember if
the person who told me that actually knew what they were talking about)

I believe I was told (and you should believe that my memory for things
more than 10 minutes old stinks and this was about 4 years ago) that I
was supposed to use "tcp_diag" instead.  I never figured out what that
was, so I never got the patch in...

Just figured you should know up front....

-Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
