Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j17JVP53022301
	for <selinux@tycho.nsa.gov>; Mon, 7 Feb 2005 14:31:25 -0500 (EST)
Message-ID: <4207C27C.2090103@mindspring.com>
Date: Mon, 07 Feb 2005 14:33:16 -0500
From: Richard Hally <rhally@mindspring.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Daniel J Walsh <dwalsh@redhat.com>, ivg2@cornell.edu,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>	 <41FA9717.2000609@redhat.com>	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>	 <4200D68A.6030309@redhat.com> <1107478728.4065.3.camel@cobra.ivg2.net>	 <42037FDC.9000908@redhat.com> <1107526206.8078.55.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107526206.8078.55.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2005-02-04 at 08:59, Daniel J Walsh wrote:
>  
>
>>You need to set the boolean
>>
>>setsebool -P allow_execmod 1
>> On fresh installs this will be in there. 
>>
>>Why should we have the boolean if we know that X will require it always?
>>    
>>
>
>- It is only needed for certain drivers, e.g. nvidia, and not others (I
>don't need it for my machine), and
>- It represents a security risk to allow it, especially since X is
>highly privileged.
>
>  
>
FWIW, It looks to me that the problem with X not starting is not just 
with "legacy" (or third party) drivers or "old toolchains". I am 
running  current rawhide(as of 2/5/05) with no other addons(like nvidia) 
and X does not start  in enforcing(current strict policy1.21.8-4). If 
it's an "old toolchain" problem then it is a Red Hat (Fedora) toolchain 
that needs to be updated...
Richard Hally


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
