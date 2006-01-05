Subject: Re: libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43BAB5C7.5080904@cornell.edu>
References: <200601040559.04895.russell@coker.com.au>
	 <43BAB5C7.5080904@cornell.edu>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 08:51:05 -0500
Message-Id: <1136469065.27632.377.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-03 at 12:35 -0500, Ivan Gyurdiev wrote:
> 
> > -		context_destroy(&c->context[0]);
> > -		context_destroy(&c->context[1]);
> > +		if(con)
> > +		{
> > +			context_destroy(&con->context[0]);
> > +			context_destroy(&con->context[1]);
> > +		}
> >   
> This is actually wrong, the bug is that con should be iface, as we're 
> freeing the interface's context.
> The variable c was correctly left uninitialized in the code - it was 
> just used where it's not supposed to.

I fixed the bug in the sepol_iface_modify error path, also included in
libsepol 1.11.3.  I have not yet merged Russell's patch for libsepol, as
I am still examining it.  Note that we should avoid expending effort on
optimizing code that is obsolete (e.g. genbools other than
genbools_array for preservebools=1, all of genusers) or not performance
critical.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
