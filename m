Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UE98Ns028697
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 10:09:09 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UE3NDY005396
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 14:03:24 GMT
Message-ID: <433D45A3.9030705@redhat.com>
Date: Fri, 30 Sep 2005 10:03:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: postfix.te
References: <200509301520.42488.russell@coker.com.au> <433D2520.90500@redhat.com> <200509302216.47786.russell@coker.com.au>
In-Reply-To: <200509302216.47786.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Friday 30 September 2005 21:44, Daniel J Walsh <dwalsh@redhat.com> wrote:
>   
>>> The above was added within the distro_redhat section.  Do we have a plan
>>> to change the way the aliases file is managed in FC5 or RHEL5?
>>> Currently /etc/aliases is read the /etc/postfix/aliases.db is produced as
>>> a result.  So the above line is not needed (and grants postfix_master_t
>>> write access to etc_t:dir which is not desired).
>>>       
>> Not on the machine I was looking at (rawhide), /etc/aliases.db was being
>> created.
>>     
>
> OK, it looks like the default configuration of the Postfix package has been 
> made more similar to other distributions such as Debian in this regard.
>
>   
>>> dontaudit postfix_smtpd_t { home_root_t boot_t }:dir getattr;
>>>
>>> The above line is added in the section with a comment referring to
>>> prng_exch. Why is that access needed and what does it have to do with
>>> prng_exch?
>>>       
>> Because postfix_smtpd_t is trying to getattr on everying thing in / is
>> my guess.
>>     
>
> Why would it be doing that?  For so long it's been not doing so on so many 
> machines with so many distributions.
>
>   
I don't know.
>>> As for the reference to bin_t, I can only guess that it's to execute
>>> spamassasin when spamassasin.te is not installed (spamassasin has some
>>> files in /etc/mail).
>>>
>>> Is it possible to have the postfix "local" execute spamassasin directly or
>>> would that be from someone who has spamassasin running from procmail
>>> (which seems to be the most common way of running spamassasin on a
>>> server) and not having procmail.te installed?
>>>
>>> I suggest the attached patch to fix these issues.
>>>       
>> Huh?  So we just allow spamassassin to fail if policy is not installed,
>> which it is not in targeted policy.
>>     
>
> We remove the bad policy until we can determine how to write good policy.
>
>   
No We make it work on a customers machine or they turn off selinux, 
never to turn it on again.
Turns out this is not bad policy and does not open up security holes.
> Allowing everything is easy, but that diminishes the value of SE Linux.  
> Determining what we really need is the hard work.
>
>   
Turning off SELinux everywhere diminishes SELinux.
> Who submitted the policy patch in regard to etc_mail_t and bin_t?  We need to 
> ask that person why they did it and find out what they were trying to do.  
> There is a better way of achieving the same result, but until we know what 
> they are trying to do it's not possible.  The questions we need to ask that 
> person are:
> 1)  Are you using procmail for delivery?
> 2)  If not how are you running spamassasin?
>
> The last thing I want to do is imagine how Postfix might be working, get it 
> wrong, and end up writing policy to permit Postfix to do things it can never 
> be configured to do!
>
>   
It is running postfix-script which is executing /bin/sed.

This is standard postfix out of the box, running on steve grubb machine.



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
