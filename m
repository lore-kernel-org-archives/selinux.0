Message-ID: <465329C4.9080202@tresys.com>
Date: Tue, 22 May 2007 13:35:00 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [patch 0/3] genhomedircon replacement in libsemanage
References: <20070521095414.832619201@tresys.com> <4653270A.50308@redhat.com>
In-Reply-To: <4653270A.50308@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> jbrindle@tresys.com wrote:
>> This replaces genhomedircon with equivalent functionality in 
>> libsemanage. The homedir_template is also no longer installed, this 
>> leaves some unused path functions in libselinux but removing those 
>> would break the ABI.
>> This does the same things that genhomedircon did though some seemed 
>> strange, like removing /sbin/nologin from the list of valid shells, 
>> presumably to keep ftp users and such from getting file contexts 
>> generated for them, I'm not sure how valid the assumption is but we 
>> didn't want to change the functionality of genhomedircon in this patch 
>> set.
>>
>> The first patch adds genhomedircon.c to libsemanage and calls it from 
>> the semanage_store.c and removes the prior call to genhomedircon.
>>   
> genhomedircon goal in life was to find "login user accounts" and 
> generate appropriate file context for them.  So we do not want any users 
> with UID < 500 or with invalid shells.  /bin/nologin is not a valid 
> login shell.  genhomedir command should be kept around even if it is 
> only front-ending libsemanage.  Since an admin can add additional users 
> with homedirs in random locations.  They could/should then run 
> genhomedircon to fix the file context file.
>> The second patch is a set of tests for the new functions
>>

Why is /bin/nologin in /etc/shells then? Our code is now making 
assumptions about what shells are indeed valid that isn't based on what 
the system itself says.

semanage -Bn will rebuild the file context files (and the rest of the 
policy) which includes running genhomedircon. No need for an external 
command to do this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
