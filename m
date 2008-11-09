Cc: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Warner <warner@rubix.com>, selinux@tycho.nsa.gov
Message-Id: <354D5A91-3C3C-4AFC-8062-72382AFD55BE@nall.com>
From: Joe Nall <joe@nall.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <490F6059.3010106@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Label Translation on Fedora 9
Date: Sun, 9 Nov 2008 12:26:58 -0600
References: <490EE548.60400@rubix.com> <490F00E1.4050704@rubix.com> <1225720309.3609.24.camel@moss-spartans.epoch.ncsc.mil> <200811031129.58700.paul.moore@hp.com> <490F6059.3010106@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Nov 3, 2008, at 2:34 PM, Daniel J Walsh wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Paul Moore wrote:
>> On Monday 03 November 2008 8:51:49 am Stephen Smalley wrote:
>>> On Mon, 2008-11-03 at 14:47 +0100, Andy Warner wrote:
>>>> Stephen Smalley wrote:
>>>>> On Mon, 2008-11-03 at 12:49 +0100, Andy Warner wrote:
>>>>>> I am running Fedora 9 with the MLS policy and see no evidence
>>>>>> that the label translation is enabled. I am using the default
>>>>>> setrans.conf and the "disable=1" flag is commented out.
>>>>>>
>>>>>> Using the selinux_trans_to_raw (e.g., with a SystemHigh level)
>>>>>> produces the exact same label string as passed in which will
>>>>>> not pass validation (using s15:c0.c1023 will pass validation).
>>>>>>
>>>>>> Trying id-Z followed by newrole produces:
>>>>>> id -Z
>>>>>> warner_u:secadm_r:secadm_t:s0-s15:c0.c1023
>>>>>>
>>>>>> newrole -l SystemLow-SystemHigh
>>>>>> warner_u:secadm_r:secadm_t:SystemLow-SystemHigh is not a valid
>>>>>> context
>>>>>>
>>>>>> Is there something that must be done to activate label
>>>>>> translation?
>>>>> Label translation is provided by a daemon, mcstrans.
>>>>>
>>>>> yum install mcstrans
>>>>> /sbin/chkconfig mcstrans on
>>>>> /sbin/service mcstrans start
>>>> Thanks. I was not starting the mcstrans service. When I get a
>>>> translation, it seems odd as follows.
>>>>
>>>> without mcstrans:
>>>> id -Z
>>>> warner_u:secadm_r:secadm_t:s0-s15:c0.c1023
>>>>
>>>> with mcstrans:
>>>> id -Z
>>>> warner_u:secadm_r:secadm_t:SystemLow:SystemLow-SystemHigh
>>>>
>>>> Is it expected to have the high end of the range expressed as a
>>>> range? The translation table has the following relevant entries:
>>>> s0                             SystemLow
>>>> s0-s15:c0.c1023      SystemLow-SystemHigh
>>> No, that looks wrong to me as well.  cc'ing Dan Walsh of Red Hat,  
>>> who
>>> maintains mcstrans.
>>>
>>> BTW, if you are looking for more complete MLS label translation
>>> support, you might try the extended mcstrans posted by Joe Nall.
>>
>> What is the status of the patch?  I vaguely remember a little bit of
>> discussion/review about the patch but it's not clear to me if it was
>> ever accepted into upstream/Fedora and if it wasn't what the next  
>> steps
>> were going to be ...
>>
> Good question, we have let this slip through the cracks.  I would like
> to replace my library totally with Joe's.  The only concern would be  
> to
> allow people who used my format to convert to the new format if  
> possible
> or at least document how to do this.

Sorry about the big delay in closure on this. We have been very busy  
trying to build a demonstrable Fedora based MLS/X system to run our  
applications on. The demo was last week in London and we have some  
time to upstream our changes this month. That includes adding  
combination constraints, label-to-color mapping and migration tools to  
mcstransd and pushing it into a public repo for community consideration.

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
