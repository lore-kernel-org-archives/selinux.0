Subject: Re: Suse selinux policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dale Amon <amon@vnl.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050720165937.GB18922@vnl.com>
References: <20050718234403.GA30685@vnl.com>
	 <20050720103541.GB8124@thorium.jmh.mhn.de> <20050720165937.GB18922@vnl.com>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 10:03:31 -0400
Message-Id: <1122300211.2351.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-07-20 at 17:59 +0100, Dale Amon wrote:
> It doesn't make sense to me. Why would the kernel in
> SLES9 have selinux compiled in (with default boot of
> selinux=0) and the CD's contain libselinux, policycoreutils,
> etc, etc, and no policy? The Novell OES version uses
> the same disk set as well, I have been working
> with both over the last month.

Just my opinion:  If they include policy in SLES, they have to support
it too.  Whereas just including the SELinux code but disabling it by
default and not providing a policy themselves lets them say that they
have "SELinux support" without having to deal with the time and effort
required to properly configure a policy for the entire distro, integrate
support throughout their userland, test the system with a loaded policy
in enforcing mode, etc.  Pushes the burden to the customer, while still
claiming the advertising benefit of claiming that they support SELinux.
Note that their press release about acquiring AppArmor/SubDomain claimed
that they were the first commercial distro to support SELinux, where
"support" apparently just means "code included", and not even all of
that.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
