Date: Fri, 10 Jul 2009 09:02:03 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Thomas Liu <tliu@redhat.com>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        chrisw@sous-sol.org, sds@tycho.nsa.gov, eparis@parisplace.org,
        etienne.basset@numericable.fr, casey@schaufler-ca.com
Subject: Re: [PATCH 3/3] Wrap SMACK and SELINUX audit data structs in
 ifdefs
In-Reply-To: <1247148031.2276.11.camel@Ares>
Message-ID: <alpine.LRH.2.00.0907100901510.8531@tundra.namei.org>
References: <1247148031.2276.11.camel@Ares>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Jul 2009, Thomas Liu wrote:

> Wrapped the smack_audit_data and selinux_audit_data
> structs in include/linux/lsm_audit.h in ifdefs so that the
> union will always be the correct size.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
