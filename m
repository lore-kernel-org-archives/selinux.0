Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0BG6xIi007935
	for <selinux@tycho.nsa.gov>; Tue, 11 Jan 2005 11:06:59 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0BG721A011309
	for <selinux@tycho.nsa.gov>; Tue, 11 Jan 2005 16:07:02 GMT
Message-ID: <41E3F98E.2030400@redhat.com>
Date: Tue, 11 Jan 2005 11:06:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, sequel@neofreak.org,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: root and change of passwords
References: <1105124940.27291.20.camel@sequel.info.polymtl.ca>	 <1105451963.20566.12.camel@moss-spartans.epoch.ncsc.mil> <1105456202.7682.18.camel@selinux>
In-Reply-To: <1105456202.7682.18.camel@selinux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>On Tue, 2005-01-11 at 08:59 -0500, Stephen Smalley wrote:
>  
>
>>On Fri, 2005-01-07 at 14:09, DeadManMoving wrote:
>>    
>>
>>>i've recently find a bug in the implementation of SELinux in gentoo
>>>Still willing to fix that, i've given the red hat passwd suite a try on
>>>my gentoo installation and yes! it works quite well!
>>>      
>>>
>>IIRC, the Fedora passwd program obtains the caller's security context,
>>extracts the user identity from it, and checks a SELinux permission if
>>attempting to change the passwd information for a user other than the
>>caller.  Note that the user identity in the security context can only
>>be set by processes allowed to do so by SELinux policy and is not
>>necessarily the same as the Linux uid, so a rogue uid 0 process cannot
>>arbitrarily assume the SELinux user identity of "root".
>>    
>>
>
>I was writing up a patch for shadow's version of passwd, chfn, and chsh,
>when I noticed that chage doesn't have a check.  Is chage not included
>in Fedora, or was it determined that it didn't need a check?
>
>  
>
chage comes from shadow-utils in Fedora/RHEL

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
