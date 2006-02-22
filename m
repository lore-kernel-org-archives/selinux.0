Subject: Re: semanage non MLS breakage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, Chris PeBenito <pebenito@gentoo.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <43F8A847.8010709@cornell.edu>
References: <1140150258.13377.15.camel@gorn.pebenito.net>
	 <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org>
	 <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org>
	 <43F5E97B.8060102@cornell.edu> <43F5EB83.30402@gentoo.org>
	 <43F5EE32.5080101@cornell.edu>  <43F64063.4040601@cornell.edu>
	 <1140288277.18548.28.camel@gorn.pebenito.net>
	 <43F77E2B.3050108@cornell.edu> <43F86035.1010401@cornell.edu>
	 <43F8A2AC.9070601@tresys.com>  <43F8A847.8010709@cornell.edu>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 10:49:25 -0500
Message-Id: <1140623365.31467.244.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-02-19 at 12:17 -0500, Ivan Gyurdiev wrote:
> > It's an invalid context, I don't think there is anything you *can* do 
> > except fatally error. Consider what would happen if there was a proper 
> > MLS context with multiple levels on an MCS policy...
> Well, in that case, patch attached. Also fixes printing of mls_range in 
> the error case for seuser_validate.
> Applies on top of the previous one.
> 
> That leaves the semanage tool to audit and fix for non-MLS issues.

Merged both patches (libsepol 1.11.19, libsemanage 1.5.29).  As noted by
Ivan, semanage still needs to be modified to not presume MLS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
