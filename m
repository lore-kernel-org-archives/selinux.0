Message-ID: <462CF79C.5080804@redhat.com>
Date: Mon, 23 Apr 2007 14:14:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, Ken YANG <spng.yang@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: can not boot with strict policy
References: <462CA1F0.2000400@gmail.com>	 <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil>	 <Line.LNX.4.64.0704231341100.3793@d.namei> <1177350508.24282.58.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1177350508.24282.58.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2007-04-23 at 13:42 -0400, James Morris wrote:
>   
>> On Mon, 23 Apr 2007, Stephen Smalley wrote:
>>
>>     
>>> /lib/libsepol.so.1 should be labeled with shlib_t, not lib_t.  Under
>>> targeted policy, they are aliases for one another.  Under strict, they
>>> are separate types.
>>>
>>> Boot with "enforcing=0 single" to come up permissive into single-user
>>> mode, then run /sbin/fixfiles relabel -F to forcible relabel everything,
>>> then reboot.
>>>       
>> I wonder if we could automate this, so that the autorelabel is also run 
>> on boot if you switch between different types of policy.
>>     
>
> rc.sysinit does have autorelabel support, but that won't help in this
> case, because here everything (including /sbin/init) will fail to run
> due to the inability to execute shared libs.  It would have to happen
> from early userspace or /sbin/init before loading policy and switching
> to enforcing mode.
>
>   
So the real question, is there much value with the division between 
lib_t and shlib_t.
When dealing with strict policy, shared libraries were always getting 
mislabeled as lib_t, and causing problems, for little security advantage. 

As we remove the differences between strict and targeted, I don't intend 
to get rid of lib_t == shlib_t.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
