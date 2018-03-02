Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w22GuA51017526
 for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2018 11:56:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 3ztFn25jR5zJpBQ
 for <selinux@tycho.nsa.gov>; Fri,  2 Mar 2018 16:56:06 +0000 (UTC)
Received: from UPDC3CPA10_EEMSG_MP26.eemsg.mil (unknown [192.168.18.21])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 3ztFn24YF4zJnYV
 for <selinux@tycho.nsa.gov>; Fri,  2 Mar 2018 16:56:06 +0000 (UTC)
Message-ID: <1520009758.23261.2.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, anders.roxell@linaro.org
Date: Fri, 02 Mar 2018 16:55:58 +0000
In-Reply-To: <161e2bc0f58.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <20180301083316.GA6779@localhost.localdomain>
 <CAHC9VhQAnsSTK4V2w3+CiikR6465Jpnu7_vr=3VFEQch7LECtA@mail.gmail.com>
 <1519914989.3063.1.camel@btinternet.com>
 <161e2bc0f58.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Regression found when running LTP connect01 on
 next-20180301
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2018-03-01 at 13:03 -0500, Paul Moore wrote:
> On March 1, 2018 9:36:37 AM Richard Haines <richard_c_haines@btintern
> et.com> wrote:
> > On Thu, 2018-03-01 at 08:42 -0500, Paul Moore wrote:
> > > On Thu, Mar 1, 2018 at 3:33 AM, Anders Roxell <anders.roxell@lina
> > > ro.o
> > > rg> wrote:
> > > > Hi,
> > > > 
> > > > I was running LTP's testcase connect01 [1] and found a
> > > > regression
> > > > in linux-next
> > > > (next-20180301).  Bisect gave me this patch as the problematic
> > > > patch (sha
> > > > d452930fd3b9 "selinux: Add SCTP support") on a x86 target.
> > > > 
> > > > Output from the test(LTP release 20180118):
> > > > $ cd /opt/ltp/
> > > > $ cat runtest/syscalls |grep connect01>runtest/connect-syscall
> > > > $ ./runltp -pq -f connect-syscall
> > > > "
> > > > Running tests.......
> > > > connect01    1  TPASS  :  bad file descriptor successful
> > > > connect01    2  TPASS  :  invalid socket buffer successful
> > > > connect01    3  TPASS  :  invalid salen successful
> > > > connect01    4  TPASS  :  invalid socket successful
> > > > connect01    5  TPASS  :  already connected successful
> > > > connect01    6  TPASS  :  connection refused successful
> > > > connect01    7  TFAIL  :  connect01.c:146: invalid address
> > > > family ;
> > > > returned -1 (expected -1), errno 22 (expected 97)
> > > > INFO: ltp-pan reported some tests FAIL
> > > > LTP Version: 20180118
> > > > "
> > > > 
> > > > The output from the test expected 97 and we received 22, can
> > > > you
> > > > please
> > > > elaborate on what have been changed?
> > > > 
> > > > Cheers,
> > > > Anders
> > > > [1] https://github.com/linux-test-project/ltp/blob/20180118/tes
> > > > tcas
> > > > es/kernel/syscalls/connect/connect01.c#L146
> > > 
> > > Hi Anders,
> > > 
> > > Thanks for the report.  Out of curiosity, we're you running the
> > > full
> > > LTP test suite and this was the only failure, or did you just run
> > > the
> > > connect01 test?  Either answer is fine, I'm just trying to
> > > understand
> > > the scope of the regression.
> > > 
> > > Richard, are you able to look into this?  If not, let me know and
> > > I'll
> > > dig a bit deeper (I'll likely take a quick look today, but if the
> > > failure is subtle it might require some digging).
> > 
> > I'll have a look today.
> 
> One more thing I forgot to mention earlier, if there is a patch to
> fix this, could you please base it on top of the existing
> SELinux/SCTP patches that have already been merged, and not respin an
> earlier patch?
> 
> Thank you.


Just to keep you informed:

It appears that with the original hooks.c selinux_socket_connect()
function check: if (sk->sk_family == PF_INET) {, the test fell through
as sk->sk_family = 2 (AF_INET) with the error being picked up by the
caller - even though the test set an illegal family of 47 - but not on
the sk->sk_family, hence:

With the new check: if (address->sa_family == AF_INET) {, the address-
>sa_family = 47 and therefore treated it as an IPv6 address and failed
with -EINVAL. By a fluke this is what SCTP services expects when
invalid address family, however TCP and DCCP requires -EAFNOSUPPORT.

I can fix this with the following simple patch:
	switch (address->sa_family) {
	case AF_INET:
		addr4 = (struct sockaddr_in *)address;
		if (addrlen < sizeof(struct sockaddr_in))
			return -EINVAL;
		snum = ntohs(addr4->sin_port);
		break;
	case AF_INET6:
		addr6 = (struct sockaddr_in6 *)address;
		if (addrlen < SIN6_LEN_RFC2133)
			return -EINVAL;
		snum = ntohs(addr6->sin6_port);
		break;
	default:
		/* Note that SCTP services expect -EINVAL, whereas
		 * others expect -EAFNOSUPPORT.
		 */
		if (sksec->sclass == SECCLASS_SCTP_SOCKET)
			return -EINVAL;
		else
			return -EAFNOSUPPORT;
	}

This will pass the following LTP tests:
./runltp -pq -f connect-syscall
./runltp -pq -f net.sctp

The selinux-testsuite inet_socket and sctp tests all pass as well.

However: The selinux_socket_bind() function has the same issue that can
be fixed by the same type of patch.

So far I've tested three different patches to fix this problem and
this one above seems best. I'll post a patch based on this covering
the bind issue as well once I've done more testing.

I think the SCTP services should return -EAFNOSUPPORT for this (as
their sctp_connectx(3) man page states this), that will require kernel
patch and patches to their test services (plus of course may impact
some apps already out there ??).


> 
> --
> paul moore
> www.paul-moore.com
> 
> 
