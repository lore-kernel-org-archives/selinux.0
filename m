Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9K9HIi015673
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:09:17 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9K7bPU021650
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:07:39 GMT
Message-ID: <41B8B0DD.9010302@redhat.com>
Date: Thu, 09 Dec 2004 15:09:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Colin Walters <walters@redhat.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Russell Coker <rcoker@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Single home directory type for all roles.
References: <20041207000805.GH3678@jmh.mhn.de>	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>	 <41B8826D.30105@redhat.com>	 <1102613299.10785.21.camel@nexus.verbum.private>	 <41B8A9BF.2080405@redhat.com> <1102622320.32175.230.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1102622320.32175.230.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-12-09 at 14:38, Daniel J Walsh wrote:
>  
>
>>Currently few people use staff, because user can do everything staff can 
>>do so you are not protected by this protection.
>>You also do not protect yourself from staff users attacking other staff 
>>users.
>>    
>>
>
>Few Fedora SELinux users use staff_r because user_canbe_sysadm is
>enabled by default in the Fedora policy.  Disable it, and they'll start
>using staff_r, because they will have to do so.  Colin has separation
>between staff_r and user_r if he has disabled that tunable, which I
>expect he has.  As for staff vs. staff, SELinux can only separate
>different security contexts; otherwise, you are relying on DAC (of
>course, SELinux does control the Linux capabilities, so your ability to
>override DAC controls can be limited by SELinux).
>
>If you disabled user_canbe_sysadm, and provided integrated user
>management so that people could update their policy users configuration
>(whether via policy sources or using genpolusers) easily when they
>update their regular users databases, then you'd see greater use of
>staff_r.
>
>  
>
Agreed, but I still have the relabeling problem.  My goal is to move 
towards the separation of user and staff though
a default disabling of user_canbe_sysadm, without having find and 
relabel all files the user might have created.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
