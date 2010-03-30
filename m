Message-ID: <4BB241A5.7090105@redhat.com>
Date: Tue, 30 Mar 2010 14:23:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
Subject: Re: svirt on MLS has strange AVC.
References: <4BA7E4BF.1040002@redhat.com>	 <201003291600.06024.paul.moore@hp.com> <4BB20E8D.7030207@redhat.com>	 <201003301407.12372.paul.moore@hp.com> <1269973226.2941.11.camel@dhcp235-240.rdu.redhat.com>
In-Reply-To: <1269973226.2941.11.camel@dhcp235-240.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/30/2010 02:20 PM, Eric Paris wrote:
> On Tue, 2010-03-30 at 14:07 -0400, Paul Moore wrote:
>    
>> On Tuesday 30 March 2010 10:45:33 am Daniel J Walsh wrote:
>>      
>>> Paul you are suggesting that I write a MLS rule that says
>>>
>>> svirt_t:ANYLEVEL can talk to svirt_t:ANYLEVEL over unix domain sockets.
>>>
>>> Which would allow
>>>
>>> svirt_t:s0 to talk to svirt_t:s1  Which seems very broken to me.
>>>        
>> Well, based on the domains that were reported earlier in the thread ...
>>
>>      
>>> # ps -eZ | grep virt
>>> system_u:system_r:virtd_t:s0-s15:c0.c1023 27344 ? 05:34:47 libvirtd
>>> system_u:system_r:svirt_t:s0:c1 28549 ?        00:00:01 qemu-kvm
>>>        
>> ... I think you just need to write policy that allows "virtd_t:ANYLEVEL" and
>> "svirtd_t:ANYLEVEL" to communicate; you shouldn't need to allow
>> "svirt_t:ANYLEVEL" to communicate with "svirt_t" since only qemu-kvm is
>> running as "svirt_t" and you are trying to get qemu-kvm and libvirtd to talk.
>>      
> The QEMU/KVM "server child socket" gets labeled svirt_t:s0-s15:c0-c1023
> (type of svirt_t and level of the peer, libvirtd_t)   So svirt_t needs
> to talk to svirt_t.  That's the whole issue.....
>
> -Eric
>
>    
Yes letting svirt_t:level1 talk to libvirt_t:RangecontinaingLevel1 is easy

allowing svirt_t:level1 talk to svirt_t:RangecontainingLevel1 is the problem
Since I end up allowing all svirt_t to talk to all svirt_t, No MLS 
controls at all.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
