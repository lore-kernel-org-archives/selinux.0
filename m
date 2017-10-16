Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9GLKFut024068
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 17:20:15 -0400
Received: by mail-io0-f180.google.com with SMTP id n137so1053iod.6
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 14:20:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171017000303.46e56b42@totoro>
References: <20171016203709.11199-1-mjg59@google.com>
 <20171016203709.11199-2-mjg59@google.com>
 <20171017000303.46e56b42@totoro>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 16 Oct 2017 14:20:11 -0700
Message-ID: <CACdnJusGBTLVDtc4h3ycgZsFBhA8Ly2HZ559iPTOAOP9vZrnyg@mail.gmail.com>
To: Mikhail Kurinnoi <viewizard@viewizard.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] IMA: Support using new creds in appraisal
 policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 16, 2017 at 2:03 PM, Mikhail Kurinnoi
<viewizard@viewizard.com> wrote:
> В Mon, 16 Oct 2017 13:37:09 -0700
> Matthew Garrett <mjg59@google.com> пишет:
>>  #define IMA_BPRM_APPRAISED   0x00002000
>>  #define IMA_READ_APPRAISE    0x00004000
>>  #define IMA_READ_APPRAISED   0x00008000
>> +#define IMA_CREDS_APPRAISE   0x00004000
>> +#define IMA_CREDS_APPRAISED  0x00008000
>
> Is this correct, that the IMA_CREDS_APPRAISE and IMA_CREDS_APPRAISED
> same as IMA_READ_APPRAISE and IMA_READ_APPRAISED?

Definitely not correct, good catch. I'll resend with that fixed if
people feel this approach is reasonable.
