Message-ID: <4162ED4F.6000208@redhat.com>
Date: Tue, 05 Oct 2004 14:51:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: A couple of patches to setfiles.
References: <415E9107.4030900@redhat.com>	 <1097000679.3878.132.camel@moss-spartans.epoch.ncsc.mil> <1097001163.3878.134.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1097001163.3878.134.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2004-10-05 at 14:24, Stephen Smalley wrote:
>  
>
>>You want to log always?  Should be based on an option, like the existing
>>verbose option, and you likely only want to log if !only_changed_user as
>>with the verbose case.
>>    
>>
>
>Actually, there is already a -o option to log to a specified file.  Why
>add syslog calls as well?
>
>  
>
Steve Grub has pointed out that the way we are doing setfiles is all 
wrong, and that we should be logging
to syslog.  That way a management infrastructure could monitor and 
manage the environment.  Writing
temporary or log files in arbitrary places is wrong.  Tools like 
logrotate are going to clean them up.  ETC.
So the -o flag should go and we should use syslog.

So I think we need to relook at setfiles/fixfiles and plug them better 
into standard architecture. 

I think we need a mechanism to tell us when a file actually has the 
wrong context versus one that just does not
match the context in the file_context file.  Russell pointed out that 
the contents of the homedirectory should
not have an automatic tool looking at their context because it might 
open up a security hole if you were to
arbitrarily clean up the false positives.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
