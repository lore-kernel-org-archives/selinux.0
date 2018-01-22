Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0M6Ij4t006346
 for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2018 01:18:46 -0500
To: Matthew Garrett <mjg59@google.com>,
 linux-integrity <linux-integrity@vger.kernel.org>
Cc: James Morris <james.l.morris@oracle.com>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 LSM List <linux-security-module@vger.kernel.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20180108213620.170042-1-mjg59@google.com>
 <CACdnJuutxPpzr4DPaJLuffHCcMWQN_22dA6wzxMQq3XR2R6+Gg@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8b7f9729-af09-a59e-0cd0-8db58d82ea56@schaufler-ca.com>
Date: Sun, 21 Jan 2018 22:14:36 -0800
MIME-Version: 1.0
In-Reply-To: <CACdnJuutxPpzr4DPaJLuffHCcMWQN_22dA6wzxMQq3XR2R6+Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH V6 1/2] security: Add a cred_getsecid hook
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 1/21/2018 9:27 PM, Matthew Garrett wrote:
> On Tue, Jan 9, 2018 at 8:36 AM, Matthew Garrett <mjg59@google.com> wrote:
>> For IMA purposes, we want to be able to obtain the prepared secid in the
>> bprm structure before the credentials are committed. Add a cred_getsecid
>> hook that makes this possible.
> Any feedback on this version of the set?


Sorry for the delay. I'm having a mindset crisis on secids just
now, and I'm not completely sure if I have any issue with this
particular hook. Don't wait for me. If everyone else is OK with
it, go ahead.
