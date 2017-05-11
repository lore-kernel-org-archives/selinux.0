MIME-Version: 1.0
In-Reply-To: <cc4d7595-4bfc-2339-0ac7-b443e65f6fd5@schaufler-ca.com>
References: <1493979053-16691-1-git-send-email-sbuisson@ddn.com>
 <cc4d7595-4bfc-2339-0ac7-b443e65f6fd5@schaufler-ca.com>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Thu, 11 May 2017 14:59:27 +0200
Message-ID: <CAPkE-bWHAV=bnj2=PXkW9=5wyzo=7M2rQz06ODyt828yU-BUVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: add brief info to policydb
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, serge@hallyn.com, james.l.morris@oracle.com,
 Eric Paris <eparis@parisplace.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Sebastien Buisson <sbuisson@ddn.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-05-05 20:33 GMT+02:00 Casey Schaufler <casey@schaufler-ca.com>:
> How do you see policy_brief being used by a modules
> with dynamic policy?

Policy's brief is computed on the binary representation every time the
policy is loaded, and when enforce or checkreqprot are changed. It
should not be a problem with a dynamic policy, unless I am missing
something.
