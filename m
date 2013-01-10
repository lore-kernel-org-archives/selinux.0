Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0AGLS0I019754
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2013 11:21:28 -0500
Message-ID: <50EEEA66.7090208@schaufler-ca.com>
Date: Thu, 10 Jan 2013 08:20:54 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: John Johansen <john.johansen@canonical.com>
CC: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        eparis@redhat.com, keescook@chromium.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v12 3/9] LSM: Multiple concurrent LSMs
References: <50EB7C50.3070605@schaufler-ca.com> <50EB7FCD.3030107@schaufler-ca.com> <201301092211.CGF18746.LMOHJFOOFQtVSF@I-love.SAKURA.ne.jp> <50ED9A22.1090300@schaufler-ca.com> <50EE9BAE.5010101@canonical.com> <201301102159.JAE81243.tOFLQVOMHSJOFF@I-love.SAKURA.ne.jp> <50EEBD8B.2090000@canonical.com>
In-Reply-To: <50EEBD8B.2090000@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/10/2013 5:09 AM, John Johansen wrote:
> On 01/10/2013 04:59 AM, Tetsuo Handa wrote:
>> John Johansen wrote:
>>>>> In this case, we want to specify default name of LSM modules (which will be
>>>>> used when security= argument is not specified) via kernel config.
>>>> I am not considering runtime degeneracy.
>>>>
>>> I think that is fine at least for a first pass. Any run time degeneration support
>>> could come as a separate patch if needed.
>> Ubuntu anyway wants to specify CONFIG_DEFAULT_SECURITY via kernel config which
>> will be used when security= argument is not specified, doesn't it?
>>
> yes we will want to do something like that
>
>> Ubuntu's kernel config has
>>
>>   CONFIG_SECURITY_SELINUX=y
>>   CONFIG_SECURITY_SMACK=y
>>   CONFIG_SECURITY_TOMOYO=y
>>   CONFIG_SECURITY_APPARMOR=y
>>   CONFIG_SECURITY_YAMA=y
>>
>> and current patchset (i.e. removing CONFIG_DEFAULT_SECURITY option) means
>> automatically register SELinux -> TOMOYO -> AppArmor -> Yama (SMACK is not
>> registered due to conflicting hooks) if security= argument is not specified.
>> I think this is different from what default LSM users want. They will suddenly
>> see that SELinux and TOMOYO are registered after upgrading the release.
>> For default LSM users, I think Ubuntu wants to specify
>>
>>   static __initdata char chosen_lsm[COMPOSER_NAMES_MAX + 1] =
>> 	"apparmor,yama";
>>
>> or
>>
>>   static __initdata char specified_lsms[COMPOSER_MAX][SECURITY_NAME_MAX + 1] =
>>     { "apparmor", "yama" };
>>
>> via kernel config.
>>
> yeah

Grumble.

How about if I reintroduce CONFIG_DEFAULT_SECURITY and
treat it as security=CONFIG_DEFAULT_SECURITY if the
security= option is not specified on the command line?
How about a text line option? In the code choose_lsms
will get run on that string if there is no security=
specified. If it's left blank it gets treated as it is
today.

By using the same code to parse CONFIG_DEFAULT_SECURITY
as used to parse security=<foo> we get consistent
behavior.
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
