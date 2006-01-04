Message-ID: <43BBF408.7030701@cornell.edu>
Date: Wed, 04 Jan 2006 11:12:56 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [SEMANAGE] [SETSEBOOL] Clone record on set/add/modify
References: <43BBD6C0.6020108@cornell.edu> <1136395785.27632.272.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1136395785.27632.272.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Thanks, your entire patch series has been merged as of libsepol 1.11.2,
> libsemanage 1.5.4, and policycoreutils 1.29.3.
>   
Question - I did some reordering of the headers in semanageswig.i (at 
the beginning).
I see you haven't merged that part, but you're missing a header that I 
added - booleans_active.h (which is why I did the reordering actually - 
not to miss any headers). Of course, semanage.h includes all of those 
headers, so I'm not sure whether or not any of them are needed in the 
first place, given that semanage.h is included.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
