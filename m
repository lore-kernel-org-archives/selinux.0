Subject: Re: [ SEPOL ] Reorganize users.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <43580118.1060909@cornell.edu>
References: <4357F5DF.30905@cornell.edu>
	 <1129839038.2375.507.camel@moss-spartans.epoch.ncsc.mil>
	 <43580118.1060909@cornell.edu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 08:24:07 -0400
Message-Id: <1129897447.2375.565.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-20 at 16:42 -0400, Ivan Gyurdiev wrote:
> Where do you set defined = 0 ? Calloc?

memset in user_read().  The field only exists in the in-memory policydb,
not the binary policy image / file.

> What's the benefit of this - should we remove this function (and the 
> corresponding policydb field)?
> (or are you thinking of adding a preserve users flag to load_policy ? )

I think we can remove delete support (and use of ->defined) from your
new functions, but I'd leave the field and the genusers code alone.  No
one is using it AFAIK, but sepol_set_delusers is part of the ABI of
prior releases of libsepol.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
