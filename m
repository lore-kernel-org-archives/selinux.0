Message-ID: <4203C18F.8030609@redhat.com>
Date: Fri, 04 Feb 2005 13:40:15 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Java Policy
References: <4203B048.5070607@redhat.com> <1107538571.8078.98.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107538571.8078.98.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2005-02-04 at 12:26, Daniel J Walsh wrote:
>  
>
>>This is policy for the java plugin.
>>Do not know if we want user apps that run java to transition.
>>
>>Will be sending in a big diff later today, but wanted input sooner.
>>    
>>
>
>- Neither I nor Tim Fraser wrote this java policy ;)  Looks like there
>is also cruft leftover from the netscape/mozilla policy in there.
>  
>
Ok, cleaned up comments. 

>- Might want to make it a general legacy_binary_t domain for use not
>only by java but by other legacy binaries.
>
>  
>
Well I don't think of this policy as a legacy binary  (Not that I would 
know what that means, I don't think
of Java as being legacy).  My goal was to create something for the java 
plugin not the java runtime.  Java
Runtime needs to have full access to the users environment since it is 
really the same as a scripting language
or any other executable.  We may want to write some policy but I feel 
you would need to duplicate the
base_users_domain to get it done.  Maybe this domain should be renamed 
javavm or  javaplugin.

>- I think there should also be a transition from the user domains on
>these legacy programs, so that they can be separately confined.
>
>  
>
Again not for this domain.

>- Not clear that you need to use a boolean in this domain, as the entire
>purpose of it is to deal with binaries that need this access.  Unless we
>can turn it off for other architectures.  But if you are going to use a
>boolean, we definitely want a separate one so that we can allow it to
>these legacy binaries without allowing it to the base user domains.
>  
>
I don't know if I agree with that.  I know people who say they refuse to 
run any code that allows
execmem/execmod.  If you don't have the global boolean you could 
accidently run them.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
