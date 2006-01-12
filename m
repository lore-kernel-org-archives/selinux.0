Message-ID: <43C6DF28.2080500@cornell.edu>
Date: Thu, 12 Jan 2006 15:58:48 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
   dwalsh@redhat.com
Subject: Re: [SEMANAGE] User extra data (part 1)
References: <43C33ECB.2020608@cornell.edu> <43C3D4AE.8070403@tresys.com>
In-Reply-To: <43C3D4AE.8070403@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> I really don't want to export a whole slew of extra interfaces for 
> dealing with system level stuff so some of the options are
>
> 1) letting rpm/whatever be trusted to smash things in the store 
> (non-ideal)
>
> 2) Write an 'import' interface that tells semanage to grab all the 
> system files from somewhere and smash the ones in the store (sort of 
> hackish)
>
> 3) add user_extra.system to the policy package and smash it on base 
> policy upgrade (this is my favorite)
I have no preference... Dan?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
