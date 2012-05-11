Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4BCxpFe006685
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2012 08:59:51 -0400
Received: by lbbgk8 with SMTP id gk8so2074393lbb.12
        for <selinux@tycho.nsa.gov>; Fri, 11 May 2012 05:59:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FABC084.9010604@tresys.com>
References: <CADyhKSVyfCxx9dAziaR0bcbPvXW4C6FnV4J-Jux7gaMrT+-L+g@mail.gmail.com>
	<1336140013.24121.13.camel@moss-pluto>
	<CADyhKSUTP2xpjDW1GbFeYm-pQpDSqpX5bvRvid=1xfzrXw3DjQ@mail.gmail.com>
	<CADyhKSXeT46RvyUKw_T_96GB3mRNnP0UU=R34Kq9Ho91NcDzRw@mail.gmail.com>
	<4FABC084.9010604@tresys.com>
Date: Fri, 11 May 2012 14:59:51 +0200
Message-ID: <CADyhKSU=0nDupacpDFHXcw_ypARGMQdgoGJAXQm7v21jt3MoGQ@mail.gmail.com>
Subject: Re: regression test of security policy
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.ncsc.mil>, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2012/5/10 Christopher J. PeBenito <cpebenito@tresys.com>:
> On 05/06/12 14:51, Kohei KaiGai wrote:
>> I'd like to have such kind of test in the reference policy, to cover
>> wider range test cases at security policy side.
>> It helps to improve the quality and to reduce the burden for testing.
>> (In fact, I found a few bugs in mcs/mls rules during this development...)
>
> I'm not adverse to this for refpolicy, but what worries me is the size
> and maintainability of the tests.  What you have in your patch for
> testing sepostgresql looks several times bigger than the sepostgresql
> policy itself.  It seems that the tests would be larger than the policy
> itself so that the constraints can be checked.  Additionally, the
> community (I'm including myself) isn't exactly good about keeping
> tests up to date (see tests in the toolchain, for example).
>
I could understand the maintenance burden.

How about your opinion to add Makefile support to run external
test cases? It will help contributors test their own patches being
submitted.

In my idea, it adds a new make target "regtest" with TESTCASE
argument that points to the *.test file.

  $ make TYPE=xxx MONOLITHIC=y TESTCASE=/path/to/testcases regtest

Then, makefile generates a monolithic policy chunk and kicks
checkpolicy with the new -s option that takes processed testcase
by m4.

The reason why I want refpolicy to provide such kind of infrastructure
is utilization of existing macro definitions to generate multiple
testcases from a single source.
Do you think it is reasonable to improve the quality of policy?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
