Message-ID: <3C14EE14.1090505@pcez.com>
Date: Mon, 10 Dec 2001 09:17:08 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: New security policy
References: <Pine.GSO.4.33.0112101059130.13300-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Sun, 9 Dec 2001, Shaun Savage wrote:
>
>>I have compiled some of the selinux utils for RH7.2, I hope to do the
>>rest this week.
>>this is how I did it
>>
>>I first did  >rpm -bp XXXX.spec
>>the patched the XXXX directory using the patch
>>on some XXXX i needed to autoconf  (caution: the autoconf that comes
>>with RH7.2 is bad upgrade to 2.52 from GNU.org)
>>I then go back to the SPEC directory and rpm -bc --short-circuit XXXX.spec
>>then rpm -bi --short-circuit XXXX.spec
>>
>
>In our work in upgrading the utilities, we've encountered a fair number of
>rejects from the existing patches that have required manual merging, and
>at least some of those manual merges were non-trivial.  We also had to add
>stat64 variants of the stat_secure system calls, with transparent
>redirection, in order to support the new fileutils package.  Are you
>actually dealing with any of these kinds of issues in your patches?
>
I entered most of patches by hand,  I thought most the manual patches 
easy.  The issue of stat_secure calls with transparent redirection,  I 
don't know.  I have only working on selinux for about 3 days.  I want to 
get the support programs ported first.  If you want I can make RPM's.  

Shaun Savage





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
