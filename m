From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: dynamic context transitions
Date: Fri, 26 Nov 2004 06:48:57 +1100
Cc: SELinux List <SELinux@tycho.nsa.gov>
References: <4182959B.4080503@trustedcs.com> <1099402984.31739.17.camel@moss-spartans.epoch.ncsc.mil> <1099404989.23756.79.camel@pham.columbia.tresys.com>
In-Reply-To: <1099404989.23756.79.camel@pham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200411260649.01922.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 03 November 2004 01:16, Karl MacMillan <kmacmillan@tresys.com> 
wrote:
> On Tue, 2004-11-02 at 08:43 -0500, Stephen Smalley wrote:
> > On Mon, 2004-11-01 at 16:27, Karl MacMillan wrote:
> > > Dropping privileges after startup can already be accomplished with
> > > conditional policies, though it requires that only one process be
> > > running in a given domain.
> >
> > Not sure that this works well in practice, e.g. daemon restart is an
> > issue here, and as you note, it cannot distinguish among multiple
> > instances of the domain.
>
> It would certainly require some additional infrastructure and more
> invasive changes to init scripts, but it could be made to work. I think
> that others have raised the more important point - what real use case is
> there for this functionality?

If you were to use a boolean to set the access of a daemon to "startup" or 
"normal operation" then the big problem is to restart in the case that a 
process is still running.

If a running process has been cracked and does not have the same PID as the 
original copy then the stop script will not stop it.  Then if the start 
script changes the boolean to temporarily grant extra access then that access 
will also be granted to the cracked process.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
