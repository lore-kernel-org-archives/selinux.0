Subject: Re: [LTP] compilation error @ selinux tests
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: naveen penumala <naveenspen@gmail.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
        ltp-list <ltp-list@lists.sourceforge.net>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <ab64ec20801020358i2a1474ddmd667fe2344d6f08d@mail.gmail.com>
References: <ab64ec20801020223j2d3816bcsa5b189cc1fb649ca@mail.gmail.com>
	 <1199269629.4533.39.camel@subratamodak.linux.ibm.com>
	 <ab64ec20801020358i2a1474ddmd667fe2344d6f08d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 02 Jan 2008 17:37:22 +0530
Message-Id: <1199275642.4533.53.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well, just few minutes back, i have updated selinux by one patch
submitted by Sergei. Just check whether that patch solves your problem.

--Subrata

On Wed, 2008-01-02 at 17:28 +0530, naveen penumala wrote:
> subrata,
> 
> i tried with the latest version of LTP, even though i'm getting same
> problem for selinux tests.
> lemme knw one thing, is their any package we need to install for
> chcon. cause "chcon" executable in not creating in /bin directory at
> testcases. here we are using SuSE linux. 
> 
> -Naveen
> 
> On Jan 2, 2008 3:57 PM, Subrata Modak <subrata@linux.vnet.ibm.com>
> wrote:
>         On Wed, 2008-01-02 at 15:53 +0530, naveen penumala wrote:
>         > Hi,
>         >
>         > When i tried to compile the selinux-testsuite i faced the
>         following
>         > problem.
>         >
>         >
>         ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests # 
>         > make
>         >
>         
>         
>         I would say that you are using an unstable se-linux in LTP. We
>         have
>         ported some stable patches already which is available on
>         ltp-full-20071231 and not in ltp-full-20071130. Please use the
>         latest 
>         one to work.
>         
>         --Subrata
>         
>         > make[1]: Leaving directory
>         >
>         `/home/penuman/New_tests/ltp/ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests/ domain_trans'
>         > /bin/sh: chcon: command not found 
>         > make: *** [all] Error 127
>         >
>         >
>         >
>         ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests/domain_trans # vi Makefile
>         >
>         > ln -f selinux_domain_trans.sh ../../../../../bin/
>         >
>         > but i didn't find the "chcon" executable in the bin
>         > (/ltp-full-20071130/testcases/bin) directory.
>         >
>         > how chcon executable will create.
>         >
>         > and I'm using SuSE Linux. 
>         >
>         >
>         > Thanks,
>         > Naveen P
>         >
>         >
>         
>         >
>         -------------------------------------------------------------------------
>         > This SF.net email is sponsored by: Microsoft
>         > Defy all challenges. Microsoft(R) Visual Studio 2005. 
>         > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>         > _______________________________________________ Ltp-list
>         mailing list Ltp-list@lists.sourceforge.net
>         https://lists.sourceforge.net/lists/listinfo/ltp-list
>         
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
