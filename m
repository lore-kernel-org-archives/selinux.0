Message-ID: <462F5A3D.80109@redhat.com>
Date: Wed, 25 Apr 2007 09:40:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ted X Toth <txtoth@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: adding to selinux.py
References: <462CAF84.20708@gmail.com> <1177337371.24282.8.camel@moss-spartans.epoch.ncsc.mil> <462E6ADC.7010802@gmail.com>
In-Reply-To: <462E6ADC.7010802@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ted X Toth wrote:
> Stephen Smalley wrote:
>> On Mon, 2007-04-23 at 08:07 -0500, Ted X Toth wrote:
>>  
>>> Would it be possible to get get_ordered_context_list and 
>>> get_default_context* added to selinux.py?
>>>     
>>
>> selinux.py is generated via swig, so you'd actually want to modify
>> selinuxswig.i and regenerate it.   And I think selinuxswig.i should be
>> reworked and split along the lines of semanageswig.i and
>> semanageswig_python.i over in libsemanage.
>>
>>   
> Is this something that I should look at doing or will Dan be doing it? 
> Should I open a bug report?
>
> Ted
You can open a bug report, and as always patches welcome.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
