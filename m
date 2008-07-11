Subject: Re: checkmodule error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <487752E7.8040907@redhat.com>
References: <200807112205.26358.russell@coker.com.au>
	 <1215778833.31554.88.camel@moss-spartans.epoch.ncsc.mil>
	 <487752E7.8040907@redhat.com>
Content-Type: text/plain
Date: Fri, 11 Jul 2008 08:35:59 -0400
Message-Id: <1215779759.31554.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-07-11 at 08:32 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Fri, 2008-07-11 at 22:05 +1000, Russell Coker wrote:
> >> # /usr/bin/checkmodule -M base.conf
> >> /usr/bin/checkmodule:  loading policy configuration from c.conf
> >> libsepol.expand_module: Error while indexing out symbols
> >> /usr/bin/checkmodule:  expand module failed
> >>
> >> According to the archives the above problem was solved almost two months ago.  
> >> I've tried using the latest checkmodule and libraries from Fedora 9.  Are 
> >> they not new enough?
> >>
> >> I've tried to upgrade to Rawhide, but yum doesn't seem to be selecting mirrors 
> >> that work at the moment.
> > 
> > Latest refpolicy requires the user and role remapping support in order
> > to move roles into modules.
> > The support was added in libsepol 2.0.29 and checkpolicy 2.0.16,
> > committed upstream 2008-05-27 (after Fedora 9 GA).
> > 
> > Don't know if Dan would be willing to pull newer toolchain into F9
> > (cc'd).
> > 
> I don't think there is much risk in doing this if you think it would be
> helpful.  I am probably going to pull in the updated
> libselinux/policycoreutils also.

Yes, I'd update them all together (checkpolicy, libsepol, libselinux,
libsemanage, policycoreutils, sepolgen).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
