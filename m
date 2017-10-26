Date: Thu, 26 Oct 2017 11:11:09 +0200 (CEST)
From: James Morris <james.l.morris@oracle.com>
To: Matthew Garrett <mjg59@google.com>
cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
In-Reply-To: <20171026084055.25482-2-mjg59@google.com>
Message-ID: <alpine.LFD.2.20.1710261110260.14992@localhost>
References: <20171026084055.25482-1-mjg59@google.com>
 <20171026084055.25482-2-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 26 Oct 2017, Matthew Garrett wrote:

> The existing BPRM_CHECK functionality in IMA validates against the
> credentials of the existing process, not any new credentials that the
> child process may transition to. Add an additional CREDS_CHECK target
> and refactor IMA to pass the appropriate creds structure. In
> ima_bprm_check(), check with both the existing process credentials and
> the credentials that will be committed when the new process is started.
> This will not change behaviour unless the system policy is extended to
> include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
> credentials that it did previously.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>
