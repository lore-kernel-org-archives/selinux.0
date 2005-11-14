Message-ID: <4378C936.60401@cornell.edu>
Date: Mon, 14 Nov 2005 12:28:22 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Re: rawhide targeted vs. refpolicy rpm
References: <BF9A263D.7FFA%csellers@tresys.com>	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>	 <200511141041.49643.csellers@tresys.com> <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil> <4378B88B.6040003@redhat.com>
In-Reply-To: <4378B88B.6040003@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:

 > This adds wrappers for some functions in libsemanage. The only wrapped
 > interfaces at this point are query functions for modules, seuser, and
 > user's. These should be sufficient for genhomedircon, and we can add
 > more wrapped interfaces as necessary.

Daniel J Walsh wrote:
> policycoreutils patch to genhomedircon to use libsemanage to read 
> seusers file.
This is awesome - the library has users!
I guess that means I should stop changing the API now :)

Genhomedircon dependency on file backend will be gone. It will no longer 
knows about the format of the files (or whether they are files at 
all)... or about the first role being the default role (now libsemanage 
decides that, and if you call set_defrole it makes sure that one is 
written first in the file).





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
