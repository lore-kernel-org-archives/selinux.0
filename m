Date: Fri, 10 Jul 2009 08:56:01 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Thomas Liu <tliu@redhat.com>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        chrisw@sous-sol.org, sds@tycho.nsa.gov, eparis@parisplace.org,
        casey@schaufler-ca.com, etienne.basset@numericable.fr
Subject: Re: [PATCH 1/3] Move variable function in lsm_audit.h into SMACK
 private space
In-Reply-To: <1247148029.2276.9.camel@Ares>
Message-ID: <alpine.LRH.2.00.0907100855230.8531@tundra.namei.org>
References: <1247148029.2276.9.camel@Ares>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Jul 2009, Thomas Liu wrote:

> Moved variable function in include/linux/lsm_audit.h into the
> smack_audit_data struct since it is never used outside of it.
> 
> Also removed setting of function in the COMMON_AUDIT_DATA_INIT
> macro because that variable is now private to SMACK.
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
