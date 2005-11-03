Message-ID: <436AA434.6010003@anchor.com.au>
Date: Fri, 04 Nov 2005 10:58:44 +1100
From: Oliver Hookins <oliver.hookins@anchor.com.au>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Transitions using su command
References: <43699220.1060100@anchor.com.au> <1131027701.23420.37.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131027701.23420.37.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2005-11-03 at 15:29 +1100, Oliver Hookins wrote:
> 
>>I'm having some funny behaviour from one of our init scripts. We're 
>>running a multi-user tomcat environment, which as part of its init 
>>script runs a command like the following:
>>
>>su - $USER -c "$TOMCAT_SCRIPT start < /dev/null >& /dev/null"
>>
>>If you run this as root, replacing the variables with the appropriate 
>>values, the command runs as expected without any problems. If you run 
>>the init script using the service command it prompts the following:
>>
>>Your default context is user_u:system_r:unconfined_t.
>>
>>Do you want to choose a different one? [n]
>>
>>If you just press enter here, it goes back to the bash prompt and seems 
>>to succeed, however it worries me that when run automatically at startup 
>>and shutdown it might fail. Is there some sort of transition 
>>configuration I am missing, or something I can change to allow this 
>>transition?
> 
> 
> Using 'su' in this manner is a bad idea.  Use '/sbin/runuser' instead.
> See /etc/init.d/functions for example usage.

Thanks, that works brilliantly!

-- 
Regards,
Oliver

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
