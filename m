Message-ID: <42980072.6090701@redhat.com>
Date: Sat, 28 May 2005 01:24:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: SELinux@tycho.nsa.gov
Subject: Re: file_type_auto_trans is not sufficient
References: <1117249760.19257.18.camel@localhost.localdomain> <1117252045.19698.16.camel@localhost.localdomain>
In-Reply-To: <1117252045.19698.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>To address those problems, I think I need to add selinux support
>>to a number of applications, and perform the transition in the code. 
>>I'm not sure what's the best way to do that. Does adding 
>>the following functions to libselinux (or elsewhere) make sense?
>>
>>int mkdir_restorecon(const char *pathname, mode_t mode);
>>int creat_restorecon(const char *pathname, mode_t mode);
>>int mknod_restorecon(const char *pathname, mode_t mode, dev_t dev);
>>
>>Those would perform getfscreate/matchpathcon/setfscreate cycle,
>>and would ignore errors in permissive mode.
>>    
>>
>
>Actually, what exactly happens when you call setfscreate() and
>at the same time you have a matching file_type_auto_trans rule?
>
>In my case for /tmp/gconfd-$USER vs /tmp/orbit-$USER,
>(process is gconf, executing libORBit code that creates orbit-$USER)
>the orbit getfscreate() rule took precedence over
>the matching file_type_auto_trans in gconfd... does
>this always happen, or do I have to make a choice 
>between either file_type_auto_trans, or setfscreate() ?
>
>  
>
setfscreatecon takes precedence.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
