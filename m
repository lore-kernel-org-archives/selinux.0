Message-ID: <40C7472E.80607@redhat.com>
Date: Wed, 09 Jun 2004 13:21:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
References: <20040601090345.GM8312@lkcl.net> <1086266468.17657.19.camel@moss-spartans.epoch.ncsc.mil> <1086268467.17657.53.camel@moss-spartans.epoch.ncsc.mil> <200406042132.40136.russell@coker.com.au>
In-Reply-To: <200406042132.40136.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Thu, 3 Jun 2004 23:14, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
>  
>
>>>The implication is that pam_selinux cannot perform tty relabeling for
>>>openssh 3.8.  Thus, we must revert to using a direct patch.  Someone
>>>want to port the old 3.6 patch?
>>>      
>>>
>>BTW, note that the patch is very simple; you just want to extend the
>>    
>>
>
>It seems to me that pam_selinux is not going to do what we want.
>
>We have to split the module into two parts to get the desired behaviour.  It 
>doesn't work with sshd, and some xdm's.  Now it only works with /bin/login 
>and one xdm variant (AFAIK).
>
>I think that we are taking the wrong approach to this and we should give up 
>and just patch the applications?
>
>
>Dan, as inventor of the pam_selinux module, what do you think?
>
>  
>
openssh has been repatched with the old patch.  Basically openssh 3.8 
has this kind of pseudo code.

Authenticate
If UID != 0
       pam_open_session
       Drop Creds
Alloc TTY
IF UID == 0
       pam_open_session
Exec shell

This causes the stange behavior where if you ssh in to root, pam_selinux 
works correctly.
If you ssh as a normal user pam_selinux does not relabel the tty and you 
get connection dropped.

After investigating how we could get this behavior changed we decided to 
just patch openssh with the setexec and tty relabel, and drop 
pam_selinux from /etc/pam.d/sshd

As far as dropping pam_selinux, I don't think that is a good idea since 
it can be used by third party apps that might want this behavior and it 
works fairly well for su and login.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
