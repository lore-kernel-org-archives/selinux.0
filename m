Message-ID: <47ACECB1.70103@tycho.nsa.gov>
Date: Fri, 08 Feb 2008 18:58:41 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, Xavier Toth <txtoth@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: make mls_compute_sid always polyinstantiate
References: <4798F57C.8090300@tycho.nsa.gov>	 <cadfc0e40802050952p519dae9co7ecec84bb67231dd@mail.gmail.com>	 <1202244504.27371.105.camel@moss-spartans.epoch.ncsc.mil>	 <Xine.LNX.4.64.0802060934570.10987@us.intercode.com.au>	 <1202309389.27371.140.camel@moss-spartans.epoch.ncsc.mil> <1202502358.27371.413.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1202502358.27371.413.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2008-02-06 at 09:49 -0500, Stephen Smalley wrote:
>   
>> On Wed, 2008-02-06 at 09:35 +1100, James Morris wrote:
>>     
>>> On Tue, 5 Feb 2008, Stephen Smalley wrote:
>>>
>>>       
>>>> On Tue, 2008-02-05 at 11:52 -0600, Xavier Toth wrote:
>>>>         
>>>>> Is this in rawhide, if not when will it be?
>>>>>           
>>>> Not up to us, obviously.  The patch is in Linus' git tree, but looks
>>>> like latest fedora devel kernel is frozen on 2.6.24 + specific
>>>> individual patches, not feeding from Linus' git presently.  James could
>>>> possibly ask the Fedora kernel maintainer about adding it - it is small,
>>>> self-contained, and has no side effects on existing code (nothing prior
>>>> to XSELinux uses the compute member support; pam_namespace usage was
>>>> disabled since it didn't work right for multi-level dirs).
>>>>         
>>> The rawhide kernel usually tracks Linus pretty closely -- perhaps wait a 
>>> couple of days until people recover from LCA.
>>>       
>> Looks like they froze it on 2.6.24 (kernel.spec has released_kernel 1,
>> gitrev 0 in Fedora devel CVS), and are only cherry picking individual
>> patches, like the /proc/net fix for SELinux.  Unless that was only for
>> the Fedora 9 Alpha release and they'll re-open the flood gates soon?
>>
>> If they don't start pulling from git again soon, we should likely take
>> the specific patch to fedora kernel list.
>>     
>
> Latest rawhide kernel pulled in 2.6.24.1-rc1, so they seem to be
> stabilizing on 2.6.24.x rather than pulling from git again for Fedora 9.
> Which means we'll have to get the patch added explicitly if we want it
> in Fedora 9.  Likely requires posting of the patch to fedora kernel
> list.
>   

Please do get this pulled in if you can.  Although, with the ongoing 
schedule slip in the X server, I'm wondering if Fedora 9 is even going 
to be able to ship a 1.4.1 point release, much less a 1.5 server that 
would include my stuff.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
