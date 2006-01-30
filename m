Subject: Re: [SEMANAGE,UTILS] Support seusers.system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43DBC34E.9010100@cornell.edu>
References: <43DBC34E.9010100@cornell.edu>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 15:17:45 -0500
Message-Id: <1138652265.7076.179.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-01-28 at 12:17 -0700, Ivan Gyurdiev wrote:
> The attached patch complements the previous rename patch (which was 
> accepted after discussion).
> 
> It instantiates the seuser dbase 2 more times, for seusers.system, and 
> seusers.final.
> seusers and seusers.system stack to get seusers.final. I would have 
> preferred consistent naming for the files (.local for local stuff, 
> seusers for final), but that will create compatibility issues with 
> systems using the current setup. Patch changes manpages, the installed 
> file in semanage_store, and all dependencies that I know of 
> (genhomedircon, and seobject.py).

Merged as of libsemanage 1.5.19 and policycoreutils 1.29.16.

> We still need policy package support for users_extra.system, and 
> seusers.system.
> 
> Dan, if you install a seusers.system file, anything that you put in it 
> cannot be deleted, and semanage will reject at attempt to delete root or 
> __default__, if they are installed in that file (just like anything else 
> defined in policy).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
