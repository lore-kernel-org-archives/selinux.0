Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0SMXU53028012
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 17:33:30 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0SMXWng020202
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 22:33:32 GMT
Message-ID: <41FABDB1.7030606@redhat.com>
Date: Fri, 28 Jan 2005 17:33:21 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: selinux@tycho.nsa.gov
Subject: Re: [ RESEND ] Fedora Rawhide mplayer policy
References: <1106944688.2174.13.camel@cobra.ivg2.net>	 <41FAAA5A.1020800@redhat.com> <1106947027.2936.1.camel@cobra.ivg2.net>
In-Reply-To: <1106947027.2936.1.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>I will add them.
>>    
>>
>
>Warning, this creates a problem for xine:
>
>audit(1106946868.187:0): avc:  denied  { search } for  pid=2976
>exe=/usr/bin/xine name=win32 dev=dm-0 ino=180195
>scontext=user_u:user_r:user_t tcontext=system_u:object_r:win32_lib_t
>tclass=dir
>
>I could write a policy for that too, if necessary.
>
>  
>
Why not label win32_lib_t as being texrel_shlib_t?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
