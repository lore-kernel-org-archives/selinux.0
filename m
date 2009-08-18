Subject: Re: checking user status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Larry Ross <selinux.larry@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <81092d890908171338j36a27012h3b87c5828f1d24ab@mail.gmail.com>
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com>
	 <1250521053.3629.117.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170755n2f5df6c2h3ca57faff998e6d6@mail.gmail.com>
	 <81092d890908171338j36a27012h3b87c5828f1d24ab@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 08:19:21 -0400
Message-Id: <1250597961.3629.209.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-17 at 13:38 -0700, Larry Ross wrote:
> On Mon, Aug 17, 2009 at 7:55 AM, Larry Ross <selinux.larry@gmail.com>
> wrote:
>         
>         On Mon, Aug 17, 2009 at 7:57 AM, Stephen Smalley
>         <sds@tycho.nsa.gov> wrote:
>                 
>                 On Mon, 2009-08-17 at 07:47 -0700, Larry Ross wrote:
>                 > On Mon, Aug 17, 2009 at 5:29 AM, Stephen Smalley
>                 <sds@tycho.nsa.gov>
>                 > wrote:
>                 >         On Sun, 2009-08-16 at 11:53 -0700, Larry
>                 Ross wrote:
>                 >         > Using the RHEL5.3 strict policy I am
>                 trying to allow a
>                 >         custom selinux
>                 >         > user permission to use the passwd and
>                 chage commands to get
>                 >         the status
>                 >         > of a local user.
>                 >         >
>                 >         > With selinux in permissive it works as
>                 expected, with
>                 >         selinux in
>                 >         > enforcing, all I get are cryptic error
>                 messages.  I
>                 >         installed the
>                 >         > enableaudit.pp base policy module, still
>                 no denials.
>                 >         >
>                 >         > Does anyone know what permissions I need
>                 to add or what I
>                 >         could
>                 >         > be doing wrong?  Is this even possible?
>                 >
>                 > Stephen,
>                 > Thank you for your response.
>                 >
>                 >
>                 >         Did you allow the :passwd permission to the
>                 custom selinux
>                 >         user's
>                 >         domain?
>                 >
>                 >         allow <userdomain> self:passwd { passwd };
>                 >
>                 > I would have if I had know about it, is this
>                 documented somewhere?.
>                 >
>                 > That worked for "passwd -S", is there something
>                 similar to allow a
>                 > user to use the chage command?
>                 
>                 
>                 Looks like that is using rootok, although it ought to
>                 use a permission
>                 of its own rather than overlapping with pam_rootok.
>                 
>                 So:
>                        allow <userdomain> self:passwd { passwd
>                 rootok };
>  
> Similar issue.  I have created a new user and used chage to expire
> their password so they are required to create a new one on their first
> login.   
>  
> Logging in to the Gnome Greeter, with SELinux permissive, there is no
> issue, with SELinux enforcing (still the strict policy, a custom
> user), I get a message that says "The change of the authentication
> token failed.  Please try again later or contact the system
> administrator."
>  
> No SELinux denials.
>  
> Two questions:
> 1. Anyone know what permission or permissions are required so this
> works and which domain or domains need it?
> 2. Anyone have any direction on how I can answer these questions for
> myself?

If this is another manifestation of the same problem, then the easiest
approach would be to grab the libselinux .src.rpm, patch
libselinux/src/checkAccess.c to syslog() a message whenever there is a
denial, build and install your patched libselinux, and then retry and
look for the log message.

Dan - we should really convert those programs over to using the avc so
that we'll get AVC denials.  Look to xselinux.c in Xorg as the canonical
modern example.  Not sure if dbusd or nscd have really been updated to
the latest interfaces.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
