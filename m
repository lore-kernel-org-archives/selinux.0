Date: Thu, 20 Dec 2001 11:01:02 -0500 (EST)
From: Noah silva <nsilva@atari-source.com>
To: Stephen Smalley <sds@tislabs.com>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: Debian SE Linux ?
In-Reply-To: <Pine.GSO.4.33.0112201041530.16420-100000@raven>
Message-ID: <Pine.LNX.4.21.0112201057460.27491-100000@sparcy.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > options.  (I am sure it is in the FAQ somewhere, and I am just blind
> > though.).
> 
> Just for future reference, this is discussed in step 19 of the README and
> in the help text (from the make menuconfig) for the Development option.
> When built with the Development option, the SELinux module starts in
> permissive mode and can be toggled into enforcing mode using the
> avc_toggle program. 

I would think that having it in development mode then could be somewhat of
a security hazard in itself. (if an attacker were somehow able to run the
avc_toggle program).  I assume it is recommended to turn off the
development mode for production systems after developing the policies on a
test system.

> But be sure that the policy configuration is
> sufficient for your system to continue operating before toggling into
> enforcing mode.

lol I suppose that could be a problem.  I am, however keeping several
kernels on the test machien at this point for recovery from any mistakes I
make.

-- noah silva  


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
