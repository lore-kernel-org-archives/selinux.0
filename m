Subject: Re: Existence of "helper" functions (specifcally MLS)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: David Quigley <dpquigl@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <A5B53838-B8A8-47B0-9E4A-72A794702EBD@nall.com>
References: <44BFECE8.80501@us.ibm.com>
	 <1153748747.1641.18.camel@moss-terrapins.epoch.ncsc.mil>
	 <A5B53838-B8A8-47B0-9E4A-72A794702EBD@nall.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 10:30:37 -0400
Message-Id: <1153751437.6122.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-24 at 09:15 -0500, Joe Nall wrote:
> On Jul 24, 2006, at 8:45 AM, David Quigley wrote:
> 
> > On Thu, 2006-07-20 at 15:51 -0500, Michael C Thompson wrote:
> >> Hey all,
> >>
> >> I haven't looked extensively, but I was wondering if there exist any
> >> funcitons (probably in libselinux?) which would do comparisons on MLS
> >> labels and would return back whether or not one dominates another,  
> >> or if
> >> the categories are equal (or a subset), etc.
> >>
> >> Thanks much,
> >> Mike
> >>
> >
> > Hello,
> > 	Sorry for the late reply but I was at OLS all of last week. I  
> > currently
> > have this implemented but it is not upstreamed yet. It required  
> > changes
> > in both libselinux and in the kernel. I can generate a set of patches
> > for you if you need it before I can get it upstream however they are
> > currently against 2.6.18-rc1.
> 
> Why does this require kernel changes? I would expect this to be a  
> function comparing the levels and category bitmaps.

Only the policy engine can interpret the security labels.  So you have
two choices:  ask the kernel's policy engine via selinuxfs or use
libsepol on the on-disk policy file.  Advantage of the former is that a)
the kernel has already parsed and loaded the policy into memory, so you
avoid that cost again, and b) you ensure that you are dealing with the
same exact policy that the kernel is enforcing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
