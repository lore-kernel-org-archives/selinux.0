Message-Id: <200502181400.j1IE0j8R008122@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: sepol_genusers
Date: Fri, 18 Feb 2005 09:00:45 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1108733810.28149.5.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Sent: Friday, February 18, 2005 8:37 AM
> To: Karl MacMillan
> Cc: 'Daniel J Walsh'; selinux@tycho.nsa.gov
> Subject: RE: sepol_genusers
> 
> On Thu, 2005-02-17 at 21:53 -0500, Karl MacMillan wrote:
> > Any reason this shouldn't generate a new policy that is 
> saved to disc? 
> > How are the booleans handled when the config file is corrupt? Also, 
> > there doesn't seem to be a security reason not to continue 
> the boot with the missing users.
> 
> sepol_genusers(3), like sepol_genbools(3), is acting on an 
> in-memory binary policy image and generating a new in-memory 
> image for loading into the kernel just prior to performing 
> the load.  No modification of the on-disk policy binary file. 
>  That is the point.
>

I know that't the point - I'm questioning whether that is the right approach for
this. For the booleans, the worst case it to fall back on the policy defaults.
For users, there is no fallback other than a previous policy, which in this
model won't have any users either. Why not have the user management tool
generate a new policy (indirectly through a helper, of course)? Really just a
binary policy version of the seuser program (not the X tool or the scripts - the
seuser program that _only_ modifies the policy).

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134  
 
> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
