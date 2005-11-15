Subject: Re: [ SEMANAGE ] Stub pserver backend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <437A0749.5060407@cornell.edu>
References: <437907D7.8090002@cornell.edu>
	 <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil>
	 <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil>
	 <4379E4D1.2010900@redhat.com>  <437A0749.5060407@cornell.edu>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 11:05:14 -0500
Message-Id: <1132070714.5415.404.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 11:05 -0500, Ivan Gyurdiev wrote:
> > Giving me the tools in libsemanage to build the manipulation of ports, 
> Okay, will work on that..
> 
> > seusers 
> The seuser APIs are already available, and should work in libsemanage.
> Although MLS validation is not happening, the modification should work, 
> and should verify that the SElinux user exists.
> Not sure if python bindings are currently available.
> > and potentially
> > user modules (local.pp) from python.
> Same for user APIs. Those things do not go into modules currently - 
> they're written back out into flat files. Why do we want those into a 
> module? I think Stephen also mentioned a while ago that modules cannot 
> yet support all of the objects that we are managing. Is this still the case?

In this context, "user modules" == "local modules" == module equivalent
to a local.te file in the old policy source-based approach.  Not related
to Linux or SELinux users, just user-supplied.  We want users to still
be able to run audit2allow (with additional flags), dump the output to a
file, run it through checkmodule -m and then install it with semodule.

Yes, non-base modules don't support SELinux user definitions when MLS is
enabled presently, so you have to put all SELinux user definitions into
the base module, and only the base module supports the object context
definitions that are part of policy (versus file contexts).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
