Date: Thu, 26 Oct 2017 11:04:59 +0200 (CEST)
From: James Morris <james.l.morris@oracle.com>
To: Matthew Garrett <mjg59@google.com>
cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
In-Reply-To: <20171026084055.25482-1-mjg59@google.com>
Message-ID: <alpine.LFD.2.20.1710261104330.14992@localhost>
References: <20171026084055.25482-1-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH V3 1/2] security: Add a cred_getsecid hook
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 26 Oct 2017, Matthew Garrett wrote:

> For IMA purposes, we want to be able to obtain the prepared secid in the
> bprm structure before the credentials are committed. Add a cred_getsecid
> hook that makes this possible.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Paul Moore <paul@paul-moore.com>


Acked-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>
