Message-ID: <4358E349.9070007@cornell.edu>
Date: Fri, 21 Oct 2005 08:47:05 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] Reorganize users.c
References: <4357F5DF.30905@cornell.edu>	 <1129839038.2375.507.camel@moss-spartans.epoch.ncsc.mil>	 <43580118.1060909@cornell.edu> <1129897447.2375.565.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129897447.2375.565.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I think we can remove delete support (and use of ->defined) from your
> new functions, but I'd leave the field and the genusers code alone.  No
> one is using it AFAIK, but sepol_set_delusers is part of the ABI of
> prior releases of libsepol.
>   
Ok agreed...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
