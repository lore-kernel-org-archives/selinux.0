Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBKHTVSp014491
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2012 12:29:31 -0500
Message-ID: <50D34ADB.4000709@schaufler-ca.com>
Date: Thu, 20 Dec 2012 09:28:59 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
CC: LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        SE Linux <selinux@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v11 3/9] LSM: Multiple concurrent LSMs
References: <50D205E2.9010203@schaufler-ca.com> <50D20931.8000705@schaufler-ca.com> <CAGXu5jK3J=QZmXetv0hv_sXcJdkHJ+hc2MAx0QQ=0f=bTMNppA@mail.gmail.com>
In-Reply-To: <CAGXu5jK3J=QZmXetv0hv_sXcJdkHJ+hc2MAx0QQ=0f=bTMNppA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/20/2012 9:04 AM, Kees Cook wrote:
> On Wed, Dec 19, 2012 at 10:36 AM, Casey Schaufler
> <casey@schaufler-ca.com> wrote:
>> Subject: [PATCH v11 3/9] LSM: Multiple concurrent LSMs
>>
>> Change the infrastructure for Linux Security Modules (LSM)s
>> from a single vector of hook handlers to a list based method
>> for handling multiple concurrent modules.
>>
>> Handle any preconditions in the hooks directly.
>> Treat allocation and procattr hooks specially.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>
>> ---
>>  security/security.c | 1481 ++++++++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 1180 insertions(+), 301 deletions(-)
>>
>> diff --git a/security/security.c b/security/security.c
>> index 8dcd4ae..75e2f6e 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> [...]
>> +       lsm_enlist(sop, LSM_kernel_module_request, sop->kernel_module_request);
> kernel_module_from_file needs to get added too, now that the new
> syscall has been merged in Linus's tree.

That will be in the next version of the patch.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
