Message-ID: <41E43784.2060406@redhat.com>
Date: Tue, 11 Jan 2005 15:31:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Added is_context_configurable function
References: <41E2FEF4.5070604@redhat.com>	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>	 <41E3FAF4.2060109@redhat.com> <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-01-11 at 11:12, Daniel J Walsh wrote:
>  
>
>>I think this is more flexible, in that it allows users to specify the 
>>location of these files versus policy.
>>IE I create a new top level directory /rsync which I want to label 
>>ftp_anon_t, I don't want to have to specify
>>ftp_anon_t is an alternative to default_t.
>>    
>>
>
>You could certainly specify a /rsync/(/.*)? entry in file_contexts that
>had both contexts listed.  Ordinary user shouldn't be able to
>create/populate /rsync anyway without administrative setup.
>
>  
>
Using your method for every file he puts under /var/www/html now needs 
him to write some special rule into file_context file?
I don't like the usability of that.

>Failing to associate the context with a location in any manner means
>that setfiles/restorecon will fail to fix the label on e.g. /etc/shadow
>if it happens to get one of these configurable types at some point. 
>Admittedly, getting to that point requires some kind of serious error in
>the first place, but running fixfiles relabel will no longer correct
>such errors for you.
>
>BTW, customizable or alternatives seems better than configurable.
>
>  
>
I was going to put in a -F qualifier which would allow you to override 
the configurable_types.  Also
using -v -v will show you all files with configurable types

restorecon -R -v /var
Quietly leave configurables

restorecon -R -v -v /var
Would leave configurable entries but report them

restorecon -F -R -v /var
Will work like current restorecon works.


Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
