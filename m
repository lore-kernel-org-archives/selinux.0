Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w08Jk7Sc015309
 for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2018 14:46:07 -0500
Received: by mail-it0-f44.google.com with SMTP id d137so9065372itc.2
 for <selinux@tycho.nsa.gov>; Mon, 08 Jan 2018 11:45:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515413905.3460.40.camel@linux.vnet.ibm.com>
References: <20180105211536.11611-1-mjg59@google.com>
 <20180105211536.11611-2-mjg59@google.com>
 <1515413905.3460.40.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 8 Jan 2018 11:45:48 -0800
Message-ID: <CACdnJuvNz8Rjj2rBe=VTZKhOOnd+eXgp51sesEQF5_A+s2k3VQ@mail.gmail.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V5 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jan 8, 2018 at 4:18 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2018-01-05 at 13:15 -0800, Matthew Garrett wrote:
>> The existing BPRM_CHECK functionality in IMA validates against the
>> credentials of the existing process, not any new credentials that the
>> child process may transition to. Add an additional CREDS_CHECK target
>> and refactor IMA to pass the appropriate creds structure. In
>> ima_bprm_check(), check with both the existing process credentials and
>> the credentials that will be committed when the new process is started.
>> This will not change behaviour unless the system policy is extended to
>> include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
>> credentials that it did previously.
>
> Refactoring IMA to pass the creds structure all the way down is a
> generic solution, but if the CREDS_CHECK rule is only being called
> from ima_bprm_check(), "container_of" the bprm->file returns a pointer
> to the bprm structure.  Perhaps you could limit the amount of
> refactoring needed based on the func.

Hm. This would avoid adding an argument to process_measurement(), but
we'd still need to pass additional information down through
ima_get_action() in order to get the creds and secid right. It feels a
little ugly to have process_measurement() recreate information rather
than having the caller pass it in, but I'm not going to object.

> Could you include in the patch description a simple method for testing
> this change?

Certainly.
