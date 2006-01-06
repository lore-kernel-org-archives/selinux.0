Message-ID: <43BE8B5B.6020505@redhat.com>
Date: Fri, 06 Jan 2006 10:23:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [SEMANAGE] Validation of local file contexts
References: <43BD99A1.3070700@cornell.edu> <1136559465.16811.37.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1136559465.16811.37.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-01-05 at 17:11 -0500, Ivan Gyurdiev wrote:
>   
>> This patch adds context validation of local changes to file contexts.
>>
>> Should I also check if the regexp is valid?
>>     
>
> I'm not sure, as libsemanage presently doesn't do any other
> interpretation of the regex.  Might want to defer this to the clients.
>
>   
>> Should I check if the Unix user exists for seusers?
>>     
>
> As with the above, I'm inclined to defer this to the clients, as Unix
> users aren't something managed by libsemanage itself.
>
>   
Yes leave these to the clients.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
