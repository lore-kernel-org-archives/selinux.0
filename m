Message-ID: <494BFEE1.2060809@gmail.com>
Date: Fri, 19 Dec 2008 12:06:57 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: ath9k capability=16 won't compile into policy
References: <dd18b0c30812161426l678b4bcx104efd63797c162d@mail.gmail.com> <1229518746.31499.1.camel@localhost.localdomain>
In-Reply-To: <1229518746.31499.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2008-12-16 at 14:26 -0800, Justin Mattock wrote:
>   
>> I'm not too sure if I should post this with SELinux,
>> refpolicy, or kernel.org,(or even wpasupplicant);
>>  so I decided to do all to the best of my knowledge.
>> when using the ath9k module with the latest git
>> kernel(or atleast a few days old); and the latest refpolicy (svn)
>> I'm seeing this avc denial show up:
>>
>> Dec 16 12:33:32 name kernel: [   20.415785] type=1400
>> audit(1229459612.411:3): avc:  denied  { sys_module } for  pid=2510
>> comm="wpa_supplicant" capability=16
>> scontext=system_u:system_r:system_dbusd_t:s0
>> tcontext=system_u:system_r:system_dbusd_t:s0 tclass=capability
>> Dec 16 12:33:32 name kernel: [   20.428494] type=1300
>> audit(1229459612.411:3): arch=40000003 syscall=54 success=no exit=-19
>> a0=9 a1=8933 a2=bfadd94c a3=bfadd94c items=0 ppid=1 pid=2510
>> auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
>> fsgid=0 tty=(none) ses=4294967295 comm="wpa_supplicant"
>> exe="/sbin/wpa_supplicant" subj=system_u:system_r:system_dbusd_t:s0
>> key=(null)
>>
>> the allow rule is:(with ath9k module)
>> allow system_dbusd_t self:capability sys_module;
>> which in turn will be rejected by checkpolicy
>> (capability 16)
>> when compiling the policy.
>>
>> If I use the madwifi module the avc is similar but produces
>> allow system_dbusd_t self:capability { sys_admin }
>> (capability 12)
>> and will be accepted by checkpolicy.
>>
>> As for setup I'm using NetworkManager from
>> intrepid as well as wpasupplicant
>>
>> Any info would be appreciated so I can test this module out
>> and feel better knowing the module is not being denied in any
>> way, that might cause a false positive, or some other weirdness.
>>     
>
> You didn't list the particular error message from checkpolicy, but I
> would guess that it is a neverallow failure.  You should be using an
> appropriate refpolicy interface to allow sys_module rather than directly
> doing it.  However, in this case, the real problem is that dbusd did not
> transition to a separate domain for wpa supplicant when it was launched.
> You don't want dbusd itself to be able to insert modules.
>
>   
Well, after loosing my patience with this,
I think I'm going to give up.
(but then again,I won't be able to sleep at night!!)
I think I'm dealing with something missing with
NetworkManager i.g. When using the "keyfile"
plugin
 it's as simple as creating a file with
you're network info and putting it in network-settings/"name"
then once NetworkManager start's, it reads that file
and viola up and running.(and hopefully  put's  NetworkManager in the right
transition etc..)
Unfortunately  I keep getting  a dead  reaction  when  using  this  
approach.
 NetworkManager: <info>  (wlan0): device state change: 1 -> 2 
 NetworkManager: <info>  (wlan0): bringing up device.
 NetworkManager: <info>  (wlan0): preparing device.
 NetworkManager: <info>  (wlan0): deactivating device (reason: 2). 

then:

 kernel: [   20.331143] type=1400 audit(1229715518.330:5): avc:  denied  
{ sys_module } for  pid=2457 comm="wpa_supplicant" capability=16 
scontext=system_u:system_r:system_dbusd_t:s0 
tcontext=system_u:system_r:system_dbusd_t:s0 tclass=capability


is triggered.

I think with redhat there is the
plugin ifcfg-rh which is similar to
what keyfile does.
Anyways thanks for the info on this.
I'll post anything if something comes up.

regards;

Justin P. Mattock








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
