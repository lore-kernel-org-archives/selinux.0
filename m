Message-ID: <45F03994.7060504@redhat.com>
Date: Thu, 08 Mar 2007 11:28:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Minor change to getsebool.
References: <45F035D2.9030307@redhat.com> <1173370754.10467.86.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1173370754.10467.86.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-03-08 at 11:12 -0500, Daniel J Walsh wrote:
>   
>> Should be non fatail when executing getsebool -a.  I am starting to 
>> label the booleans and
>> different user roles will only be able to manipulate certain booleans.
>>
>> So we need to change
>>
>> getsebool -a will only show booleans that domain can manipulate.
>> Currenly it will report the errrors that it can not read.  We can either 
>> add a qualifier to silence these or a new option to get only the list of 
>> the ones I can manipulate.
>>     
>
> Actually, I'd tend to think we could just silence them by default if
> errno is EACCES.
>
> One other possible change to getsebool would be to make it fully
> equivalent to setsebool, i.e. add a -P option and have it query
> libsemanage to get persistent boolean settings in that case.
>
>   
Then it needs to move from libselinux to policycoreutils.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
