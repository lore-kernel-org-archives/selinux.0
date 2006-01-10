Message-ID: <43C3D4AE.8070403@tresys.com>
Date: Tue, 10 Jan 2006 10:37:18 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] User extra data (part 1)
References: <43C33ECB.2020608@cornell.edu>
In-Reply-To: <43C33ECB.2020608@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
<snip>
> 
> Another issue is how users_extra.system will be updated. Joshua, do you 
> have any suggestions?
> 

I really don't want to export a whole slew of extra interfaces for 
dealing with system level stuff so some of the options are

1) letting rpm/whatever be trusted to smash things in the store (non-ideal)

2) Write an 'import' interface that tells semanage to grab all the 
system files from somewhere and smash the ones in the store (sort of 
hackish)

3) add user_extra.system to the policy package and smash it on base 
policy upgrade (this is my favorite)

<snip>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
