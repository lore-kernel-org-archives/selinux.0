Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2PFasx6010284
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 10:36:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2PFarR1017006
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 15:36:53 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h2PFamj9016993 for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 15:36:50 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Vance <cvance@tislabs.com>
Subject: Re: essential patches
Date: Tue, 25 Mar 2003 16:36:14 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0303251008370.31512-100000@zorg.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0303251008370.31512-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303251636.17723.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Mar 2003 16:17, Chris Vance wrote:
> > The issue is not something inherantly specific to dhcpc_t, the issue is
> > that ifconfig lost some functionality and that dhclient was one (of
> > potentially many) programs that rely on such functionality.
>
> Sorry, this is a mistake on my part.  The interaction between some of
> these domains is not clear, especially when it's not a configuration I
> typically use.  Wayne has added the necessary rule back to the ifconfig
> domain and cleanup up netutils.te.  I just committed these two changes to
> Sourceforge.

Great!  Thanks for the quick response.

> > > Perhaps ssl clients should be running in a more
> > > restrictive domain - don't they also require access to privileged
> > > information, such as private keys?  Why run them directly in the user
> > > domain?
> >
> > SSL clients don't require any special access to files or other local
> > resources.  Consider an SSL web browser, it does not require any special
> > access to files on disk (netscape runs in a separate domain to
> > intentionally give it LESS access to files because of it's history).  But
> > for a web browser to actually provide a benefit from SSL then it needs a
> > source of good random numbers.  I recall an attack against an early
> > version of Netscape which didn't generate pseudo-random numbers well
> > enough.
> >
> > SSL is used for POP, IMAP, FTP, HTTP, and probably other protocols. 
> > Currently apart from Netscape/Mozilla we don't have special domains for
> > any of the clients for those protocols.
>
> Even without using client-side certificates, the SSL protocol normally
> requires a PKI.  Nearly all SSL clients will maintain a list of trusted
> roots.  Replacing or inserting a new root can severely impact the security
> of the SSL protocol.  I would consider this to be privileged information.
> Sorry, private keys was just a simple example.

Root certificates are read-only data.  It's OK for them to be readable as long 
as they are not writable.  In a typical installation they will be stored 
somewhere under /etc or /usr where user_t will only get read access to them.

The only information that can potentially need to be restricted is when the 
SSL client receives a certificate from the server that is not signed (or not 
signed ny a known CA) and the user is prompted for whether they should 
continue to trust it.

However the most common SSL client is Netscape.  Netscape has a separate 
domain to protect the rest of the system from it (not to protect it from the 
rest of the system) because of it's history.

Probably the best thing to do is to change the SSL client programs so that 
there is no facility for them to accept unsigned certificates (should be a 
simple compilation option).

> > There are more useful limitations that could be put in the core which
> > would probably be less painful:
> > Prevent sysadm_t from reading symlinks from untrusted users (along with a
> > special policy for ls to allow sysadm_t to see what the links are).
> >
> > Support for multiple run_init type programs to allow delegating daemon
> > start/stop permissions for some daemons (IE the database administrator
> > can re-start the database).  I've already done more than half the work
> > for this...
>
> I would definitely agree that there is much work that must be done to get
> make the policy useful for a larger audience.  I think the core policy is
> a step in the right direction, an unfortunate side effect is that some
> programs will no longer run under the core policy.  Otherwise, it's
> impossible to secure a machine running an arbitrary set of applications
> with unknown interaction.  The difficult problem has always been
> understanding what programs do and why.

Yes.  Part of the problem is that some programs have grown over time into 
monstrosities that can't be understood by humans.  ifconfig is a good 
example.  :-#

> Look for commits to Sourceforge later today that cleanup some additional
> core domains.  At a minimum, these will include syslogd, klogd, crontd,
> logrotate.  If you have the opportunity to test them on non-redhat
> systems, that would be great.

OK.  I'll have a look at it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
