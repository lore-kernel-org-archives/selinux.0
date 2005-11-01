Subject: Re: [ SEMANAGE ] Install seusers, rename some files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, SELinux@tycho.nsa.gov
In-Reply-To: <4367D13A.1050305@cornell.edu>
References: <4366C114.9080708@cornell.edu>
	 <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil>
	 <4367D13A.1050305@cornell.edu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 15:41:01 -0500
Message-Id: <1130877661.22731.308.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-01 at 15:34 -0500, Ivan Gyurdiev wrote:
> Yes, the seusers from /etc/selinux/strict/seusers have to get in the 
> sandbox somehow...
> I'm not entirely sure how, but I think Tresys has indicated that should 
> occur through the APIs, rather than by copying it in.

I think moving the local files into the sandbox upon policy update (via
%post scriptlet in the policy package) is reasonable, as this is only
needed for migration and will not be done subsequently.  All subsequent
manipulation of the files will then be done on individual records via
the API, but we don't want to go that route for the initial populating
of the sandbox for the local files.  For modules, it is a different
matter, as installing complete modules is a normal part of the API, not
just a migration requirement, so we can use that API as is (via
semodule).

> This is only necessary for migration...

Yes.  But we need to avoid breaking use of semodule -b now via this
patch until such a time as the seusers support is in place, so possibly
I should just change the error handling here to just WARN and proceed
with the reload.

> The authoritative seusers file should be in the sandbox. Personally I 
> think all authoritative files should be in the sandbox, and not get 
> copied from place to place...  but that's not how things work currently. 
> By the way, direct modifications of the /etc/selinux/seusers file will 
> be overwritten by libsemanage (but I think the goal is that there should 
> be no direct modifications..)

The "active" files need to have some standard location that is known to
libselinux, regardless of whether that standard location is inside or
outside of the sandbox.  Using the existing standard locations outside
the sandbox is good for compatibility as well as enabling the sandbox to
remain fully private to libsemanage (so we can restructure it at any
time without affecting libselinux).  I do agree however that copying for
the final installation of the files is not good, and needs to be
replaced by an atomic rename.

Yes, the goal should be to eliminate any direct editing of seusers or
any other local files, and require the use of utilities that go through
libsemanage for all such modifications.  The utilities and/or
libsemanage can then be instrumented for auditing such modifications.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
