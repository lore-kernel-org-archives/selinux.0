Message-ID: <421F30FC.7040103@redhat.com>
Date: Fri, 25 Feb 2005 09:06:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: Strange staff role problems...
References: <1109131644.5285.10.camel@cobra.ivg2.net>	 <1109163626.17298.8.camel@moss-spartans.epoch.ncsc.mil>	 <421CAF61.20708@redhat.com>	 <1109176324.17298.85.camel@moss-spartans.epoch.ncsc.mil>	 <421CB4F3.5040803@redhat.com>	 <1109178720.17298.94.camel@moss-spartans.epoch.ncsc.mil> <1109307176.4061.14.camel@cobra.ivg2.net>
In-Reply-To: <1109307176.4061.14.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>On Wed, 2005-02-23 at 12:12 -0500, Stephen Smalley wrote:
>  
>
>>On Wed, 2005-02-23 at 11:53 -0500, Daniel J Walsh wrote:
>>    
>>
>>>Ok try again.
>>>      
>>>
>>Looks good.  Of course, you'll need to update the spec file if you
>>haven't already to depend on versions of libselinux and libsepol that
>>include the necessary support (libselinux >= 1.21.10, libsepol >=
>>1.3.4).
>>    
>>
>
>In case you think this is important...
>load_policy's not working for me re: fixing this issue.
>It says policy loaded, shows 10 users (as opposed to 4 after init).
>Then I restorecon the entire home folder, it properly restores
>unlabeled_t files to staff_home_t, and ...
>
>I try to login, and I get denials that my home folder is unlabeled_t.
>
>I should note that while restorecon changes newly created unlabeled_t
>files to staff_home_t, it does nothing about my home folder (because
>it already says staff_home_dir_t on disk. Yet it says unlabeled_t
>on attempted access even after users are loaded.
>
>P.S. Why are there no SRPMS on dwalsh's repository..
>I found some, but they're not the right ones against rawhide, and I
>don't see sepol there.
>
>  
>
Because I don't put srpms on them.  All packages on my site are just 
what is going to be
in Rawhide the next day.  So I don't bother pullin srpms.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
