Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FHEoL9009142
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 12:14:50 -0500 (EST)
Message-ID: <42122D9E.40806@redhat.com>
Date: Tue, 15 Feb 2005 12:13:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Scott Cain <cain@cshl.org>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: Determining if SELinux is installed
References: <1108484321.3297.45.camel@localhost.localdomain>	 <1108485238.17854.110.camel@moss-spartans.epoch.ncsc.mil> <1108486127.3297.55.camel@localhost.localdomain>
In-Reply-To: <1108486127.3297.55.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Scott Cain wrote:

>On Tue, 2005-02-15 at 11:33 -0500, Stephen Smalley wrote:
>  
>
>>On Tue, 2005-02-15 at 11:18, Scott Cain wrote:
>>    
>>
>>>Hello,
>>>
>>>Is there a programmatic way to determine if SELinux is installed and
>>>enabled?  I would like to know so that I can let the installer I've
>>>written take appropriate action if it detects that it is there.
>>>      
>>>
>>The libselinux function is is_selinux_enabled(3).
>>There is also a libselinux utility called selinuxenabled(1) that can be
>>used in a conditional, e.g. if selinuxenabled; then echo Yes; fi.
>>Finally, you can also manually check for presence of selinuxfs in
>>/proc/filesystems.
>>    
>>
>
>Thanks.  I guess it will have to be the last option, since the installer
>is in perl, so I can't (directly) use is_selinux_enabled, and
>since /usr/sbin isn't typically in a user's path, I can't count on that
>either.  So `grep selinuxfs /proc/filesystems` it is!
>
>Thanks,
>Scott
>
>  
>
Why can't you fully path it?  Just checking if the /proc/filesystem 
exists is not sufficient, if the user has disabled
SELinux via /etc/selinux/config instead of selinux=0, I think.  
selinuxenabled also checks to see if a policy has been
loaded.

I would do the equivalent of

[ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled

in perl.


Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
