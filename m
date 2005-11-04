Message-ID: <436B9597.3060304@cornell.edu>
Date: Fri, 04 Nov 2005 12:08:39 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, James Morris <jmorris@redhat.com>,
   Chad Sellers <csellers@tresys.com>
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P	to	use	libsemanage
References: <436915FB.3040500@tresys.com>	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>	 <1131116390.23420.247.camel@moss-spartans.epoch.ncsc.mil>	 <436B8185.4050508@cornell.edu>	 <1131118424.23420.265.camel@moss-spartans.epoch.ncsc.mil>	 <436B8771.60203@redhat.com>	 <1131120757.23420.279.camel@moss-spartans.epoch.ncsc.mil> <1131121900.23420.288.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131121900.23420.288.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Note btw that even the setsebool w/o -P case should eventually go
> through libsemanage as well, IIUC, even though that will not regenerate
> the binary policy file, but we don't have interfaces for that purpose
> yet.  Likewise for togglesebool and getsebool.  But that isn't critical
> right now.
>   
Can you explain why that is?  I'm trying to understand what kind of 
interface is needed. Do you need a single function (set()), or do you 
need a full backend implementing the entire dbase API? Specifically, do 
you need queries in libsemanage? What's the justification for runtime 
policy changes like that to go through libsemanage?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
