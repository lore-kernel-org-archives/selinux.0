Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14E0D53007351
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 09:00:13 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j14E0FOQ009027
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 14:00:15 GMT
Message-ID: <42037FDC.9000908@redhat.com>
Date: Fri, 04 Feb 2005 08:59:56 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>	 <41FA9717.2000609@redhat.com>	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>	 <4200D68A.6030309@redhat.com> <1107478728.4065.3.camel@cobra.ivg2.net>
In-Reply-To: <1107478728.4065.3.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>On Wed, 2005-02-02 at 08:32 -0500, Daniel J Walsh wrote:
>  
>
>>-if (allow_execmod) {
>>-allow $1 texrel_shlib_t:file execmod;
>>-}
>>    
>>
>
>... X needs execmod, and this change breaks it:
>
>audit(1107469036.956:0): avc:  denied  { execmod } for  pid=3383 comm=X
>path=/usr/lib/nvidia/tls/libnvidia-tls.so.1.0.6629 dev=dm-0 ino=519237
>scontext=system_u:system_r:xdm_xserver_t
>tcontext=system_u:object_r:texrel_shlib_t tclass=file
>
>Also, mozilla needs execmem. What's going on with this - I've
>seen it sent twice and rejected twice... 
>
>audit(1107476807.924:0): avc:  denied  { execmem } for  pid=3828
>comm=firefox-bin scontext=user_u:user_r:user_mozilla_t
>tcontext=user_u:user_r:user_mozilla_t tclass=process
>
>  
>
You need to set the boolean

setsebool -P allow_execmod 1
 On fresh installs this will be in there. 

Why should we have the boolean if we know that X will require it always?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
