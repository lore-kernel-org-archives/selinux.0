Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBOH9PR1013695
	for <selinux@tycho.nsa.gov>; Mon, 24 Dec 2012 12:09:25 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so3588511eek.19
        for <selinux@tycho.nsa.gov>; Mon, 24 Dec 2012 09:08:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201212222332.AEH86121.SHLFVtJFOOFOMQ@I-love.SAKURA.ne.jp>
References: <50D205E2.9010203@schaufler-ca.com>
	<201212202302.GGH12474.tLSOMOVHFFJQOF@I-love.SAKURA.ne.jp>
	<50D34CA7.4030908@schaufler-ca.com>
	<201212222332.AEH86121.SHLFVtJFOOFOMQ@I-love.SAKURA.ne.jp>
Date: Mon, 24 Dec 2012 12:08:51 -0500
Message-ID: <CACLa4ptDNcPvVhxXV95vPY5D8a_z3NDeEDdj7KQbSh22MO-Q2w@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] LSM: Multiple concurrent LSMs
From: Eric Paris <eparis@parisplace.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>, Kees Cook <keescook@chromium.org>,
        SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Dec 22, 2012 at 9:32 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Casey Schaufler wrote:
>> On 12/20/2012 6:02 AM, Tetsuo Handa wrote:
>> > Several bugfixes for v11 patchset.
>> >
>> >   Fixed off-by-one bug in lsm_read().
>>
>> Where is the off-by-one error?
>>
>
>   list_for_each_entry(sop, &lsm_hooks[LSM_name], list[LSM_name]) {
>           strcat(data, sop->name);
>           strcat(data, ","); // <= Here. :-(
>   }
>
> If COMPOSER_MAX == 1, COMPOSER_NAMES_MAX is SECURITY_NAME_MAX+1.
> If strlen(sop->name) == SECURITY_NAME_MAX,
> strcat(data, sop->name) writes data[0...COMPOSER_NAMES_MAX] and
> strcat(data, ",") writes data[COMPOSER_NAMES_MAX...COMPOSER_NAMES_MAX+1].
> data[] needs to be one byte larger for writing trailing '\0'.

Seems like seq_read() is a good fit here...  Let libraries deal with
it and make it easier if someone one days comes up with a completely
dynamic solution.

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
