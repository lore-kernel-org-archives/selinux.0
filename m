Subject: Re: selinux: Delete unnecessary variable assignments in
 policydb_index()
To: Paul Moore <paul@paul-moore.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <247c0e27-c442-3408-4f92-492629d61fbf@users.sourceforge.net>
 <CAHC9VhRHEDCRNVfOqw4mwJQD9PmESEcgyZ7xCEwHZKpiDSjnYw@mail.gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <1ae9af46-a3ca-33b8-d347-8983a22cb3cb@users.sourceforge.net>
Date: Mon, 27 Mar 2017 08:24:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRHEDCRNVfOqw4mwJQD9PmESEcgyZ7xCEwHZKpiDSjnYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> However, I agree with Casey that this patch is mostly just code churn
> so I'm going to drop this from your series.

How do you think about to return only constant error codes in this function?
Would it be acceptable to replace any statements “goto out;” with
“return -ENOMEM;” here instead?

Regards,
Markus
