Date: Sat, 11 Mar 2017 12:05:30 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: viro@zeniv.linux.org.uk, james.l.morris@oracle.com, serge@hallyn.com,
 paul@paul-moore.com, john.johansen@canonical.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] fs: switch order of CAP_DAC_OVERRIDE and
 CAP_DAC_READ_SEARCH checks
In-Reply-To: <1489166058-11789-1-git-send-email-sds@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.20.1703111205200.20298@namei.org>
References: <1489166058-11789-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 10 Mar 2017, Stephen Smalley wrote:

> generic_permission() presently checks CAP_DAC_OVERRIDE prior to
> CAP_DAC_READ_SEARCH.  This can cause misleading audit messages when
> using a LSM such as SELinux or AppArmor, since CAP_DAC_OVERRIDE
> may not be required for the operation.  Flip the order of the
> tests so that CAP_DAC_OVERRIDE is only checked when required for
> the operation.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>


Acked-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>
