Message-ID: <43D0E4E3.40505@cornell.edu>
Date: Fri, 20 Jan 2006 06:25:55 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Seusers vs ldap
References: <43CE880B.3020908@cornell.edu> <43CE8AD6.7050109@redhat.com> <43CEAF5E.5020503@tresys.com> <43D0A4C6.9060406@cornell.edu> <43D0E148.6010400@tresys.com>
In-Reply-To: <43D0E148.6010400@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> Now that I think of it loading a random network module into the memory 
> space of semanage is a bad idea, we should be limiting the amount of 
> trust we put in the alternate (esp networked) backends
Does that mean there will be no networked policy server backend?
I don't trust the pserver very much at the moment :)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
