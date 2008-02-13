Subject: RE: Disabling SELinux by kernel vulnerability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Waide, Ronan" <waider@amazon.com>
Cc: Yuichi Nakamura <himainu-ynakam@miomio.jp>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <263FA95FD38963459CE5DF116730557A12A4E39E91@EX-DUB2-A.ant.amazon.com>
References: <20080212234339.40551955.himainu-ynakam@miomio.jp>
	 <1202841912.24250.105.camel@moss-spartans.epoch.ncsc.mil>
	 <263FA95FD38963459CE5DF116730557A12A4E39E91@EX-DUB2-A.ant.amazon.com>
Content-Type: text/plain
Date: Wed, 13 Feb 2008 09:22:49 -0500
Message-Id: <1202912569.24250.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-13 at 12:06 +0000, Waide, Ronan wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> > From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> > On Behalf Of Stephen Smalley
> > It would be more useful to just build a kernel with a config that
> > disabled the support for permissive mode and runtime disable
> > altogether;
> 
> Is this the current recommended way of preventing SELinux from being
> switched off? There's a FAQ somewhere that used suggest disabling a
> particular macro in the policy build (which I can't recall off the top
> of my head) but by the time I got around to trying it out it on a test
> system the technique no longer worked.

The policy-based approach only controls the ability to change enforcing
mode or reload policy via the corresponding kernel interfaces.  I think
the secure_mode_policyload boolean exists in current policy to let you
disable the ability to change enforcing mode or reload policy.  But that
doesn't help with exploitation of a kernel flaw that permits writing to
kernel memory, which is what we are talking about here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
