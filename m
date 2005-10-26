Subject: Re: [PATCH] selinux_set_file_paths function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <200510251426.26132.csellers@tresys.com>
References: <200510251258.34894.csellers@tresys.com>
	 <1130263140.17609.388.camel@moss-spartans.epoch.ncsc.mil>
	 <200510251426.26132.csellers@tresys.com>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 08:26:51 -0400
Message-Id: <1130329611.17609.485.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-25 at 14:26 -0400, Chad Sellers wrote:
> On Tuesday 25 October 2005 13:59, Stephen Smalley wrote:
> > - Since you are changing the paths, any libselinux function that
> > internally opens one of these paths will use the new path after a set
> > has been performed, so it has side effects beyond just the functions
> > that get paths.  Not sure if that is a feature or a bug ;)
> I thought of this as a feature, as any libsemanage function could easily 
> switch back and forth between operating on the currently configured policy 
> path and any other policy path.  This is useful for integration with package 
> management.

I'm not certain how it would be used in practice, on two counts:
1) semanage presently does policy reloading and file contexts validation
via helper programs (load_policy, setfiles), so it cannot directly
affect the paths used by them via such a libselinux interface, and
2) semanage only does a reload when dealing with the active store, so it
doesn't need such an interface for policy loading, and setfiles already
supports specification of the file contexts path (and libselinux
supports that via its matchpathcon_init() interface).

> 2)  have the function operate on a file_paths paramater.  The init function 
> could pass the global file_paths array to it, while other callers could pass 
> their own arrays.  This is a simpler solution, but would require the caller 
> to parse the array structure itself.

The delicate point here is ensuring that we can continue to extend that
array or even re-arrange it without breaking the libselinux ABI.  To
achieve that, I think you would need to:
a) have the function internally allocate the array itself rather than
having the caller allocate it (since only libselinux knows how large the
array needs to be), and
b) have the caller only access the array elements via new libselinux
functions that parallel the existing selinux_* functions but take the
path array as an argument, so that the caller isn't tied to specific
indices for specific paths.

> 3)  return to the previous method of having the caller parse the string 
> returned by the regular libselinux path functions and replace the type in the 
> path with the type it wants.  This is the simplest approach, and it meets our 
> current needs.  Unfortunately, it hardcodes a directory structure.
> 
> I think locking for this need is overkill, so I tend to lean toward 2 or 3.  
> Perhaps 3 will serve our needs for the current time, and we can revisit this 
> at a later time.

I'd vote for #2, with the suggestions above, but agree that this isn't
necessarily the highest priority right now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
