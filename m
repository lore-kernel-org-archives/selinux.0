Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5PFMfdx006655
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 11:22:41 -0400
Received: from web51504.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5PFMe9L006689
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 15:22:40 GMT
Date: Mon, 25 Jun 2007 08:22:39 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: regarding privilege granting
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1181932214.17547.882.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <736334.35671.qm@web51504.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> 1) Education. We've been telling users all along that SE Linux does not 
>> grant permissions. It adds restrictions on top of DAC. To change that 
>> now would likely confusion the casual user.
>
>Being able to fully manage privileges/capabilities based on Role-Based
>Access Control and Type Enforcement has been a design goal from day one,
>and was identified as such back in 2000.

Even if it was a design goal, that does not help with what everyone has been
trained to understand. We've been telling people that SE Linux is safe to use
since it does not grant any permissions, it just takes away.

>  In fact, people new to SELinux are often surprised that we don't already
> provide them with a way to give capabilities to specific programs without
> them running as uid 0 (even initially);

I think they are surprised because the assume the worst and later are relieved to
find out that DAC still has first vote and they still understand their system and
can control access rights without having to learn SE Linux policy.


>> 2) Nothing security relavent happens without root. All of the trusted 
>> databases require uid 0 to write to them. In some cases to read. All 
>> applications that need special permissions have been carefully arranged to
>> start as root and drop capabilities as they can.
>
>Many users don't want to have to run everything security-relevant as
>root (even initially);

They all do. The system will not work any other way. Do you realize how many apps
do a capability check by: if (getuid() != 0)   all those apps would break in a 
new privilege granting scheme.

>Again, this is not fundamentally different than file capabilities in terms 
>of non-root have privs.

I don't care for that either. But its probably more likely to meet compliance
issues since it can probably be worked into a 'find' command to scan the system
for programs with elevated privileges.


>> 3) In the few places where setuid must be used, these programs have 
>> undergone review dozens of times for flaws. No one allows them without
>> much review. If SE Linux gets into the business of granting privs, then I
>> doubt people would give the apps the extra amount of review that they 
>> should get.
>
>Writing SELinux policy is not easier / more prone to abuse than setting
>the suid bit on a binary or setting file capabilities on it.

I think you are missing my point. Because there is no good way to find the apps
with elevated privileges, admins will not do reviews to see if those apps are
using the special powers securely. 

> And it has nothing to do with the level of review (which I think you 
> overestimate, especially for third party and in-house apps).

setuid apps get reviewed because everyone understands the danger and people can
find all of them on their system.


>> 7) It will be hard to find for compliance auditing any applications that 
>> have been granted special privileges.
>
>Um, no - they will be explicitly called out by the cap_override rules in
>policy.  Very easy to search for in policy, much more so than scanning
>the filesystem for suid binaries or file capabilities.

There are a lot of tools that do something like:

find / -type f -perm -04000

How would you script a check like this? People have to be able to spot all apps
that have elevated privileges.

-Steve


 
____________________________________________________________________________________
We won't tell. Get more on shows you hate to love 
(and love to hate): Yahoo! TV's Guilty Pleasures list.
http://tv.yahoo.com/collections/265 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
