Message-ID: <41E3FAF4.2060109@redhat.com>
Date: Tue, 11 Jan 2005 11:12:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Added is_context_configurable function
References: <41E2FEF4.5070604@redhat.com> <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2005-01-10 at 17:17, Daniel J Walsh wrote:
>  
>
>>This patch defines two functions.
>>
>>is_context_configurable(scontext) 
>>This returns if if the context is in the 
>>/etc/selinux/*/contexts/configurable_contexts file.
>>0 If not and -1 on error.
>>
>>Internally this calls get_configurable_context_list which returns a 
>>contextarray of the contexts of that file.
>>
>>I have also patched the policy makefile to populate that file, but 
>>looking for all contexts marked as configurable.
>>
>>Now I would like to use this function in restorecon/setfiles, so that by 
>>default they will leave configurable contexts alone.
>>    
>>
>
>I think that in prior discussions of this functionality, we had
>discussed allowing an optional list of alternative contexts at the end
>of each entry in the file_contexts configuration, and having
>setfiles/restorecon not change the context if the file already had any
>context in that list, but still set the context to the first context
>listed if the file lacked any context at all (e.g. initial labeling). 
>I'm not sure I see the benefit of marking the types with an attribute in
>the policy since you aren't defining any rules based on that attribute
>or providing a separate configuration file from file_contexts.
>
>  
>
I think this is more flexible, in that it allows users to specify the 
location of these files versus policy.
IE I create a new top level directory /rsync which I want to label 
ftp_anon_t, I don't want to have to specify
ftp_anon_t is an alternative to default_t.  Specifying it as an 
attribute just gives a way of creating the file on the
fly from policy rather than just having a flat file in contexts called 
configurable_contexts, also depending on the
policy the file may differ.  I could see someone writing policy say 
allowing ftp r_dir_file(ftp_t, configurable).

I think we should rename the concept from configurable_contexts to 
configurable_types, and change all the functions
to match, also.  Since this is really just the type we are concerned with.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
