Message-ID: <41F91ABF.5040101@redhat.com>
Date: Thu, 27 Jan 2005 11:45:51 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Updated policy
References: <41F6A47E.9010407@redhat.com> <1106841450.28623.132.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1106841450.28623.132.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-01-25 at 14:56, Daniel J Walsh wrote:
>  
>
>>Fixes for targeted crond to run as unconfined and still have transitions 
>>work.
>>    
>>
>
>I'm a little unclear on the current direction of the targeted policy.  I
>see that you are putting more programs like login and crond into
>domains, but then adding unconfined_domain() to them and allowing them
>to transition to unconfined_t.  What is the purpose of such domains?
>
>As a side note, do you truly want crond to run directly in
>system_crond_t (normally only used for system cron jobs in the strict
>policy, vs. crond_t for the daemon itself).
>
>  
>
The direction of targeted policy is to attempt to lock down all of the 
network daemons.  The remote login ones
are prooving difficult  since they have to eventually transition to 
unconfined_t.  So the problem we were having without
telnetd, rshd, rlogind policy these daemons were running as 
inetd_child_t and not working properly so we started to add
policy.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
