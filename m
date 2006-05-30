Subject: Re: SELinux and SID
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: Mario Fanelli <mario.fanelli@gmail.com>,
        SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <447C383B.5040808@gentoo.org>
References: <447c0b7f.192f5df9.1cbd.ffff9f01@mx.gmail.com>
	 <447C383B.5040808@gentoo.org>
Content-Type: text/plain; charset=utf-8
Date: Tue, 30 May 2006 11:40:52 -0400
Message-Id: <1149003652.524.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-30 at 08:19 -0400, Joshua Brindle wrote:
> Mario Fanelli wrote:
> >
> > I read that SELinux uses extended attributes to maintain SID/file 
> > mapping, but I have a Fedora Core 5 with an ext3 filesystem but if I 
> > use getfattr command on any file I don’t obtain nothing that resembles 
> > SID. Am I wrong?
> >
> > Where does SELinux store SID?
> >
> You have to tell it what attribute name you want
> 
> $ getfattr -n security.selinux .
> # file: .
> security.selinux="system_u:object_r:root_t:s0\000"

Note btw that security context strings are stored on the filesystem, not
the (non-persistent non-global) SIDs (which are only stored in the
in-core inodes).  Older versions of SELinux (pre-2.6) stored a separate
persistent SID in the on-disk inodes (with a per-fs mapping from
persistent SIDs to contexts), but that was eliminated when we migrated
to using xattrs.

getfattr only displays attributes in the user namespace by default.  To
display all attributes on a file, you'd do something like:
$ getfattr -m "" -d /path/to/file

Or to see attribute in just the security namespace:
$ getfattr -m "^security" -d /path/to/file

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
