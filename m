Message-ID: <41E43DD8.5000306@redhat.com>
Date: Tue, 11 Jan 2005 15:58:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Added is_context_configurable function
References: <41E2FEF4.5070604@redhat.com>	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>	 <41E3FAF4.2060109@redhat.com>	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>	 <41E43784.2060406@redhat.com> <1105475738.20566.150.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1105475738.20566.150.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-01-11 at 15:31, Daniel J Walsh wrote:
>  
>
>>Using your method for every file he puts under /var/www/html now needs 
>>him to write some special rule into file_context file?
>>I don't like the usability of that.
>>    
>>
>
>No, you just add contexts to the end of the existing entries in
>apache.fc where you want to support alternatives.  Only case where you
>need a new entry is if you want to allow alternatives for a smaller set
>than is presently covered by some pathname regex.
>  
>
>  
>
>>I was going to put in a -F qualifier which would allow you to override 
>>the configurable_types.  Also
>>using -v -v will show you all files with configurable types
>>
>>restorecon -R -v /var
>>Quietly leave configurables
>>
>>restorecon -R -v -v /var
>>Would leave configurable entries but report them
>>
>>restorecon -F -R -v /var
>>Will work like current restorecon works.
>>    
>>
>
>configurable -> customizable or alternatives
>
>In practice, I would expect that admins will only use the default form
>(i.e. leave them intact and not report them) unless they encounter some
>other policy error, and that could prove fatal, e.g. if some sensitive
>file becomes mislabeled and accessible to untrusted processes.
>
>  
>
This might be a conflict between strict and relaxed policy.  I am 
getting bugs from users who setup the apache web servers
with files in different locations than the preordaned.  I am looking for 
an easy way for them to configure their system and make
it survive a restoration of file labels.  I don't believe telling them 
that they have to edit some file_context file and place regular expression
commands in some wierd format is a workable solution.  In strict policy 
it seems to me we have more control over the environment.
How about a user who wants to share /home/USER/www instead of 
/home/USER/public_html, how about setting up cluster system that
shares pages off of a /share directory.  Their are lots of examples with 
shared (customizable,alternatives, configurable whatever) files need to be
labeled, and we want a simple way for users to do this.  If the 
mechanism is to have them chcon -t samba_share_t XYZ and then they
forget to add an entry to file_context of they make a mistake in 
file_context and a restorecon blows their mods away they are not going to be
happy.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
