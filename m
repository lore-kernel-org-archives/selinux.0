Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r084BxN5023726
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2013 23:11:59 -0500
Message-ID: <50EB9C7E.7090304@schaufler-ca.com>
Date: Mon, 07 Jan 2013 20:11:42 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v12 0/9] LSM: Multiple concurrent LSMs
References: <50EB7C50.3070605@schaufler-ca.com> <20130108140159.83c07fa6a680e355f024970f@canb.auug.org.au> <20130108145922.58ab8ad4796076c9d14b6197@canb.auug.org.au>
In-Reply-To: <20130108145922.58ab8ad4796076c9d14b6197@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/7/2013 7:59 PM, Stephen Rothwell wrote:
> Hi Casey,
>
> On Tue, 8 Jan 2013 14:01:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Let me ask Andrew's question:  Why do you want to do this (what is the
>> use case)?  What does this gain us?
>>
>> Also, you should use unique subjects for each of the patches in the
>> series.
> You probably also want to think a bit harder about the order of the
> patches - you should introduce new APIs before you use them and remove
> calls to functions before you remove the functions.
>
The unfortunate reality is that I couldn't find a good way to stage the
changes. It's a wonking big set of infrastructure change. I could introduce
the security blob abstraction separately but that is a fraction of the
change. If it would have gone through mail filters as a single patch I'd
have sent it that way.

I can spend time on patch presentation, and will if necessary. As it is,
I can start getting substantive commentary from beyond the LSM crowd, who
have already been extremely cooperative and often critical.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
