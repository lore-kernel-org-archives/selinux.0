Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BMT2EJ009558
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 18:29:02 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5BMT1cw013206
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 22:29:01 GMT
Received: by an-out-0708.google.com with SMTP id d30so802741and.75
        for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 15:29:01 -0700 (PDT)
Message-ID: <4850518E.8030508@gmail.com>
Date: Wed, 11 Jun 2008 18:28:30 -0400
From: max <maximilianbianco@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: SELinux References/Books
References: <48502D42.4030905@gmail.com> <1213217350.17842.140.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213217350.17842.140.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2008-06-11 at 15:53 -0400, max wrote:
>> I would prefer to get a desktop reference rather than having to refer 
>> to online documents or the hardcopies of individual papers I have 
>> printed off, many of which are also dated. In any case I feel like I 
>> have learned enough that I can open a book on the subject of SELinux and 
>> not get completely lost. It looks like I have basically two options :
>>
>> SELinux by Example: Using Security Enhanced Linux (Prentice Hall Open 
>> Source Software Development Series) by Frank Mayer, Karl MacMillan, and 
>> David Caplan (Paperback - Aug 6, 2006)
>>
>> SELinux: NSA's Open Source Security Enhanced Linux by Bill McCarty 
>> (Paperback - Oct 11, 2004) - Illustrated
>>
>> The first is more recent so I am leaning that way but I have seen 
>> opinions that suggest even it is way out of date. I don't mind spending 
>> money on a good book, reading is one of my favorite past times, but I 
>> don't want anything so dated that it won't serve as a decent reference 
>> for the near future (next year or so). I understand nothing is going to 
>> be up to the minute.  Should I purchase one? or are they too out of date 
>> to even serve as good references? This is definitely something I am 
>> interested in learning about or I wouldn't bother to ask. Suggestions 
>> and advice from all corners of reality welcome.
> 
> What kind of information are you looking for?
>
> The first, more recent, book includes discussion of reference policy and
> policy modules and thus is relatively consistent with what you find in
> modern SELinux, although newer developments like system-config-selinux,
> setroubleshoot, etc naturally don't appear in it.  It was written during
> the development of Fedora Core 5, which marked the transition of SELinux
> from the old way (example policy, monolithic policy) to the new way
> (reference policy, modular policy, semanage).
> 

Well I'd like to learn it all but I think a practical approach would 
mean learning to write policy first, since that is a skill I could put 
to use now. I don't expect it will be easy but that's ok, I have some 
time right now and I'd like to learn the policy language. If the first 
book covers this then I will get it. Is there a better reference for 
aspiring policy writers? I don't care about the gui tools so much, not 
that they aren't useful but I prefer to do most things myself and not 
automate it since this brings me less understanding.

-- 
An unwillingness to embarrass oneself makes learning more difficult

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
