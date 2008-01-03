Date: Thu, 3 Jan 2008 08:54:08 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: naveen penumala <naveenspen@gmail.com>
Cc: subrata@linux.vnet.ibm.com, "Serge E. Hallyn" <serue@us.ibm.com>,
        ltp-list <ltp-list@lists.sourceforge.net>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [LTP] compilation error @ selinux tests
Message-ID: <20080103145408.GA22593@sergelap.austin.ibm.com>
References: <ab64ec20801020223j2d3816bcsa5b189cc1fb649ca@mail.gmail.com> <1199269629.4533.39.camel@subratamodak.linux.ibm.com> <ab64ec20801020358i2a1474ddmd667fe2344d6f08d@mail.gmail.com> <1199275642.4533.53.camel@subratamodak.linux.ibm.com> <ab64ec20801030405ie9b6525tff03d88bd8d74b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ab64ec20801030405ie9b6525tff03d88bd8d74b20@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting naveen penumala (naveenspen@gmail.com):
> please check...
> 
> when im building the selinx-tests using "make" command i'm getting following
> error
> 
> these are the files presented in selinux-testsuite.
> /home/penuman/LTP/ltp-full-20071231/testcases/kernel/security/selinux-testsuite
> # ls
> ChangeLog  Makefile  /policy  README  /refpolicy  /tests
> 
> this is the error i'm getting when building the tests.
> 
> /home/penuman/LTP/ltp-full-20071231/testcases/kernel/security/selinux-testsuite
> # make
> make[1]: Entering directory
> `/home/penuman/LTP/ltp-full-20071231/testcases/kernel/security/selinux-testsuite/tests'
> make[2]: Entering directory
> `/home/penuman/LTP/ltp-full-20071231/testcases/kernel/security/selinux-testsuite/tests/domain_trans'
> 
> make[2]: Nothing to be done for `all'.
> make[2]: Leaving directory
> `/home/penuman/LTP/ltp-full-20071231/testcases/kernel/security/selinux-testsuite/tests/domain_trans'
> /bin/sh: chcon: command not found

I assume this is the problem.  You need chcon.

> make[1]: *** [all] Error 127
> make[1]: Leaving directory
> `/home/penuman/LTP/ltp-full-20071231/testcases/kernel/security/selinux-testsuite/tests'
> 
> make: *** [all] Error 2
> 
> i had seen the patch file presented by Sergei, but i didnt find
> misc/check_sbin_deprecated.pl
> in selinux tests directory.

It's under misc/.  It gets called from ltp/testscripts/test_selinux.sh
to tweak the policy.  But I don't think it's related to your problem.
You just need to install chcon, and I'm not the best way to do that
under SuSE.

> i'm sorry if my view is wrong.
> 
> * I'm using SuSE linux.*
> 
> - Naveen P

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
