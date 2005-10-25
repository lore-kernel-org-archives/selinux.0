From: Chad Sellers <csellers@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux_set_file_paths function
Date: Tue, 25 Oct 2005 14:26:25 -0400
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
References: <200510251258.34894.csellers@tresys.com> <1130263140.17609.388.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1130263140.17609.388.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510251426.26132.csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 25 October 2005 13:59, Stephen Smalley wrote:
> On Tue, 2005-10-25 at 12:58 -0400, Chad Sellers wrote:
> > Attached is a patch to libselinux that moves the setting of file_paths[]
> > out of init_selinux_config and into its own exported function.  This
> > allows a caller to reset those paths to an alternate policy type for
> > getting paths of files in that alternate policy type.  The patch also
> > includes a patch to semanage_install_active in libsemanage to use this
> > function rather than hacking the strings returned by libselinux.
>
> I'm not sure about the approach.  Some thoughts:
> - You are changing the libselinux file paths _except_ for the policy
> root, which you preserve for restoring the original values.  This leaves
> the paths in an inconsistent state.  If the approach were retained, I'd
> suggest saving the original type for restoration purposes, but setting
> policy root consistent with the other paths.  In that case, setting of
> selinux_policyroot moves into your new function as well and the code is
> a bit simpler.
yes, I should have done this to begin with

> - Since you are changing the paths, any libselinux function that
> internally opens one of these paths will use the new path after a set
> has been performed, so it has side effects beyond just the functions
> that get paths.  Not sure if that is a feature or a bug ;)
I thought of this as a feature, as any libsemanage function could easily 
switch back and forth between operating on the currently configured policy 
path and any other policy path.  This is useful for integration with package 
management.

> - Since the paths are global state of libselinux, if the caller is
> multi-threaded, then all threads will be affected (and the transition
> period isn't safe).
aah, the kicker.  I see 3 options to solving this problem.
1)  add locking.  This maintains the ability to reuse libselinux interfaces on 
other policy types, but adds complexity
2)  have the function operate on a file_paths paramater.  The init function 
could pass the global file_paths array to it, while other callers could pass 
their own arrays.  This is a simpler solution, but would require the caller 
to parse the array structure itself.
3)  return to the previous method of having the caller parse the string 
returned by the regular libselinux path functions and replace the type in the 
path with the type it wants.  This is the simplest approach, and it meets our 
current needs.  Unfortunately, it hardcodes a directory structure.

I think locking for this need is overkill, so I tend to lean toward 2 or 3.  
Perhaps 3 will serve our needs for the current time, and we can revisit this 
at a later time.

Chad

-- 
----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
