Message-ID: <4BABA4C7.2020409@redhat.com>
Date: Thu, 25 Mar 2010 14:00:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: svirt on MLS has strange AVC.
References: <4BA7E4BF.1040002@redhat.com> <1269484959.2925.9.camel@dhcp235-240.rdu.redhat.com> <1269525768.1031.9.camel@moss-pluto.epoch.ncsc.mil> <201003251249.48641.paul.moore@hp.com>
In-Reply-To: <201003251249.48641.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/25/2010 12:49 PM, Paul Moore wrote:
> On Thursday 25 March 2010 10:02:48 am Stephen Smalley wrote:
>    
>> On Wed, 2010-03-24 at 22:42 -0400, Eric Paris wrote:
>>      
>>> On Tue, 2010-03-23 at 11:44 +0000, Daniel P. Berrange wrote:
>>>        
>>>> On Tue, Mar 23, 2010 at 07:35:13AM -0400, Daniel J Walsh wrote:
>>>>          
>>>>> On 03/22/2010 07:47 PM, Eric Paris wrote:
>>>>>            
>>>>>> On Mon, 2010-03-22 at 17:44 -0400, Daniel J Walsh wrote:
>>>>>>              
>>>>>>> type=AVC msg=audit(1269293509.223:4753): avc:  denied  { write }
>>>>>>> for pid=28549 comm="qemu-kvm" path="socket:[4417531]" dev=sockfs
>>>>>>> ino=4417531 scontext=system_u:system_r:svirt_t:s0:c1
>>>>>>> tcontext=system_u:system_r:svirt_t:s0-s15:c0.c1023
>>>>>>> tclass=unix_stream_socket
>>>>>>>
>>>>>>> I have Static Virtualization working on an MLS box except for this
>>>>>>> strange AVC.
>>>>>>>                
> ..
>
>    
>>>>>>> # ps -eZ | grep virt
>>>>>>> system_u:system_r:virtd_t:s0-s15:c0.c1023 27344 ? 05:34:47 libvirtd
>>>>>>> system_u:system_r:svirt_t:s0:c1 28549 ?        00:00:01 qemu-kvm
>>>>>>>                
> ..
>
>    
>>>>>>> # ls -lZ /proc/28549/fd/ | grep 4417531
>>>>>>> lrwx------. qemu qemu system_u:system_r:svirt_t:s0:c1  17 ->
>>>>>>> socket:[4417531]
>>>>>>>
>>>>>>>    lsof | grep 4417531
>>>>>>>
>>>>>>> qemu-kvm  28549      qemu   17u     unix 0xffff88003e1f7900
>>>>>>> 0t0 4417531 /var/lib/libvirt/qemu/xguest.monitor
>>>>>>>
>>>>>>> # lsof /var/lib/libvirt/qemu/xguest.monitor
>>>>>>> COMMAND    PID USER   FD   TYPE             DEVICE SIZE/OFF    NODE
>>>>>>> NAME qemu-kvm 28549 qemu    3u  unix 0xffff88003a853000      0t0
>>>>>>> 4417518 /var/lib/libvirt/qemu/xguest.monitor
>>>>>>> qemu-kvm 28549 qemu   17u  unix 0xffff88003e1f7900      0t0 4417531
>>>>>>> /var/lib/libvirt/qemu/xguest.monitor
>>>>>>>
>>>>>>> So it looks like we have a process that is running as both labels?
>>>>>>>                
>>>>>> This is a check between the type of the process and that of the
>>>>>> socket itself, not between 2 processes.  So, the type of the socket
>>>>>> is wrong. Just as a question, what does ls -lZ
>>>>>> /var/lib/libvirt/qemu/ show? c0-c1023 for xguest.monitor?  What
>>>>>> created that socket?  Did they get it correct?  (I admit it looks
>>>>>> correct on my F13ish system)
>>>>>>              
>>>>> The socket file is labeled svirt_var_run_t and has the correct level.
>>>>>
>>>>> I believe the socket file was created by qemu.  Dan can you confirm
>>>>> this.
>>>>>            
>>>> Yes, these sockets are created by QEMU when it starts. libvirt just
>>>> gives it the path at which to create the socket.
>>>>
>>>>          
>>>>>   # ls -lZa /var/lib/libvirt/qemu/
>>>>>
>>>>> drwx------. qemu qemu
>>>>> system_u:object_r:svirt_var_run_t:s0-s15:c0.c1023 . drwxr-xr-x. root
>>>>> root system_u:object_r:virt_var_lib_t:s0 .. srwxr-xr-x. qemu qemu
>>>>> system_u:object_r:svirt_var_run_t:s0:c1 xguest.monitor
>>>>>            
>>> And then libvirt attaches to the other end?
>>>
>>> In any case, doing some digging the problem (where we first end up with
>>> this crazy context with the type of svirt_t but the MLS label of
>>> libvirt) is in selinux_socket_unix_stream_connect().  We never saw this
>>> in MCS because we don't have constraints on unix domain sockets in
>>> targetted/MCS policy.  At this hour of the night my brain isn't running
>>> well enough nor is my networking foo strong enough to understand exactly
>>> which object is supposed to be labeled what where, but it has to be
>>> something with the call to security_sid_mls_copy().
>>>
>>> I'll certainly be looking at this again in the morning.
>>>        
>> That's intentional behavior for MLS.
>>      
> Stephen is correct, the general idea is that when a connected child socket is
> created on a socket accepting incoming connections it is labeled using the
> type of the listening socket and the MLS attributes of the remote peer.  As an
> example, imagine client client_t:s0:c1 connecting to server server_t:s0-
> s15:c0.c1023, the client's connected socket would be labeled client_t:s0:c1
> (it inherits the label from the client process) while the server's connected
> child socket would be labeled server_t:s0:c1 (labeled as described above).
>
> Now, while the code (looking at Linus' current tree, but this hasn't changed
> in a while) it does handle labeling UNIX sockets correctly but there are a few
> things which strike me as odd, if not wrong:
>
> 1. The "peer_sid" field of the client's socket is set to the label of the
> server's listening socket, NOT the derived label used for the server's child
> socket.  This means that the MLS attributes of the "peer_sid" stored in the
> client's socket do not match the MLS attributes of the server's child socket.
> This isn't consistent with how we handle INET sockets, but then again with
> UNIX sockets we know the labels of both the remote socket and the remote peer;
> with INET sockets we only get one label.  In some ways this gets back to the
> socket as an endpoint argument and I'm not sure we want to dig that up.
>
> 2. We don't currently update the server's child socket inode label to reflect
> the derived label used in the socket.  A potential difference between INET and
> UNIX socket handling if security_sock_graft() is not called at some point in
> the connect process (need to track this down, but it didn't jump out at me in
> unix_stream_connect()).
>
> 3. Somewhat unrelated I think, but selinux_socket_unix_may_send() doesn't use
> the socket/sock labels, it relies on the inode labels.  As has been mentioned
> several times in the past, we need to unify the inode/sock labels better.
>
> There may be more issues, but these are the ones that caught my eye when
> scanning the UNIX socket code quickly.  Item #1 is probably only an annoyance
> that you would see in getpeercon() but we should still probably fix.  Item's
> #2 and #3 are potentially a bit more serious as the file descriptor access
> controls are going to use the inode's label so a mis-match between the socket
> and inode labels could cause some rather strange behavior.  I can go through
> and cleanup this code (it is long overdue), but I want to get some consensus
> first on how we want UNIX sockets to behave.
>
>    
Ok, my head is going to explode.

A process labeled svirt_t:s0:c1 creates a unix_stream_socket labeled in 
a sock_file labeled svirt_image_t:s0:c1 and then attempts to connect to  
it.  And on one end of it is a process labeled svirt_t:s0:c1 and the 
other is svirt_t:s0-s15:c0.c1023.  This process does not exist, looking 
at the connection, both ends are the same process.  THIS IS A BUG.  
something is wrong here.

Both ends of the socket should be svirt_t:s0:c1.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
