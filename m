Message-ID: <41E537C8.8060101@redhat.com>
Date: Wed, 12 Jan 2005 09:44:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Colin Walters <walters@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Added is_context_configurable function
References: <41E2FEF4.5070604@redhat.com>	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>	 <41E3FAF4.2060109@redhat.com>	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>	 <1105481440.24748.22.camel@nexus.verbum.private> <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-01-11 at 17:10, Colin Walters wrote:
>  
>
>>I've said this before, but I don't like the idea of having to edit
>>file_contexts whenever I want to change the labels.  I feel that the 
>>on-disk version should be canonical, and the file_contexts only used for
>>system initialization.
>>    
>>
>
>That is also my view.  However, if people are going to run setfiles or
>restorecon at runtime to check or set contexts (which is current
>practice in Fedora), then we do need a way to distinguish legitimate
>customizations from what are essentially bugs in the policy (e.g. lack
>of a file type transition rule) or applications (e.g. failure to
>preserve or set context on a file where file type transition rules are
>insufficient).  The file contexts configuration seemed like a reasonable
>way to capture that distinction to me.  Two questions:
>1) Is it sufficient to identify legitimate customizations based solely
>on the TE type of the file?  If not, what other information should be
>taken into account, irrespective of whether this is done via
>file_contexts or via a different config file?
>  
>
I think we can somewhat do that now.  I am not looking at the ability to 
put general
files in random location, just based off the wim of the Administrator.  
IE putting
/var/named some where else is not what we are considering, in this case 
a secondary
file_context.local file should be required.  But the usual case of 
labeling file for sharing
IE samba_share_t, http*, ftp_anon_t.  These will be come common, and the 
admin should not
be required to update file_context in this case.  (We had considered 
calling them sharables)

>2) Is it feasible for the policy writer to identify all such TE types a
>priori in the policy without covering such a large set as to make
>setfiles/restorecon completely useless by default? If not, what
>mechanism will be provided to allow users/admins to easily mark
>additional types without conflicting with future policy updates?
>
>  
>
I believe so as long as we confine it to shareable types of context, not 
files that have standard locations,
that an admin might decide to change.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
