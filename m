Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux RPM Version
Date: Mon, 22 Apr 2002 23:15:35 +0200
References: <72222DC86846D411ABD300A0C9EB08A101524353@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524353@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020422211536.0443D1862@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Apr 2002 14:19, Westerman, Mark wrote:
> > > Flask files
> > > /usr/lib/flask
> >
> > What files?
>
> access_vectors, initial_sids, and security_classes

Good idea, I'll do that in my next package.

> > /usr/sbin/se_dpkg
>
> 	Not included in the rpm version
>
> > /usr/sbin/se_apt-get
>
> 	What is this ?
>
> > /usr/sbin/se_dselect
>
>  	What is this ?

These are programs that are similar to run_init that run the Debian package 
management tools in a different context.  Currently I'm running these tools 
in the system_r role so that they can run /etc/init.d scripts in the correct 
context.  Also these programs re-authenticate the user, as we are 
re-authenticating for minor things like restarting a daemon we must also do 
so for more important actions such as upgrading the entire system!

I would send you the source for these programs, but it's just a trivial hack 
to run_init, and I'm not sure I like the current way it's working.

I think you'll need something like this for rpm to work correctly.  Also the 
Connectiva people will surely want the se_apt-get functionality.

> > Currently I'm just using an incrementally higher version number for my
> > packages while determining whether the changes can go into
> > the main packages.
>
> I am going to keep my naming method of the modified utilities.
> I think using a higher version number is confusing to an end user. I will
> keep with <utility>-selinux-<version>-<release> naming convention.
> I will add Obsoletes: to the rpm spec files and see if the --replacefiles
> in needed for an install.

I'll do the same for cases where I can't get the changes in the main package.

I expect to get the SE patches into the main Debian packages for stat, kdm, 
procps as soon as I get the selinux-small archive to compile on non-Intel 
architectures.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
