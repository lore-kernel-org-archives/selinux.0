Message-ID: <42D28E44.80903@redhat.com>
Date: Mon, 11 Jul 2005 11:20:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@tresys.com>, gyurdiev@redhat.com,
   "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: Re: libsemod????
References: <200507081928.j68JSDvx005028@gotham.columbia.tresys.com> <1121090501.12334.66.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1121090501.12334.66.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2005-07-08 at 15:28 -0400, Karl MacMillan wrote:
>  
>
>>The three libraries accomplish 3 very different tasks:
>>
>>1. Libsepol - policy manipulation.
>>2. Libselinux - access / labeling decisions and other runtime policy support.
>>3. Libsemod (which has been suggested off-list to become libsemanage) -
>>management of selinux policy including addition and removal of modules, selinux
>>user management, file context modification, etc.
>>
>>I think that as things move forward the applications that link to multiple
>>versions will decrease. User-space object managers and trusted selinux aware
>>applications (e.g., dbus or login) will link to libselinux. Management tools
>>will link to libsemod (e.g., semodule, useradd). Libsepol is the backend for the
>>management tools - it could be made static I guess.
>>    
>>
>
>Notice also that libsepol at least needs to be useable on non-SELinux
>hosts for offline binary policy file generation and manipulation.  In
>contrast, libselinux is specifically for security-aware applications
>running on SELinux.
>
>  
>
>>The alternative is that dbus will have code for adding policy modules including
>>over the network in the future (if libsemod is merged with libselinux) or that
>>checkpolicy will have the same code (if it is merged with libsepol). Doesn't
>>seem ideal to me. What is the downside? Extra packages?
>>    
>>
>
>I say we roll them all into glibc ;)
>
>  
>
I still think one libselinux and one libsepol would be fine.  But if you 
all believe with need this new libsemod/libsemanage then  so be it.  You 
are the upstream maintainer.  I just want the name finallized before I 
add it to Fedora.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
