Message-ID: <40B5F324.9010208@redhat.com>
Date: Thu, 27 May 2004 09:54:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Subject: Re: Security contexts for the contexts directory?
References: <40B5D706.2050902@redhat.com> <1085663772.1072.149.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1085663772.1072.149.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-05-27 at 07:54, Daniel J Walsh wrote:
>  
>
>>With the new design of the policy tree, we have moved the "contexts" 
>>files into
>>/etc/selinux/*/contexts/
>>
>>These files include default_contexts, file_contexts, default_type, 
>>failsafe_contexts ...
>>as well as contexts for individual users like users/root.  Currently the 
>>security contexts for these files is etc_t.   Should we change them so 
>>something else? default_contexts_t?  Should file_contexts be marked 
>>differently then the others?
>>    
>>
>
>I'd suggest a single type (other than etc_t) for default_contexts,
>default_type, failsafe_context, and the other files installed from
>policy/appconfig.  file_contexts should likely have a different type to
>allow different access, so perhaps it should have its own directory and
>type.  With the old layout and policy, it ends up in policy_config_t,
>but I think we want to distinguish it from the binary policy file as
>well as from the appconfig files.
>
>  
>
Ok how about, default_contexts_t for contexts directory and users 
directory.  Create a new directory called files and put file_contexts in 
there with a context of file_contexts_t.

>>Also since policy is determined by /etc/sysconfig/selinux, should we set 
>>a special security context on it?  If we do should we move it to a 
>>directory where it would be easier to maintain the security context?  
>>Maybe rename it to /etc/selinux/config?
>>    
>>
>
>I would prefer having a distinct type on it (and moving it to a
>directory with that type so that we can easily preserve the type), as
>the integrity of that file is critical to SELinux, at least in the
>Fedora Core implementation.
>
>  
>
Should that have default_contexts_t also? Or something different?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
