Subject: Re: [patch 0/3] genhomedircon replacement in libsemanage
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
In-Reply-To: <465329C4.9080202@tresys.com>
References: <20070521095414.832619201@tresys.com>
	 <4653270A.50308@redhat.com>  <465329C4.9080202@tresys.com>
Content-Type: text/plain
Date: Tue, 22 May 2007 17:10:49 -0400
Message-Id: <1179868249.9092.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-22 at 13:35 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > jbrindle@tresys.com wrote:
> >> This replaces genhomedircon with equivalent functionality in 
> >> libsemanage. The homedir_template is also no longer installed, this 
> >> leaves some unused path functions in libselinux but removing those 
> >> would break the ABI.
> >> This does the same things that genhomedircon did though some seemed 
> >> strange, like removing /sbin/nologin from the list of valid shells, 
> >> presumably to keep ftp users and such from getting file contexts 
> >> generated for them, I'm not sure how valid the assumption is but we 
> >> didn't want to change the functionality of genhomedircon in this patch 
> >> set.
> >>
> >> The first patch adds genhomedircon.c to libsemanage and calls it from 
> >> the semanage_store.c and removes the prior call to genhomedircon.
> >>   
> > genhomedircon goal in life was to find "login user accounts" and 
> > generate appropriate file context for them.  So we do not want any users 
> > with UID < 500 or with invalid shells.  /bin/nologin is not a valid 
> > login shell.  genhomedir command should be kept around even if it is 
> > only front-ending libsemanage.  Since an admin can add additional users 
> > with homedirs in random locations.  They could/should then run 
> > genhomedircon to fix the file context file.
> >> The second patch is a set of tests for the new functions
> >>
> 
> Why is /bin/nologin in /etc/shells then? Our code is now making 
> assumptions about what shells are indeed valid that isn't based on what 
> the system itself says.
> 


You should ask this question on the fedora-devel list.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
