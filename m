Message-ID: <1346936932.19997.21.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 5/5] LSM: SELinux changes to allow LSM stacking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
        SE Linux
	 <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Date: Thu, 06 Sep 2012 09:08:52 -0400
In-Reply-To: <1346855881.9153.21.camel@moss-pluto.epoch.ncsc.mil>
References: <5046B459.4070200@schaufler-ca.com>
	 <1346855881.9153.21.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-09-05 at 10:38 -0400, Stephen Smalley wrote:
> On Tue, 2012-09-04 at 19:09 -0700, Casey Schaufler wrote:
> > Subject: LSM: SELinux changes to allow LSM stacking
> > 
> > Change security blob accesses to use the lsm_get/lsm_set
> > interfaces. This requires removal of the cred pointer
> > poisoning in selinux_cred_free.
> > 
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> FWIW, passes the selinux-testsuite with SELinux and Yama enabled.

However, setting SELINUX=disabled in /etc/selinux/config and rebooting
with this kernel yields a kernel panic during reset_security_ops(),
called by selinux_disable().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
