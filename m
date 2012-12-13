Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBDGcM8L003412
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 11:38:27 -0500
Message-ID: <50CA0495.2060706@schaufler-ca.com>
Date: Thu, 13 Dec 2012 08:38:45 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: eparis@redhat.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        john.johansen@canonical.com, keescook@chromium.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
References: <50C8A757.3050907@schaufler-ca.com> <1355327754.3527.37.camel@localhost> <50C8AFD1.1070905@schaufler-ca.com> <1355330026.3527.44.camel@localhost> <50C8B919.2060102@schaufler-ca.com> <201212132106.AFI82338.QMFHFLSJOtOOFV@I-love.SAKURA.ne.jp>
In-Reply-To: <201212132106.AFI82338.QMFHFLSJOtOOFV@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/2012 4:06 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> You're suggesting that we don't change the kernel until the
>> applications are fixed. No one is going to change the applications
>> until the kernel is fixed.
> People *can* change the applications before the kernel is changed if clear
> specification is provided. That's why my approach has migration period.

Of course they *can*, they just *won't*. The whole discussion
is based on the fact that people resist change so strenuously.

>> I have also added LSM identified files in /proc/.../attr:
>>
>> 	/proc/.../attr/current
>> 	/proc/.../attr/selinux.current
>> 	/proc/.../attr/apparmor.current
>> 	/proc/.../attr/keycreate
>> 	/proc/.../attr/selinux.keycreate
>>
>> SELinux applications and libraries can use simple logic to determine
>> what to do:
>>
>> 	if /sys/kernel/security/lsm does not contain "selinux"
>> 		Stop! No SELinux here!
>> 	if /sys/kernel/security/present does not contain "selinux"
>> 		Use selinux.current
>> 	else
>> 		Use current if you like.
>>
> Can we use prctl() interface instead of /proc/$pid/attr/$lsmname.$type ?
> I simply don't want to see flood of entries when "find /proc/" runs. ;-)

That cat is so long out of the bag that it's been adopted and spayed.

>
> prctl() can tell the caller whether specified LSM is enabled/presented or not
> via its return value.
>
> I think we can provide a simple utility that maps
>
>   echo something > /proc/pid/attr/selinux.current
>
> to
>
>   prctl(PR_SET_SECURITY, pid, "selinux", "current", "something")
>
> and
>
>   cat /proc/pid/attr/selinux.current
>
> to
>
>   prctl(PR_GET_SECURITY, pid, "selinux", "current", buffer)
>
> for calling prctl() from script programs.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
