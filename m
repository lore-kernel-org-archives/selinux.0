Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2TFf1Do006098
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 10:41:02 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2TFe1cn020428
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 15:40:01 GMT
Subject: Re: Desktop apps interoperability
From: Colin Walters <walters@redhat.com>
To: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>
Cc: selinux@tycho.nsa.gov, Rogelio Serrano <rogelio.serrano@gmail.com>,
   Dale Amon <amon@vnl.com>
In-Reply-To: <1112104457.4339.21.camel@moss-spartans.epoch.ncsc.mil>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <1111986213.1514.77.camel@cobra.ivg2.net>
	 <1111987652.1514.97.camel@cobra.ivg2.net> <20050328100140.GB3430@lkcl.net>
	 <a9951d2a0503280217234c3f65@mail.gmail.com>
	 <20050329113321.GC24833@vnl.com>
	 <1112104457.4339.21.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 10:39:58 -0500
Message-Id: <1112110798.3741.24.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-29 at 08:54 -0500, Stephen Smalley wrote:
> On Tue, 2005-03-29 at 12:33 +0100, Dale Amon wrote:
> > I will run screaming if someone imports the registry
> > concept into Unix.
> 
> Better start running then.  gconf is already being used as a registry,
> and there is a linux registry aka elektra project as well.

People very often confuse "the registry concept" with a specific
implementation which they may have had a bad experience with in the past
or have heard rumors of other people having a bad experience with.

Having some sort of sane mechanism for locating, managing, and
monitoring preferences is pretty critical to writing desktop
applications.  For example, one thing that GConf provides is
notification of preference changes.  This is a fundamental basis for a
lot of how GNOME's "instant-apply" feature works, e.g. if you change the
theme all apps automatically update.  Doing this kind of thing with
"text files" or whatever is going to be hackish at best.

To bring this discussion somewhat back on topic, Luke is right in that
in order to write a strong SELinux policy for desktop applications, we
really need to have fine-grained separation between user data (i.e.
OpenOffice documents), user preferences, highly sensitive data such as
GPG keys, and random other junk that apps dump in $HOME like error logs.

Also relating to the registry: Once we finish D-BUS, the plan is to make
GConf be a userspace object manager; for example, to allow Mozilla the
ability to read but not write the "http proxy" GConf key, or to disallow
it from reading the WEP keys that NetworkManager currently stores there
(which is wrong, but...).  Having fine-grained labeling on preference
keys is much nicer than granting user_mozilla_t access to user_home_t,
which grants kind of unconstrained read access to everything, and is
better than trying to maintain a text file per key in some hypothetical
"text file registry" just so that we can have individual labels on them.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
