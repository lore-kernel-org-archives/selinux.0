Message-ID: <42442433.8050507@redhat.com>
Date: Fri, 25 Mar 2005 09:46:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Russell Coker <russell@coker.com.au>
Subject: Re: I would like to propose some kind of consolidation of tmpfs_t
 and tmp_t
References: <4242CABC.70400@redhat.com>	 <1111675057.12486.39.camel@moss-spartans.epoch.ncsc.mil>	 <1111685458.13486.61.camel@moss-spartans.epoch.ncsc.mil>	 <42431DB0.7040803@redhat.com> <1111757565.15280.20.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1111757565.15280.20.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-03-24 at 15:06 -0500, Daniel J Walsh wrote:
>  
>
>>I don't think we have do do any of that.  It seems to work if you do a
>>restorecon /tmp
>>in the init scripts.
>>
>>I am running strict policy with tmpfs mounted on /tmp
>>    
>>
>
>Yes, that works as long as you have:
>	allow tmpfile tmpfs_t:filesystem associate;
>
>Right?
>
>  
>
I have added that, so I am not sure if it is necessary, but with it is 
working with the change.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
