Message-ID: <4236EA74.2050901@redhat.com>
Date: Tue, 15 Mar 2005 09:00:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Latest patches
References: <423253FB.6090602@redhat.com> <1110893102.25947.7.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1110893102.25947.7.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2005-03-11 at 21:29 -0500, Daniel J Walsh wrote:
>  
>
>>Fixed to Makefile to better handle local.users
>>    
>>
>
>Why is system.users a dependency of $(FCPATH) while local.users is a
>dependency of install?
>
>  
>
We don't want to replace local.users on a make reload, since it is admin 
customizable.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
