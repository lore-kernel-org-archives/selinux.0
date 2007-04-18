Message-ID: <4626175D.7030808@redhat.com>
Date: Wed, 18 Apr 2007 09:04:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>,
        Karl MacMillan <kmacmill@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: using cron in selinux policy
References: <46253DA7.40003@us.ibm.com>
In-Reply-To: <46253DA7.40003@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> Hey Dan,
>
> So, for some reason I can't schedule cron jobs with the custom user I 
> wrote for our test execution. From what I've looked it, I think I need 
> to call cron_per_role_template, but doing so causes the policy to fail 
> to build, claiming abat_crond_t is being defined twice. I'm guessing 
> calling cron_per_role_template explicitly is not the solution, and 
> that the interfaces I need to be calling have probably changed.
>
> If you have a moment, can you please look help me look at this?
>
> Thanks,
> Mike
This looks to me like a compiler problem.

policy_module(testadm,1.0.0)

userdom_admin_user_template(testadm)
cron_per_role_template(testadm, testadm_t, testadm_r)

Causes the same problem.  I also got this to happen with 
ethereal_per_role_template.  Compiler says that the type is defined 
twice, even though I only see it once.  However there is a gen_requires 
of the type before the declaration which might be causing the problem.

If I create a testadm.te file like above

make -f /usr/share/selinux/devel/Makefile
Compiling targeted test module
/usr/bin/checkmodule:  loading policy configuration from tmp/test.tmp
test.te:4:ERROR 'duplicate declaration of type/attribute' at token ';' 
on line 102058:
        type testadm_crond_t;
#line 4
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/test.mod] Error 1




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
