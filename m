Date: Fri, 19 Apr 2002 19:07:49 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: SELinux RPM Version
Message-ID: <20020419190749.B26414@gricklegrass.epoch.ncsc.mil>
References: <72222DC86846D411ABD300A0C9EB08A101524351@csoc-mail-box.csoconline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524351@csoc-mail-box.csoconline.com>; from Mark.Westerman@csoconline.com on Fri, Apr 19, 2002 at 03:26:24PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 19, 2002 at 03:26:24PM -0500, Westerman, Mark wrote:
> I expect to release a beta version to sourceforge 
> of an rpm package of SELinux next week.

That is excellent news.  I think that will make things a lot easier
for many people.  Do you have a plan for "naming" the release?
SELinux is a complicated case since there are source/RPM/deb
releases for the parts of SELinux (e.g., fileutils) which may
need to be different for different "base" distributions (e.g.,
RedHat 7.1, Red Hat 7.3) and which may have both stable and
developmental kernel versions.  The best I've been able to
come up with so far (and I'm not very happy with it so I hope
you've come up with something better) is to name "Packages" in
the SourceForge, not RPM sense, something like:

Red Hat 7.2 SELinux Stable
Red Hat 7.2 SELinux Developer
Debian Woody SELinux Stable
Debian Woody SELinux Developer

and within each have "Releases" like 1.23SF that contain
files like fileutils-selinux-4.1-1.{tar.gz,src.rpm,i386.rpm,i686.rpm}

Among the drawbacks are that a new "release" to fix some
problem in a particular package (e.g., fileutils) requires
re-releasing all the files in the "release" which will
contain perhaps dozens of various .rpm files. I used a
completely different version numbering scheme to avoid
confusion with NSA base releases, but that makes it difficult
to know which NSA base release 1.23SF is based on.
 
> Current Configuration.
> 
> /etc/selinux/policy	The main policy directory 
> If the directory does not exist then the rpm 
> packages will create it and install example policy files.
> 
> /etc/selinux/setfiles	Same for the policy directory
> 
> The example policy is installed
> /usr/share/doc/selinux/examples/policy
> 
> 
> Flask files
> /usr/lib/flask

I'm not sure which files you mean to go here.  I think of
"Flask" largely as the kernel modifications, and they shouldn't
need a separate home.  It's Friday, what files am I forgetting?
 
> Libsecure
> /usr/lib/libsecure.a
> 
> All the added programs for selinux such as newrole
> will be install into /usr/bin
> 
> The include directory
> /usr/include/selinux
> 
> All packages such as 
> fileutils-4.1-4
> 
> have been renamed to
> 
> fileutils-selinux-4.1-4
> 
> This packages provides: fileutils
> 
> The provides is so other rpms can 
> meet requirements. 
> 
> All packages have been build for original spec files
> with the selinux patch added. So the will install into
> normal locations. 
> 
> the --replacefiles option must be used when installing.

I think if you use both Provides: fileutils-4.1-4 and
Obsoletes: fileutils-4.1-4 you don't need to --replacefiles
and fileutils-4.2 won't automatically upgrade (you'll have
to use a fileutils-selinux-4.2 or a fileutils-4.2 which
obsoletes fileutils-selinux).  At least that's how I read
the CHANGES file and dependencies files in /usr/share/doc/rpm-4.0.3
(look at 2.4.7 -> 2.4.8 in CHANGES and later.)  Note that I
have not tested this so I could be wrong about the effect.

Ideally, I think you would want a kernel package (kernel-selinux?)
that Provides: selinux (as a virtual package) so that packages
that require selinux (libsecure?) can Require: selinux and things
like, say logrotate, can use triggers to install policy, e.g., (off
the top of my head, so don't rely on it too heavily.)

     %triggerin -- selinux
     # Rebuild the policy with new logrotate files included in the policy
     # when logrotate installed (if selinux already is) or if and when
     # selinux is later installed.
     cd /etc/selinux/policy
     make reload
     make relabel < /usr/share/selinux/examples/filecontexts/logrotate

     %postun
     # Rebuild the policy without the logrotate files when removing
     # logrotate
     cd /etc/selinux/policy
     make reload

Of course, without the default policy being somehow linked to the
current policy this has some problems.   Some logic in a %pre or
%post trigger script may be able to compare the default and
current policies and make alterations to current if they're not
"too" different (e.g., only the users file has changed.)
 
> Comments or suggestions
> 
> 
> Mark
 
--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
