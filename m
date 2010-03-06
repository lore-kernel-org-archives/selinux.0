Message-ID: <4B92E18D.2090305@manicmethod.com>
Date: Sat, 06 Mar 2010 18:13:17 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: updated libselinux pkgconfig does not work correctly on lib64
 machines.
References: <4B857CDE.7010303@redhat.com> <4B857F6B.7050503@redhat.com> <4B872798.4010702@manicmethod.com> <4B880E8D.5070602@tycho.nsa.gov> <4B8825C2.3030107@redhat.com> <4B882E69.7070407@tycho.nsa.gov>
In-Reply-To: <4B882E69.7070407@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Eamon Walsh wrote:
> On 02/26/2010 02:49 PM, Daniel J Walsh wrote:
>> On 02/26/2010 01:10 PM, Eamon Walsh wrote:
>>
>>> On 02/25/2010 08:44 PM, Joshua Brindle wrote:
>>>
>>>
>>>> Daniel J Walsh wrote:
>>>>
>>>>
>>>>
>>>>> On 02/24/2010 02:24 PM, Daniel J Walsh wrote:
>>>>> Ignore the first patch it was missing pc.in files.
>>>>>
>>>>>
>>>>>
>>>> I am completely new to libtool. Does this seem reasonable Eamon?
>>>>
>>>>
>>>>
>>> I don't see any reference to "lib64" anywhere in our Makefiles even with
>>> the patch.  We have "lib" hard-coded, and I just checked a 64-bit
>>> machine and our stuff is in /usr/lib instead of /usr/lib64.  Is that
>>> what this patch is trying to solve?
>>>
>>>
>>>
>>>
>> Yes
>>
>> If you execute
>>
>> make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
>>
>> It should do the right thing with the patch.
>>
>> This is what the spec file hands in.
>>
>
> OK, that makes sense.
>
> The patch contains a stray line involving adding -fPIC to CFLAGS.  I
> don't think that was meant to be part of this patch.
>
> Otherwise,
>
> Acked-by: Eamon Walsh<ewalsh@tycho.nsa.gov>
>
>

Merged in libselinux 2.0.92

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
