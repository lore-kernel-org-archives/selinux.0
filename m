Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1DGoDJQ010955
	for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2007 11:50:13 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1DGpP8n000341
	for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2007 16:51:26 GMT
Received: by py-out-1112.google.com with SMTP id a78so1180247pyh
        for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2007 08:51:25 -0800 (PST)
Message-ID: <45D1EC89.8040902@gmail.com>
Date: Tue, 13 Feb 2007 10:51:21 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
Subject: Re: su and context
References: <45CDEDEE.4050205@gmail.com>  <45D09836.5060007@us.ibm.com> <1171299200.5265.34.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1171299200.5265.34.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2007-02-12 at 10:39 -0600, Michael C Thompson wrote:
>   
>> Ted X Toth wrote:
>>     
>>> Why doesn't my context change when I 'su' to a different user?
>>>       
>> I'm pretty sure su isn't SELinux aware like newrole is -- not 
>> investigated the source enough to save 100%, but pretty sure.
>>
>> Is there a reason why you would want it to affect your context?
>>
>> DAC and MAC are not intended to be related I thought.
>>     
>
> The behavior has actually changed over time; you'll find discussions
> about it in the mailing list archives.  The original SELinux kept su
> separate from security context changes.  Earlier versions of Fedora (and
> RHEL 4) integrated them (via pam_selinux) in an effort to provide
> greater transparency, but this caused its own set of problems (e.g. use
> of su from init scripts, losing continuity of context across su when you
> want it for roles and levels).  More recent versions of Fedora (and RHEL
> 5) split them back out again.  One might add an option to su to support
> simultaneous newrole, but you don't want it by default.
>
>   
My concern was that when I su I may have a context which is invalid for 
the user. What I was thinking was that my context should be the default 
for the user I've su'd to as defined in default_contexts.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
