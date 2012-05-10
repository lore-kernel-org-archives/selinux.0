Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4ADK4Qr003084
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2012 09:20:04 -0400
Message-ID: <4FABC084.9010604@tresys.com>
Date: Thu, 10 May 2012 09:20:04 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
CC: Stephen Smalley <sds@tycho.ncsc.mil>, SELinux-NSA <selinux@tycho.nsa.gov>
Subject: Re: regression test of security policy
References: <CADyhKSVyfCxx9dAziaR0bcbPvXW4C6FnV4J-Jux7gaMrT+-L+g@mail.gmail.com> <1336140013.24121.13.camel@moss-pluto> <CADyhKSUTP2xpjDW1GbFeYm-pQpDSqpX5bvRvid=1xfzrXw3DjQ@mail.gmail.com> <CADyhKSXeT46RvyUKw_T_96GB3mRNnP0UU=R34Kq9Ho91NcDzRw@mail.gmail.com>
In-Reply-To: <CADyhKSXeT46RvyUKw_T_96GB3mRNnP0UU=R34Kq9Ho91NcDzRw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/06/12 14:51, Kohei KaiGai wrote:
> I tried to implement an infrastructure of regression test to cover
> wider test cases, without replacement of existing environment.
> 
> It consists of two portions. The first one is a new script support at
> checkpolicy command. It allows to give a script to check access
> control decision of the loaded policy, and print out its results
> towards a pair of security contexts.
> The other one is a test case in reference policy. It should contain
> a set of test cases described as a script of checkpolicy and expected
> result for each policy types (standard, mcs and mls). If and when
> someone applied a patch to the reference policy, he can confirm
> how it works or unexpected side-effect as differences from the
> expected results.
> 
> The current revision towards checkpolicy supports the following
> commands.
> 
> * access <scontext> <tcontext> <tclass>
> It prints all the allowed permissions for a pair of contexts.
> 
> * create <scontext> <tcontext> <tclass> [<objname>]
> It prints a security context to be assigned on a new object
> if and when <scontext> creates a new one under the <tcontext>.
> The <objname> is optional, but not supported yet, because
> libsepol does not support to query named type transition.
> 
> * boolean <bool name> [<new value>]
> It shows or turns on/off a particular boolean. It should be used
> to confirm permissions being allowed conditionally.
> 
> At the reference policy side, I create "regtest" directory to store
> test cases and expected results. I works towards only monolithic
> policy, so you can try the regression test as follows.
> 
>   [kaigai@iwashi refpolicy]$ make MONOLITHIC=y TYPE=mcs regtest
>       :
>   /usr/bin/checkpolicy:  policy configuration loaded
>   /usr/bin/checkpolicy:  writing binary representation (version 27) to policy.27
>     Regression Test for postgresql ... ok
>   Regression Tess Pass
> 
> This make target runs the test cases (*.test) stored in the "regress"
> directory to the checkpolicy, then it compares its output with
> expected results (*.expected).
> If regtest-$(TYPE).diff is not empty, it means diff command generate
> something different from expected results.
> 
> I'd like to have such kind of test in the reference policy, to cover
> wider range test cases at security policy side.
> It helps to improve the quality and to reduce the burden for testing.
> (In fact, I found a few bugs in mcs/mls rules during this development...)

I'm not adverse to this for refpolicy, but what worries me is the size and maintainability of the tests.  What you have in your patch for testing sepostgresql looks several times bigger than the sepostgresql policy itself.  It seems that the tests would be larger than the policy itself so that the constraints can be checked.  Additionally, the community (I'm including myself) isn't exactly good about keeping tests up to date (see tests in the toolchain, for example).

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
