Message-ID: <3C14E66E.10405@pcez.com>
Date: Mon, 10 Dec 2001 08:44:30 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: New security policy
References: <Pine.GSO.4.33.0112101028390.13300-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Sun, 9 Dec 2001, Shaun Savage wrote:
>
>>sysdm_r    this for root to admin the system but can't change security
>>of "system" types
>>secoff_r    The is for security officer to set up the security for the
>>system
>>dataoff_r    this is the only person that can "see" users personal
>>files/directories
>>
>
>You are likely to encounter difficulty in truly enforcing separation among
>these roles.  Obviously, you can't let sysadm_r update the kernel or
>its modules if you want to separate secoff_r, but even this is not
>sufficient.  For example, if you let sysadm_r update /bin/login or
>/etc/shadow, what prevents him from entering any role he wants?  Or if you
>let sysadm_r update system libraries or programs executed by the other
>roles, what prevents him from inserting arbitrary code of his choosing to
>be executed by the other roles?  I'm not sure about dataoff_r - what
>constitutes "personal" files/directories.  Obviously, if dataoff_r can
>read a user's private keys, then he can obtain access to the user's
>account and thus may be able to enter the other roles.
>

The sysadm_r is see as the every day admin.  checking logs, add/del 
users,accounts using system-tools.
But the secoff_r locks down system. if the secoff_r unlocks the system 
then sysadm_r can then a administrator the whole system.  The reason I 
like this is that an unknow root exploit can't comprimise the whole system.

The dataoff_r is a trusted user that is allowed to move user data from 
one domain to another, reclassify  data. This is a violation of the 
rules, but that is the role.

>
>>I have compiled some of the selinux utils for RH7.2, I hope to do the
>>rest this week.
>>
>
>As I've mentioned previously on the list
>(http://marc.theaimsgroup.com/?l=selinux&m=100687390219347&w=2), we've
>been working on updating the utility patches to RH7.2 and have updated
>several of them already, so it seems that there is some duplication of
>work here.
>
Where can I get the work that has been done already?



Shaun Savage




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
