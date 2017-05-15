Date: Mon, 15 May 2017 13:48:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, serge@hallyn.com, james.l.morris@oracle.com,
 eparis@parisplace.org, sds@tycho.nsa.gov, paul@paul-moore.com,
 Sebastien Buisson <sbuisson@ddn.com>
Subject: Re: [PATCH v4 1/2] selinux: add brief info to policydb
Message-ID: <20170515204831.GA9744@infradead.org>
References: <1494872563-12467-1-git-send-email-sbuisson@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494872563-12467-1-git-send-email-sbuisson@ddn.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> Add security_policy_brief hook to give access to policy brief to
> the rest of the kernel. Lustre client makes use of this information
> to detect changes to the policy, and forward it to Lustre servers.
> Depending on how the policy is enforced on Lustre client side,
> Lustre servers can refuse connection.

NAK for any core kernel hooks for code that is purely in staging.
