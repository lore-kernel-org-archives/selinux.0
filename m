Subject: Re: [ SEPOL ] Further users cleanup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <435903C2.2050805@cornell.edu>
References: <435903C2.2050805@cornell.edu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 11:26:19 -0400
Message-Id: <1129908379.27663.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-21 at 11:05 -0400, Ivan Gyurdiev wrote:
> - remove select/kill/clear_unused things (will only be used in genusers)
> - remove delete (all changes will be additive for now, through semanage)
> 
> - move delusers things into genusers.c
> - move genusers/genbools prototypes from sepol.h into their respective 
> headers
> 
> - map: remove sepol_clear_unused_users
> - map: remove duplicate sepol_set_delusers (it's in there twice)

Ok.  Note that we'll likely want to remove all wildcards from the map
files (for both libsepol and libsemanage) and explicitly list all
interfaces we want exported to avoid surprises, or at least check that
we aren't exporting anything accidentally.  
nm src/libsepol.so.1 | grep ' T ' shows some interfaces that shouldn't
really be public at present.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
