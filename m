Date: Tue, 22 Jan 2002 09:46:39 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Gdm shut my system down
In-Reply-To: <1011642238.1618.13.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0201220929350.9412-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 21 Jan 2002, Justin Smith wrote:

> I know GDM is not really approved for use in SELinux, but I tried the
> patched version and got the following bizarre problem:

Which version of the modified GDM were you using?  What version of SELinux
were you using?  What is your base platform (RH7.1 or RH7.2)?

I haven't tried the newer version of the modified GDM yet, and I only ran
the older version for short periods when I reviewed it and merged the gdm
policy into the example policy.  As you mention, we don't really support
it.

> Jan 18 15:25:28 vorpal gdm(pam_unix)[5736]: session closed for user
> jsmith
> Jan 18 15:25:28 vorpal gdm[5736]: gdm_slave_xioerror_handler: Fatal X
> error - Restarting :0
> Jan 18 15:25:28 vorpal gnome-name-server[9333]: input condition is:
> 0x11, exiting
> Jan 18 15:25:31 vorpal modprobe: modprobe: Can't locate module
> char-major-81
> Jan 18 15:25:36 vorpal gdm[1184]: gdm_child_action: Master halting...
> Jan 18 15:25:38 vorpal kernel:
> Jan 18 15:25:38 vorpal kernel: avc:  denied  { write } for  pid=1184
> exe=/sbin/init path=/dev/initctl dev=03:01 ino=24199
> scontext=system_u:system_r:gdm_t tcontext=system_u:object_r:initctl_t
> tclass=fifo_file

It is interesting that there are no avc denied messages prior to the fatal
X error.  This would seem to suggest a bug in the modified gdm rather than
a policy problem, although it isn't certain.  The final avc denied message
is presumably just gdm trying to communicate with the init process to
perform an emergency shutdown due to the fatal X error.  At present, the
example policy doesn't authorize this, so it should probably be added.

> It looks to me as if the system did a normal shut down about 10 seconds
> after I logged out (?!).  Unless some student tip-toed into my office
> and shut it down from the GDM menu (I was giving both of my classes
> online exams that were postponed by this outage), somehow GDM shut the
> system down on its own. At least I'm not going to use GDM with SELinux
> for a while...

Yes, it looks like the modified GDM shut down your system due to some
internal failure from which it could not recover.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
