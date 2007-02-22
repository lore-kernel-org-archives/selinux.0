Subject: Re: I think this is equivalent to what we have now and more
	efficient.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DDB71D.9060507@redhat.com>
References: <45DDAA80.80603@redhat.com>
	 <200702221015.21700.sgrubb@redhat.com>  <45DDB71D.9060507@redhat.com>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 10:36:48 -0500
Message-Id: <1172158608.14363.396.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-22 at 10:30 -0500, Daniel J Walsh wrote:
> Steve Grubb wrote:
> > On Thursday 22 February 2007 09:36:48 Daniel J Walsh wrote:
> >   
> >>     } else {
> >>         struct stat buf;
> >>         return (stat("/proc/filesystems", &buf));
> >>     }
> >>     
> >
> > This doesn't tell you if a selinuxfs is available.
> >
> > -Steve
> >   
> That is the point.  The original code does not care whether selinuxfs is 
> in /proc/filesystem or not it returns 0 if it could read it and the con 
> was not "kernel". 

Actually, the original code does care - it explicitly checks for
selinuxfs in /proc/filesystems and only sets enabled = 1 if it finds it
there.  That's the strong test for selinux.  Then, if SELinux is
present, it performs a heuristic (the getcon test) to see whether policy
is loaded, and if it can definitely tell that policy is not loaded (i.e.
getcon succeeds and returns "kernel"), then it clears enabled so that
no-policy-loaded is treated the same as selinux-disabled.  That was
mostly due to the original Fedora Core 2 handling before we had an
explicit /selinux/disable to use for turning off SELinux after boot.

getcon success/failure isn't directly correlated to /proc/filesystems
success/failure; they both require proc to be mounted, but getcon could
fail for other reasons.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
