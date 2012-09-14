Message-ID: <50535F78.3070003@tresys.com>
Date: Fri, 14 Sep 2012 12:46:48 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Add initial clipboard access control implementation
References: <1347636256-4457-1-git-send-email-jbrindle@tresys.com> <1347640545.11029.63.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1347640545.11029.63.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2012-09-14 at 11:24 -0400, Joshua Brindle wrote:
>> This is an RFC for clipboard access controls in Android. I still need to do non-SELinux system guards and check for permission when onPrimaryClipChanged() sends notifications to apps listening for clipboard updates.
>>
>> Change-Id: Ib0b6aeca59511ce71832aee1afd4150d1514a63c
>> ---
>>   .../java/com/android/server/ClipboardService.java  |   25 ++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>
> Do you have a functioning policy for these controls (i.e. one that
> allows normal operation but prevents something bad from happening)?
>

Sort of. My policy is pretty hacked up because the only way this is 
useful is if you have multiple, separate app domains, which the 
appdomain attribute does a good job of not easily allowing without 
duplicating all the rules.

To make devices behave as normal we just need:

allow appdomain appdomain : x_application_data paste;

in app.te, but that won't prevent pasting ever, someone who wants to use 
this will have to make a new domain that isn't in the appdomain 
attribute and copy all the rules.

On my todo list is to move all the appdomain rules to an interface so 
that I can create new domains without access to each other but that 
hasn't happened yet.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
