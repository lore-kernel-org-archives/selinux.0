Subject: Re: [ SEMANAGE ] Replace semanage debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <434BF60A.5020204@cornell.edu>
References: <434B62B8.4080309@cornell.edu>
	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
	 <1129039592.3308.110.camel@moss-spartans.epoch.ncsc.mil>
	 <434BCC58.7030509@cornell.edu>
	 <1129041009.3308.125.camel@moss-spartans.epoch.ncsc.mil>
	 <434BD2CB.8050007@cornell.edu>  <434BF60A.5020204@cornell.edu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 13:23:04 -0400
Message-Id: <1129051384.3308.179.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 13:27 -0400, Ivan Gyurdiev wrote:
> > Okay, so it sounds like the optimal setup is:
> > - pass variadic list to callback
> > - remove msg field from message structure (rename?)
> > - embed message structure into handle to avoid allocation
> >
> > Then handler takes four arguments instead of the current two:
> >
> > - void* arg
> > - message structure (rename?)
> > - fmt
> > - variadic list
> Wait.... how do I invoke a variadic function from a variadic function?
> Should I pass the va_list as an argument?
> I knew there was a reason I got rid of this in the first place...

Why can't msg_write be a macro?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
