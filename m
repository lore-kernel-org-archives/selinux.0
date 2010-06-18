Message-ID: <4C1BD732.30207@redhat.com>
Date: Fri, 18 Jun 2010 16:29:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: New init system hitting a distro near you.
References: <4C1BCA54.20005@redhat.com>	 <1276890327.22449.135.camel@moss-pluto.epoch.ncsc.mil>	 <4C1BD072.10700@redhat.com> <1276892527.22449.152.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1276892527.22449.152.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/18/2010 04:22 PM, Stephen Smalley wrote:
> On Fri, 2010-06-18 at 16:00 -0400, Daniel J Walsh wrote:
>> On 06/18/2010 03:45 PM, Stephen Smalley wrote:
>>> On Fri, 2010-06-18 at 15:34 -0400, Daniel J Walsh wrote:
>>>> http://0pointer.de/blog/projects/systemd.html
>>>>
>>>> This has interesting ramifications for SELinux.  I have a working
>>>> version of this in Fedora 14, but we need to add rules like
>>>>
>>>> allow sshd_t init_t:tcp_socket { getopt ioctl getattr setopt };
>>>>
>>>> Since systemd will be doing the listening and passing the socket to sshd.
>>>>
>>>> Could we have risks of sshd_t grabbing the tcp_socket connected to
>>>> httpd_t?
>>>>
>>>> In this scenario we are no longer protecting against the name_bind, and
>>>> are forced to put more trust into init_t.
>>>
>>> Can we get systemd to use setsockcreatecon() to assign the right label
>>> to the socket?
>>>
>>
>> Probably but how does it figure out the context?
>
> The sockets would normally be labeled with the context of the individual
> daemon process.  So we would want to compute the context in which the
> daemon process will run and then use that for the socket.  Which we can
> do via security_compute_create().  Sample code attached.  Compile with:
> gcc -lselinux -o setsockcon setsockcon.c
>
> Example run (in permissive):
> $ runcon system_u:system_r:init_t:s0 ./setsockcon /usr/sbin/sshd
> /usr/sbin/sshd system_u:system_r:sshd_t:s0
>


Might be a little bit shakey, in that the daemon program started might 
not transition, might be a symbolic link, there could be two transitions 
that happen.   I will see if I can add this code and see how it works.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
