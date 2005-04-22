Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3MBKu7C015024
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 07:20:56 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3MBD1rf028488
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 11:13:01 GMT
Message-ID: <4268DB1F.80409@redhat.com>
Date: Fri, 22 Apr 2005 07:08:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au,
   "Fedora SELinux support list for users &amp; developers." <fedora-selinux-list@redhat.com>
CC: David Hampton <hampton-rh@rainbolthampton.net>, selinux@tycho.nsa.gov
Subject: Re: Tweaks to the amavis policy
References: <1110979100.20316.18.camel@hampton-pc.rainbolthampton.net> <200504221819.49152.russell@coker.com.au>
In-Reply-To: <200504221819.49152.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Thursday 17 March 2005 00:18, David Hampton 
><hampton-rh@rainbolthampton.net> wrote:
>  
>
>>I've added support to the (unused) amavis policy to allow interaction
>>with additional mail filters, and added a new type specifically for
>>quarantined spam and viruses.  I also tweaked the network access to
>>limit ports that can be used by amavisd.  I'd appreciate any feedback on
>>these changes or tips on how to write better policies.  Thanks.
>>    
>>
>
>+# Tmp reaper
>+ifdef(`tmpreaper.te', `
>+allow tmpreaper_t amavisd_quarantine_t:dir { read search getattr setattr 
>unlink };
>+allow tmpreaper_t amavisd_quarantine_t:file getattr;
>+')
>
>tmpreaper_t should not need setattr access to the directory.
>
>To perform any useful function tmpreaper_t will need read/write access to the 
>directory and unlink access to the file such as the following:
>
>allow tmpreaper_t amavisd_quarantine_t:dir { rw_dir_perms unlink };
>allow tmpreaper_t amavisd_quarantine_t:file { getattr unlink };
>
>  
>
Why not add the attribute tmpfile to amavisd_quarantine_t and you get 
this for free.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
