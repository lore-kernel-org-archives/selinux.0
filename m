Message-ID: <41790F02.8070207@redhat.com>
Date: Fri, 22 Oct 2004 09:45:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Proposed patch for libselinux
References: <41782BBA.9090101@redhat.com> <1098451420.7614.43.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1098451420.7614.43.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-10-21 at 17:35, Daniel J Walsh wrote:
>  
>
>>I would like to add getfileconperm and setfileconperm to libselinux.  
>>This will set a flag to indicate whether the security context of the
>>file was set via chcon (Permanently) or via setfiles/restorecon.  If 
>>this patch is approved, I have patches to coreutils and policycoreutils
>>to use them.
>>    
>>
>
>"perm" suggests "permission" to me, not "permanent".  Also, I'm not sure
>that "permanent" conveys the right sense; Colin's earlier suggestion of
>"customized" made more sense to me.
>
>Obviously, a kernel change is required here as well, as any other
>attribute in the security namespace should presently be restricted to
>CAP_SYS_ADMIN.  The setxattr hook would need to check for this new
>attribute and apply a different check if you want non-root users to be
>able to do this, and we likely need a new permission for it then. 
>Right?
>
>  
>
Why is this not covered by the current checks of setting file context.  
I don't think this is a special case.
If a domain can setfilecon, they should be able to set it permanently
setfileconfixed?
setfileconpermanent?
lockfilecon?
customizefilecon?

I don't  care what we call it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
