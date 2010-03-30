Message-ID: <4BB251A1.9050303@redhat.com>
Date: Tue, 30 Mar 2010 15:31:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
Subject: Re: svirt on MLS has strange AVC.
References: <4BA7E4BF.1040002@redhat.com> <201003301456.27949.paul.moore@hp.com> <4BB24D59.201@redhat.com> <201003301522.27896.paul.moore@hp.com>
In-Reply-To: <201003301522.27896.paul.moore@hp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/30/2010 03:22 PM, Paul Moore wrote:
> On Tuesday 30 March 2010 03:13:29 pm Daniel J Walsh wrote:
>    
>> On 03/30/2010 02:56 PM, Paul Moore wrote:
>>      
>>> On Tuesday 30 March 2010 02:39:05 pm Paul Moore wrote:
>>>        
>>>> On Tuesday 30 March 2010 02:23:33 pm Daniel J Walsh wrote:
>>>>          
>>>>> On 03/30/2010 02:20 PM, Eric Paris wrote:
>>>>>            
>>>>>> On Tue, 2010-03-30 at 14:07 -0400, Paul Moore wrote:
>>>>>>              
>>>>>>> On Tuesday 30 March 2010 10:45:33 am Daniel J Walsh wrote:
>>>>>>>                
>>>>>>>> Paul you are suggesting that I write a MLS rule that says
>>>>>>>>
>>>>>>>> svirt_t:ANYLEVEL can talk to svirt_t:ANYLEVEL over unix domain
>>>>>>>> sockets.
>>>>>>>>
>>>>>>>> Which would allow
>>>>>>>>
>>>>>>>> svirt_t:s0 to talk to svirt_t:s1  Which seems very broken to me.
>>>>>>>>                  
>>>>>>> Well, based on the domains that were reported earlier in the thread
>>>>>>> ...
>>>>>>>
>>>>>>>                
>>>>>>>> # ps -eZ | grep virt
>>>>>>>> system_u:system_r:virtd_t:s0-s15:c0.c1023 27344 ? 05:34:47 libvirtd
>>>>>>>> system_u:system_r:svirt_t:s0:c1 28549 ?        00:00:01 qemu-kvm
>>>>>>>>                  
>>>>>>> ... I think you just need to write policy that allows
>>>>>>> "virtd_t:ANYLEVEL" and "svirtd_t:ANYLEVEL" to communicate; you
>>>>>>> shouldn't need to allow "svirt_t:ANYLEVEL" to communicate with
>>>>>>> "svirt_t" since only qemu-kvm is running as "svirt_t" and you are
>>>>>>> trying to get qemu-kvm and libvirtd to talk.
>>>>>>>                
>>>>>> The QEMU/KVM "server child socket" gets labeled
>>>>>> svirt_t:s0-s15:c0-c1023 (type of svirt_t and level of the peer,
>>>>>> libvirtd_t)   So svirt_t needs to talk to svirt_t.  That's the whole
>>>>>> issue.....
>>>>>>
>>>>>> -Eric
>>>>>>              
>>>>> Yes letting svirt_t:level1 talk to libvirt_t:RangecontinaingLevel1 is
>>>>> easy
>>>>>
>>>>> allowing svirt_t:level1 talk to svirt_t:RangecontainingLevel1 is the
>>>>> problem Since I end up allowing all svirt_t to talk to all svirt_t, No
>>>>> MLS controls at all.
>>>>>            
>>>> Maybe I'm just not thinking straight right now but if QEMU creates the
>>>> server socket, the server's parent socket should be labeled
>>>> svirt_t:s0:c1.
>>>>
>>>>    When libvirtd tries to connect its client socket should be labeled
>>>>
>>>> virtd_t:s0- s15:c0.c1023 and the resulting server child socket should be
>>>> labeled svirt_t:s0:c1 ... ah, okay, nevermind, I'm stupid.  I'm thinking
>>>> along the lines of per-socket/message access controls, e.g.
>>>> selinux_sock_rcv_skb(), which don't apply here, it is all
>>>> socket-to-socket controls.
>>>>
>>>> It would seem to me that the best near term option is to fix the UNIX
>>>> domain socket as discussed previously (I'm half-done with that, got
>>>> sidetracked by this discussion as some RCU fixes) and add
>>>> setsockcreatecon() support for UNIX domain sockets (not sure why we
>>>> don't support that now).  With that in place, libvirtd would do a
>>>> setsockcreatecon(self:QEMU_MLS_LABEL) before it connected to the QEMU
>>>> instance then the QEMU child socket would be labeled correctly and
>>>> everyone should be happy.  I think it also makes sense given that
>>>> libvirtd is running syslo-syshi and the QEMU instances are running with
>>>> very specific MLS labels.
>>>>          
>>> Nevermind again, looking at the code it does look like setsockcreatecon()
>>> should work for UNIX domain sockets in the current code base ... anyway,
>>> I'd still go with the setsockcreatecon() approach.  I'll work on getting
>>> an RFC class UNIX socket patch out today.
>>>        
>> With that change both ends of the socket would be
>>
>> svirt_t:level1 and svirt_t:level1
>>
>> or
>>
>> virtd_t:level1 and svirt_t:level1
>>      
> I believe that you should see the following:
>
>   QEMU: svirt_t:s0:c1 (parent socket) and svirt_t:s0:c1 (child socket)
>
>   libvirtd: virtd_t:s0:c1 (client socket)
>
>    
libvirt would have to execute

setsockcreatecon("system_u:system_r:svirt_t:s0:c1")
Then connect to the socket?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
