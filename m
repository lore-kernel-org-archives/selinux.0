Subject: Re: SELinux: Checking source code positions for the setting of error
 codes
To: Eric Paris <eparis@redhat.com>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <1484580399.19104.6.camel@redhat.com>
Cc: James Morris <james.l.morris@oracle.com>, Paul Moore <paul@paul-moore.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <22f22cfd-8843-5cfd-6207-f61c80e52b1f@users.sourceforge.net>
Date: Mon, 16 Jan 2017 19:31:02 +0100
MIME-Version: 1.0
In-Reply-To: <1484580399.19104.6.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> I have a personal style preference for
> 
> rc = -ENOMEM;
> val = kalloc();
> if (!val)
>   goto err;
> 
> vs
> 
> val = kalloc();
> if (!val) {
>   rc = -ENOMEM;
>   goto err;
> }
> 
> because it saves 1 line

Thanks for your feedback.


> and I think the compiler does the right/same thing.

* Did you check any corresponding code generation results in more detail?

* Can misplaced variable assignments result in unwanted run time consequences
  because of the previous approach for a control flow specification?

* How do you think about to achieve that error codes will only be set
  after a specific software failure was detected?

Regards,
Markus
