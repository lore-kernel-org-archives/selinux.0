From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: unconfined_t and user_home_dir_type
Date: Tue, 29 Jul 2008 22:20:15 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200807291850.30191.russell@coker.com.au> <1217331219.20373.139.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217331219.20373.139.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807292220.17592.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 29 July 2008 21:33, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2008-07-29 at 18:50 +1000, Russell Coker wrote:
> > Currently we have the attributes user_home_dir_type and user_home_type
> > applied to the main types for the home directory of regular users in a
> > strict policy configuration (this means user_t etc).
> >
> > While it is possible to have unconfined_t and user_t on the same system,
> > I don't expect this to be a common configuration.  In fact I expect that
> > in practice they will be mutually exclusive.
>
> Actually, it is a common situation in modern Fedora - they can map users
> they wish to confine to user_u (and thus to user_t) while leaving e.g.
> root as unconfined_u and thus unconfined_t.

So what do they do for the "targeted" case where all users are unconfined_t 
and they want to have POP/IMAP servers retrieve mail from the users' home 
directories?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
