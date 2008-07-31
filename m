Subject: Re: unconfined_t and user_home_dir_type
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200807302203.14043.russell@coker.com.au>
References: <200807291850.30191.russell@coker.com.au>
	 <200807292220.17592.russell@coker.com.au>
	 <1217339731.4934.26.camel@defiant.pebenito.net>
	 <200807302203.14043.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 31 Jul 2008 09:36:48 -0400
Message-Id: <1217511409.4114.48.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-07-30 at 22:03 +1000, Russell Coker wrote:
> On Tuesday 29 July 2008 23:55, Chris PeBenito <pebenito@gentoo.org> wrote:
> > > > > While it is possible to have unconfined_t and user_t on the same
> > > > > system, I don't expect this to be a common configuration.  In fact I
> > > > > expect that in practice they will be mutually exclusive.
> > > >
> > > > Actually, it is a common situation in modern Fedora - they can map
> > > > users they wish to confine to user_u (and thus to user_t) while leaving
> > > > e.g. root as unconfined_u and thus unconfined_t.
> > >
> > > So what do they do for the "targeted" case where all users are
> > > unconfined_t and they want to have POP/IMAP servers retrieve mail from
> > > the users' home directories?
> >
> > Dan has no MAC-based home directory separations.  All home dirs are
> > user_home_dir_t in the Fedora policy.
> 
> 1) In a default configuration we want to have the users be unconfined 
> (otherwise they complain too much.
> 
> 2) For full functionality we need to have daemons such as a POP server, a mail 
> server (or it's local delivery agent), and a web server access the home 
> directories of all regular users.
> 
> 3) Allowing daemons to mess with super-powerful domains is of course a bad 
> idea, which is why we never let daemons access sysadm_home_dir_t.  But 
> preventing them from messing with ~/.bashrc etc while fulfilling the above 
> two conditions and making the system easy to use is almost impossible (maybe 
> restorecond has some potential to alleviate this, but it's still going to be 
> hard).
> 
> So we can have a boolean to allow the compromise for item 3 and have it 
> enabled by default.  So by default users get domain unconfined_t, home 
> directory label unconfined_home_dir_t, and the POP server etc can access 
> that.
> 
> To improve security we need to prevent the daemons messing with users who are 
> unconfined_t, that means unsetting the boolean in question and giving domain 
> user_t to users who have full interaction with daemons.
> 
> The next step up after that is to assign root the roles staff_r and sysadm_r 
> and remove unconfined.pp.
> 
> Am I missing anything?

Sounds about right.  It boils down to: we want to treat unconfined_r
like an unprivileged role for functionality reasons, but want to protect
it for security reasons.  A tunable is the best solution for allowing
the user to set which of the two above options is preferred.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
