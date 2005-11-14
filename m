Message-ID: <437909EC.9080600@cornell.edu>
Date: Mon, 14 Nov 2005 17:04:28 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Add sepol_policydb_mls_enabled, organize map file
References: <43765D20.9070200@cornell.edu>  <43765F0C.7020805@cornell.edu> <1131976846.5415.51.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131976846.5415.51.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Yes, I noticed that as well when I looked at this issue last week.  Note
> however that we don't need an expanded policy for this test; we can
> simply check the MLS-enabled status of the base module.  So possibly an
> interface similar to sepol_module_package_info() could be added to
> obtain the MLS-enabled status from the base module package, and then
> that flag could be passed along to those parsers.
>   
Ok, so what about this patch? Is it merged or rejected?
I can write another one to query the mls field without reading the whole 
policy...




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
