Message-ID: <424A1DA8.9070006@gentoo.org>
Date: Tue, 29 Mar 2005 22:31:52 -0500
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'James R. Marcus'" <jmarcus@mvalent.net>, selinux@tycho.nsa.gov,
   selinux-dev@tresys.com
Subject: Re: setools-1.5.1
References: <200503292057.j2TKv48R006767@gotham.columbia.tresys.com>
In-Reply-To: <200503292057.j2TKv48R006767@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:

>>-----Original Message-----
>>From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
>>Behalf Of Stephen Smalley
>>Sent: Tuesday, March 29, 2005 12:04 PM
>>To: James R. Marcus
>>Cc: selinux@tycho.nsa.gov
>>Subject: Re: setools-1.5.1
>>
>>On Tue, 2005-03-29 at 11:49 -0500, James R. Marcus wrote:
>>    
>>
>>>I tried updating my machine to setools-1.5.1 and it failed.
>>>I had switch permissive mode and did emerge setools.
>>>      
>>>
>>Current version of setools is 2.0.  Your bug report is likely more
>>appropriate to gentoo-hardened, as it would appear to be specific to
>>Gentoo, right?
>>
>>    
>>
>>>`seuser_read_conf_info':
>>>: undefined reference to `selinux_policy_root'
>>>      
>>>
>>Do you have libselinux >= 1.14?  That is what defines that function.
>>Current stable version is 1.22.
>>
>>    
>>
>
>Just an FYI - setools only optionally depends on libselinux. If you want, for
>example, to run apol on a non-selinux machine you can change the options in the
>makefile to remove the libselinux dependency. It is on by default, however, and
>obviously some of the tools (e.g., replcon) require libselinux.
>  
>

Portage already handles libselinux as an optional dependancy and takes 
care of this for the user, the problem is that the 2.0 ebuild did not 
have the correct version of libselinux as a dependancy so there were 
missing symbols.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
