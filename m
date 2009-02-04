Message-ID: <4989EC70.7070900@MagitekLtd.com>
Date: Wed, 04 Feb 2009 11:28:48 -0800
From: "James W. Hoeft" <Jim@MagitekLtd.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: odd policy behavior
References: <cadfc0e40902030828v41f836eag84d5aaa0fa7bb899@mail.gmail.com> <1233679082.14235.21.camel@localhost.localdomain> <cadfc0e40902031159r55a12a02u46b0dde8f9356460@mail.gmail.com> <1233696489.14235.28.camel@localhost.localdomain> <cadfc0e40902031349w3c4d3abdgb5c7f5b5107a4001@mail.gmail.com> <cadfc0e40902031431w5532857fq2ecfd9485dfb26ee@mail.gmail.com> <1233755713.30244.7.camel@localhost.localdomain> <4989BE58.60408@redhat.com> <1233764068.30244.23.camel@localhost.localdomain> <11BA0B47-26B4-42D9-8511-1BCD38FFBE4B@nall.com>
In-Reply-To: <11BA0B47-26B4-42D9-8511-1BCD38FFBE4B@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Joe Nall wrote:
>
> On Feb 4, 2009, at 10:14 AM, Stephen Smalley wrote:
>
>> On Wed, 2009-02-04 at 11:12 -0500, Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Stephen Smalley wrote:
>>>> On Tue, 2009-02-03 at 16:31 -0600, Xavier Toth wrote:
>>>>> On Tue, Feb 3, 2009 at 3:49 PM, Xavier Toth <txtoth@gmail.com> wrote:
>>>>>> On Tue, Feb 3, 2009 at 3:28 PM, Stephen Smalley 
>>>>>> <sds@tycho.nsa.gov> wrote:
>>>>>>> On Tue, 2009-02-03 at 13:59 -0600, Xavier Toth wrote:
>>>>>>>> On Tue, Feb 3, 2009 at 10:38 AM, Stephen Smalley 
>>>>>>>> <sds@tycho.nsa.gov> wrote:
>>>>>>>>> On Tue, 2009-02-03 at 10:28 -0600, Xavier Toth wrote:
>>>>>>>>>> I have an app that wasn't working in enforcing but there are 
>>>>>>>>>> no AVCs.
>>>>>>>>>> So I did 'semodule -DB' to see if there were any dontaudit 
>>>>>>>>>> denials and
>>>>>>>>>> restarted the app. The problem is that the app then ran fine. 
>>>>>>>>>> So I
>>>>>>>>>> tried load_policy which had no affect and 'semodule -B' which 
>>>>>>>>>> makes it
>>>>>>>>>> work. Any ideas what could be happening? I've verified with 
>>>>>>>>>> 'semodule
>>>>>>>>>> --list' that the module is loaded prior to doing the 
>>>>>>>>>> 'semodule -B'.
>>>>>>>>> - How was the app failing?
>>>>>>>> This is our security banner app that draw a window across the 
>>>>>>>> top of
>>>>>>>> the screen with the users MLS range and with the appropriate
>>>>>>>> background color. When it fails there is just a window with a gray
>>>>>>>> background no text or color.
>>>>>>>>
>>>>>>>>> - Did you try running the app in permissive as well?
>>>>>>>>> - Is this reproducible at all or are you unable to reproduce the
>>>>>>>>> application failure now under any conditions?
>>>>>>>>> - Did the app create/use any transient resources (temporary 
>>>>>>>>> files,
>>>>>>>>> system v ipc objects, etc) that could have prevented it from 
>>>>>>>>> succeeding
>>>>>>>>> on subsequent execution if they weren't properly cleaned up on 
>>>>>>>>> prior
>>>>>>>>> exit?
>>>>>>>> After further investigation I found that a call to 
>>>>>>>> getseuserbyname for
>>>>>>>> the login user is returning the user name passed in and nothing 
>>>>>>>> for
>>>>>>>> the range which would be used in the banner. During our 
>>>>>>>> installation
>>>>>>>> we don't explicitly map this user to a SELinux user but our 
>>>>>>>> experience
>>>>>>>> has been that the when there is no mapping the user and range 
>>>>>>>> of the
>>>>>>>> '__default__' login are returned. Indeed once I rebuild policy 
>>>>>>>> this
>>>>>>>> appears to be what is happening. How rebuilding and reloading 
>>>>>>>> policy
>>>>>>>> would affect this is unclear.
>>>>>>> If the installed seusers file (i.e. 
>>>>>>> /etc/selinux/$SELINUXTYPE/seusers)
>>>>>>> did not exist originally or was unreadable (e.g. wrong context 
>>>>>>> or mode),
>>>>>>> then getseuserbyname() would behave the way you described.  
>>>>>>> Rebuilding
>>>>>>> policy would have caused the regenerated seusers file to be 
>>>>>>> installed,
>>>>>>> possibly with different context or mode than the original state.
>>>>>>>
>>>>>>> -- 
>>>>>>> Stephen Smalley
>>>>>>> National Security Agency
>>>>>>>
>>>>>>>
>>>>>> You nailed it for some reason seusers is SystemHigh. Still
>>>>>> investigating ... Thanks
>>>>>>
>>>>>> Ted
>>>>>>
>>>>> The plot thickens. semodule -B causes seusers to be relabeled
>>>>> SystemLow. restorecon /etc/selinux/mls/seusers causes the file to be
>>>>> relabeled SystemHigh. Which is right?
>>>>
>>>> I don't think that semodule/libsemanage explicitly set the context of
>>>> files they create, so they would just follow the default policy 
>>>> behavior
>>>> (in this case, inheriting the level of the creating process and the 
>>>> type
>>>> of the parent directory).
>>>>
>>>> restorecon just applies whatever the file_contexts configuration
>>>> specifies, which appears to be SystemHigh in the mls policy.  I'm not
>>>> sure if that is truly justified.
>>>>
>>> Since all the login programs have to read this file it should be at the
>>> SystemLow, So that a login program running at a SystemLow can work.
>>
>> Makes sense to me, but I assume that someone thought otherwise or it
>> wouldn't have been marked as SystemHigh in the first place?  Does the
>> LSPP impose a particular restriction on it?  There are
>> other /etc/selinux files in file_contexts as well that are marked with
>> SystemHigh (or to be precise, s15:c0.c1023) in the -mls policy.
>
>
> Here is the original rationale:
>
>> From: Darrel Goeddel ...
>> The theory is that these files can contain the lables up to 
>> systemhigh.  The
>> mere existence of the label is classified just like data having that 
>> label.
>> Since the seusers file contains the clearances, those labels need to be
>> protected with the appropriate labels (ain't that fun...).  This is same
>> reason that the label translation daemon will not translate things for
>> you if you are not cleared to know about the translation.  We are trying
>> to prevent someone who is cleared at secret (let's say s7) to be able
>> to read the seusers file and find out that the label (s10:c0-c100) is in
>> use on the system, possibly indicating that the machine is a 
>> higher-value
>> target.
>
> I think this over classifies the file. Since the contexts are raw, I 
> don't see a reason for seusers to be SystemHigh. I'll ask our 
> accreditors, but the answer will not be swiftly forthcoming.
>
> WRT the other files, setrans.conf should be SystemHigh because there 
> is sensitivity to category names in some communities.
>
> joe
>
Short answer (with concurrence from our certifier rep - program Joe and 
Ted are working) is the file should not be classified. Raw contexts 
themselves do not mean much - translating them into actual clearances is 
the part that needs to be protected (i.e., an unauthorized user/process 
determining there is s8:c134 data on a system does not mean much; 
however, for them to be able to determine there is 
"confidential:specialcodeword" data could be an issue).

Jim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
