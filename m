Date: Wed, 3 Apr 2002 17:04:34 -0500
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>, SeLinux@tycho.nsa.gov,
        sds@tislabs.com, pal@tycho.nsa.gov
Subject: Re: Policy
Message-ID: <20020403170434.B3493@gricklegrass.epoch.ncsc.mil>
References: <72222DC86846D411ABD300A0C9EB08A10152432C@csoc-mail-box.csoconline.com> <20020403210620.2CCD23CE93@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020403210620.2CCD23CE93@lyta.coker.com.au>; from russell@coker.com.au on Wed, Apr 03, 2002 at 11:06:19PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 03, 2002 at 11:06:19PM +0200, Russell Coker wrote:
> On Wed, 3 Apr 2002 22:43, Westerman, Mark wrote:
> > On Wednesday, April 03, 2002 2:12 PM, Russell wrote:
> > > How about the following for distributions other than Slackware:
> > > /usr/bin
> > > /usr/sbin
> > > /usr/include/selinux
> > > /usr/lib
> > > /usr/share/man
> > > /etc/policy
> >
> > The reason I was putting every thing under /usr/local/selinux
> > was to get away from any distributions quirks. I really
> 
> The FHS is there to get away from quirks of distributions.  The locations I 
> suggested comply with the FHS.

I am a strong proponent of FHS compliance, particularly for SELinux, where we
would like to be relatively distribution neutral.  My reading of the FHS (2.2)
is that the choice is really between /usr/{bin,sbin,include,lib,share} and
/usr/local/{bin,sbin,include,lib,share} and /opt/selinux.  I think I could
make sensible arguments for any of the three and maybe even /usr/local/selinux,
although the FHS seems pretty much silent on the organization of /usr/local
after installation.

The most compelling argument for me, though is that I believe the SELinux
utilities are being installed to "replace or upgrade software in /usr" as
described in section 4.9.1.  We have often said that we would like the
changes in the utilities to be transparent on a non-SELinux system and
carried by the upstream packages.  From that perspective, the utilties are
direct replacements and I would argue that binary packages should replace
the equivalent non-SELinux packages on an SELinux system.  (I suspect
several people will strongly disagree with me on that point.)  For people
building it from source, I think they must have the option to install in
/usr/local/{bin,sbin,include,lib,share} because I think that makes it far
more clearly "locally maintained" software.  That may be an inconsistent
view of the world, but that's the way I see it.
 
> > have no argument about where to put the files, I would
> > like a consciences. Also we have to get the folks at the NSA
> > to agree.
> 
> Last time this issue was discussed here most people seemed to disagree with 
> me (but the NSA people weren't saying much).
> 
> As with all Debian packages, my packages will comply with the FHS regardless 
> of what happens in the upstream distribution.
> 
> > I want to start building packages for selinux, I just don't
> > want to do a lot of rework when the location changes. I do think
> 
> It shouldn't be that difficult to change location.
> 
> > I do like Russell's Idea about two separate locations for the
> > policy files.
> 
> Standard proceedure for Unix software distribution in my experience...

The policy has its own unique complications.  I think it would be great
to allow packages to modify the default polic(ies) when they are installed
so that the default polic(ies) include(s) the statements from all installed
packages.  Then there are the issues of the serious nature of overwriting a
local custom policy (very bad) and the potential to share policies.  They
are, after all, architecture neutral and likely to be the same for large
collections of hosts.  Considering all that and the FHS, my current thinking
is that /usr/share/selinux/{setfiles,policy}/current should contain the
"live" policy and initial file labels.  It should be legal for those to be
symlinks to /usr/share/selinux/{setfiles,policy}/{server,client,firewall}
or other example policies.  (Think of the current example policy as living
in /usr/share/selinux/{setfiles,policy}/server.)  New packages should then
be able to add policy and files to whatever common broadly supported policies
they know about and rebuild and reinstall "current" which will rebuild the
site specific policy or whichever one of the common policies it points to.
But that's just me talking, not an NSA position or even my personal "final
answer."  I think this needs some more discussion.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
