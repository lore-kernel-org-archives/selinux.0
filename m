Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIJorIi015771
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 14:50:53 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIJor3o008619
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 19:50:55 GMT
Message-ID: <419CFD0F.2060301@redhat.com>
Date: Thu, 18 Nov 2004 14:50:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
CC: jwcart2@epoch.ncsc.mil, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patches without the can_network patch.
References: <41741A2C.8040408@redhat.com> <200410260138.19426.russell@coker.com.au> <20041025213122.GA2535@jmh.mhn.de> <200410270036.14935.russell@coker.com.au> <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil> <4192A029.5050909@redhat.com> <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil> <419CB27E.6080800@redhat.com> <20041118194313.GA2538@jmh.mhn.de>
In-Reply-To: <20041118194313.GA2538@jmh.mhn.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas Bleher wrote:

>* Daniel J Walsh <dwalsh@redhat.com> [2004-11-18 15:32]:
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.19.2/domains/program/ldconfig.te
>>--- nsapolicy/domains/program/ldconfig.te	2004-11-09 13:35:12.000000000 -0500
>>+++ policy-1.19.2/domains/program/ldconfig.te	2004-11-18 08:48:23.918139878 -0500
>>@@ -26,7 +26,7 @@
>> allow ldconfig_t lib_t:lnk_file create_lnk_perms;
>> 
>> allow ldconfig_t userdomain:fd use;
>>-allow ldconfig_t etc_t:file { getattr read };
>>+allow ldconfig_t etc_t:file { getattr read unlink };
>>    
>>
>
>Which files does it want to unlink? Is it possible that the file was
>just mislabeled? (there's this line in the policy:
>file_type_auto_trans(ldconfig_t, etc_t, ld_so_cache_t, file)
>so it should probably be ld_so_cache_t)
>
>Thomas
>
>  
>
Yes I added this because it gets, mislabeled and then can not change it 
back.
A bug in RPM was causing it many times.   Booting in non enforcing 
mode,  non selinux mode
This can easily happen on targeted policy, but could also happen on strict,
Allowing ldconfig_t from unlink etc_t files seems like a reasonable way 
around the problem.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
