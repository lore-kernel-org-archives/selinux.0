Message-ID: <496270B3.4050405@manicmethod.com>
Date: Mon, 05 Jan 2009 15:42:27 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: semodule patch to use new semanage interfaces
References: <49145394.3050806@redhat.com> <496264FE.3000802@manicmethod.com> <49626681.5050004@redhat.com> <4962689B.6010507@manicmethod.com> <49626F43.9000702@redhat.com>
In-Reply-To: <49626F43.9000702@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Joshua Brindle wrote:
>   
>> Daniel J Walsh wrote:
>>     
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Joshua Brindle wrote:
>>>  
>>>       
>>>> Daniel J Walsh wrote:
>>>> Allows semodule to read bzip compressed policy packages directly.
>>>>     
>>>>         
>>>  
>>>       
>>>> I'm finally looking at these (sorry it took so long)..
>>>>     
>>>>         
>>>  
>>>       
>>>> I thought one part of it was suppose to make hard links to files if you
>>>> install but after merging this patch and the compression support I try
>>>> semodule -i /usr/share/selinux/targeted/somepolicy.pp.bz2 (I'm on F10
>>>> and they are already bzip'd) and instead of making a hard link to the
>>>> bz2 it looks like it writes the uncompressed file to
>>>> /etc/selinux/targeted/modules/active/modules. Am I misunderstanding the
>>>> intention of these patches?
>>>>     
>>>>         
>>> Originally this was the intention but it was wrong.  The problem is the
>>> file context would start to get screwed up every where and we end up
>>> with the /etc/selinux/targeted/modules/active/ directory looking like a
>>> patchwork of labels.
>>>
>>> So the patch makes a compressed copy whether or not the file is
>>> originally compressed in the new location.
>>>
>>> It does use the hard links for creating the snapshot directory though.
>>>
>>>   
>>>       
>> So... what is the purpose of the *_file functions if you don't copy the
>> data anymore?
>>
>> I see now that the files in /etc/selinux/.../modules/active are bzip
>> files but with a .pp extension, confusing.
>>
>>     
> Because you don't know if the file you are installing is a compressed pp
> or a regular one.
>
> I want to ship compressed pp files for now on, but existing pp files are
> not compressed.  semodule should be smart enough to not care

I see now, the *_file does the same thing semodule use to do but also 
checks if the data is a bzip.

We might want to mark those old functions as deprecated since it is 
likely they won't be able to use any policy modules shipped going forward.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
