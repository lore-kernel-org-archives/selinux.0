Subject: Re: 2.6.0-test3
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20030821172554.GD4481@vnl.com>
References: <1061468940.1665.16.camel@kusturica>
	 <200308212337.59952.russell@coker.com.au>  <20030821172554.GD4481@vnl.com>
Content-Type: text/plain
Message-Id: <1061491762.25855.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Aug 2003 14:49:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-08-21 at 13:25, Dale Amon wrote:
> Ouch. I'm just in the process of setting up a 2.6.0 test system
> to check out the "mainstream" selinux.
> 
> Are there compilable apps on the NSA sight that will work with
> a vanilla 2.6.0-test3?

The NSA site includes userland components ported to the new SELinux API
(and updated to the RH9 packages).  The userland port was mostly done by
Dan Walsh of RedHat.  Note that the new SELinux API and xattr support
was also back ported to the 2.4-based SELinux, so the same userland can
be used with the newer 2.4-based SELinux.  The older 2.4-based SELinux
is no longer being actively maintained, and will be moved to a
historical versions page along with the original SELinux in future
releases.  See http://www.nsa.gov/selinux/download5.html for the
2.6-based SELinux or http://www.nsa.gov/selinux/download3.html for the
new 2.4-based SELinux.  Colin Walters has worked on porting and
packaging the new components for Debian, so you may want to use his
packages if you are using Debian.

Note that there have been some patches to the SELinux module since
2.6.0-test3; there is a patch on the NSA site that includes some of
those changes, but we have also fed further changes up to Andrew Morton
since the last public release on the NSA site, and they are now in
Linus' BitKeeper tree as well.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
