Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2RIKn5D028109
 for <selinux@tycho.nsa.gov>; Mon, 27 Mar 2017 14:20:56 -0400
Received: by mail-vk0-f45.google.com with SMTP id r69so61830430vke.2
 for <selinux@tycho.nsa.gov>; Mon, 27 Mar 2017 11:20:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ae9af46-a3ca-33b8-d347-8983a22cb3cb@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <247c0e27-c442-3408-4f92-492629d61fbf@users.sourceforge.net>
 <CAHC9VhRHEDCRNVfOqw4mwJQD9PmESEcgyZ7xCEwHZKpiDSjnYw@mail.gmail.com>
 <1ae9af46-a3ca-33b8-d347-8983a22cb3cb@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Mar 2017 14:20:50 -0400
Message-ID: <CAHC9VhSPv11X=HYV3qoiMV4GDg4VDaxvNYru0xDjU4Y2t27CPg@mail.gmail.com>
Subject: Re: selinux: Delete unnecessary variable assignments in
 policydb_index()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Mar 27, 2017 at 2:24 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> However, I agree with Casey that this patch is mostly just code churn
>> so I'm going to drop this from your series.
>
> How do you think about to return only constant error codes in this function?
> Would it be acceptable to replace any statements “goto out;” with
> “return -ENOMEM;” here instead?

Yes.

-- 
paul moore
www.paul-moore.com
