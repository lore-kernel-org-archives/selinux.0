Message-ID: <43765F0C.7020805@cornell.edu>
Date: Sat, 12 Nov 2005 16:30:52 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Add sepol_policydb_mls_enabled, organize map file
References: <43765D20.9070200@cornell.edu>
In-Reply-To: <43765D20.9070200@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Changes:
>
> - adds new function to check if policydb is mls enabled (target is 
> libsemanage: user/seuser/context parsers)
...but see... this isn't as trivial as it looks, because those parsers 
don't have access to a policydb currently. There is no policydb object 
available until commit time, where one is created.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
