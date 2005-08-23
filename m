Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NFJuOb029023
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 11:19:56 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7NF9gcX028038
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 15:09:43 GMT
Message-ID: <430B3C86.60802@redhat.com>
Date: Tue, 23 Aug 2005 11:11:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com> <430B2D6A.5010105@tresys.com>	 <430B3049.5070402@redhat.com> <1124808634.7874.72.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124808634.7874.72.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-08-23 at 10:18 -0400, Daniel J Walsh wrote:
>  
>
>>This code is not part of libselinux,  it is a library that SELinux calls 
>>out to that will be specific to the vendor that ships it.
>>I see this library being different between our version of MCS/MLS and 
>>other third party versions of MLS, IE one that translates using the 
>>Mitre Libraries.
>>
>>MCS version of libtrans.so translates s0->"".
>>
>>MLS policy can do what ever it wants with this part of the range.
>>    
>>
>
>While it is true that systems with a real MLS policy will likely have
>their own libsetrans implementation, I think it would make sense to have
>your default libsetrans implementation at least provide a way to map
>sensitivity names as well as category names via the config file,
>including a way to specify that they should just be dropped (e.g.
>s0="").  Whether or not you should further allow mapping of entire
>combinations, like s0:c0,c127=puritycontrol, via the config in your
>default libsetrans implementation is more open to debate.
>  
>
I was thinking of issue of the multiple translations and how to do 
SystemHigh also.  Currently I am just truncating off
the s0: and asking for a translation of the remainder.  So c0,c127 would 
translate to puritycontrol.   
Translating s0="" Would give me better flexibility though, so I guess I 
can adopt it.  I was considering allowing users to specify multiple 
Categories on a file and then translating it, but it probably would be 
better to force the user to specify a name for multiple categories.

c1,c5,c7=CompanyConfidential_CokeSecretRecipe_PrintOnly


>Also, how do you intend to deal with multiple libsetrans
>implementations?  Symlink to the real translation library?  Managed via
>the alternatives system?
>
>  
>
I was thinking conflicting rpm packages.  So You can not install MCS and 
MLS translation libaries at the same time.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
