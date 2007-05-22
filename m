Message-ID: <4653270A.50308@redhat.com>
Date: Tue, 22 May 2007 13:23:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jbrindle@tresys.com
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [patch 0/3] genhomedircon replacement in libsemanage
References: <20070521095414.832619201@tresys.com>
In-Reply-To: <20070521095414.832619201@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

jbrindle@tresys.com wrote:
> This replaces genhomedircon with equivalent functionality in libsemanage. The homedir_template is also no longer installed, this leaves some unused path functions in libselinux but removing those would break the ABI. 
>
> This does the same things that genhomedircon did though some seemed strange, like removing /sbin/nologin from the list of valid shells, presumably to keep ftp users and such from getting file contexts generated for them, I'm not sure how valid the assumption is but we didn't want to change the functionality of genhomedircon in this patch set.
>
> The first patch adds genhomedircon.c to libsemanage and calls it from the semanage_store.c and removes the prior call to genhomedircon.
>   
genhomedircon goal in life was to find "login user accounts" and 
generate appropriate file context for them.  So we do not want any users 
with UID < 500 or with invalid shells.  /bin/nologin is not a valid 
login shell.  genhomedir command should be kept around even if it is 
only front-ending libsemanage.  Since an admin can add additional users 
with homedirs in random locations.  They could/should then run 
genhomedircon to fix the file context file.
> The second patch is a set of tests for the new functions
>
> And the third patch removes the old genhomedircon script.
>
>
> Signed-Off-By: Joshua Brindle <jbrindle@tresys.com>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
