From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Fedora Core 5 Tomcat 4 problems
Date: Sat, 27 May 2006 21:06:13 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        "Michael K. Smith" <mksmith@adhost.com>, SELinux@tycho.nsa.gov
References: <C099D5CE.24D51%mksmith@adhost.com> <1148490176.24463.454.camel@moss-spartans.epoch.ncsc.mil> <1148562995.14262.4.camel@sgc.columbia.tresys.com>
In-Reply-To: <1148562995.14262.4.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605272106.18093.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 25 May 2006 23:16, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> On Wed, 2006-05-24 at 13:02 -0400, Stephen Smalley wrote:
> > On Wed, 2006-05-24 at 09:20 -0700, Michael K. Smith wrote:
> > > I am attempting to start Tomcat 4 using an rc script that uses the
> > > unprivileged user "tomcat" to run the application.
> > >
> > > allow initrc_su_t security_t:security compute_av;
> >
> > pam_rootok permission check from su.
>
> I have added this to su domains in reference policy.

It's really not needed.  With runuser there should not be any need for 
initrc_su_t in Fedora.  When I write the necessary code for Debian there will 
be no need for such things in Debian either.  So this may end up being a 
Gentoo-only thing if you do such things in Gentoo.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
