Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA7J5DSf025501
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2003 14:05:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA7J5BKl028789
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2003 19:05:11 GMT
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
        by jazzband.ncsc.mil  with SMTP id hA7J5A5m028775 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2003 19:05:11 GMT
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Paul Dwerryhouse <paul@dwerryhouse.com.au>, selinux@tycho.nsa.gov
Subject: Re: SELinux kernel RPMs for SuSE.
Date: Fri, 7 Nov 2003 19:28:11 +0100
References: <20031107093210.GA1052@localhost>
In-Reply-To: <20031107093210.GA1052@localhost>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7Q+q/Ne6N3mCpGc"
Message-Id: <200311071928.11502.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_7Q+q/Ne6N3mCpGc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Freitag, 7. November 2003 10:32, Paul Dwerryhouse wrote:
> Hi all,
>
> In September, I built a bunch of SELinux userspace RPMs for SuSE
> Linux 8.2. I have now ported the 2.4 backport of the 'new'
> SELinux code to Hubert Mantel's SuSE default kernel 2.4.21-121,
> and subsequently have built an RPM of the kernel itself.

Thanks for the new SuSE packages.
I've attached a patch for mkinitrd to copy all necessary SELinux 
staff in the initial ramdisks. The option -S enabled this.

Ciao

Carsten

--Boundary-00=_7Q+q/Ne6N3mCpGc
Content-Type: application/x-gzip;
  name="mkinitrd.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mkinitrd.diff.gz"

H4sICCnjqz8AA21raW5pdHJkLmRpZmYArVZtc5tGEP4Mv2KLNcm4gCRQ9GIcuU6nbiYzcd2p009N
R0Fwsi4CjnKHa6Xpf+/ucQjZUZxOGywj3d7evjz7cuv7PuQbXnBVpX1R8RsrHA5HPn6CGQSzaDSJ
xuP+sH3AHQbDoe267u5UcyAI/GEIwSgaB1E4++TA+Tn44TD0JuDS1xTOz22wAHwJkn9gsHtepCnI
MovlGuKC57HiosBfKSyFUDKpGCtACTAGNzIErHj2QMbVxSVUTMuWdVmKShlmBSovFymvDDOuAFce
pGwV15mSJN4ZINmxXTpwDfef1yJO4friNS/qOyhFxpOt1m+DveOp0FjSEXXH1JqRHpYoUW31ipig
jCvFtZNcQi7qQrEULbDhkee+pU4D7miiwR1NDbhLY8LccWyD6NyJayVwKVhOZFeyjLzQLDYcQVwl
a67QxLpCY1nJihQ/kKzj4obJyNYM83d1EecM/Pxdo3n8DFW64XjShvX01AYm4wSF+n+uKTQ3TIkS
DY7Wm4hHebSM0khEMlIRxHAKqbDdLzFet5xgJbFk0IsxCXBhvY0+vv3u2BCvfn7z4peXZseyNscW
S9aIkr/BbPijRvwlbFhVsAwyLjX86ItilUHxZKxRPJl6s8YXS3tjWerYMnkzN0raTdeyro+bwOzw
3DJJ2dMeXh9btYxvWCdPw0MaR1ON3mg6M+g1kWsCtii5jkUTx16bVYNaVgO5jis2aPgGmE45k4Ok
ripWKIdimcd3PK9zUym6ymwfC+qGLZaZSDZyHlB92u592pho0NB4IVIm56EmkUz/6/1p5yezETk/
mU13zh/9/8eGgrF0kfFlMrf938AAl93mDswhoH7hF0jFKnBo4fRqyRDqW2QiTkNcx3LxfiXNKhWL
D6ukdOB3ePJkT0Fgu19bg16ZVDqgD0HiKyClOypxnVJPKahvSIVdM1nINcuy+WDJiwGmiMZ7OqYs
c6eT0Dtp0vvbY5Mgi5Td8gSj3WUZUgZ/KbUNPHyF3gdWCa+os8zDkhnSK6BXSC/6T7nceKvl0EtE
IUXGvDwd/k3JTk/TDvSv2ziDpAQ/ht591dCjCssLRZptn5iRr7fvTsdCbuEdEZ5pM8ks+PgRWFWJ
Cp6BUwgDA+hzWIy2e7TPbbv/Sv6jMuGBCF7IXKT3ZRjaQTvH+zIbRqe9RY7g1QrYHfYo6UEiyi3E
mRSGq9+c6Yss9YArujrwZozp6lhu8RZJa8UzCStR6bDPQn03zEahF0x03M0tlXe2ZmnakpMUy1P/
WvEGpuZtsq7LTJNybnOsabRY2+3daO5dp2XIN3Tr+mWn1Ij6PANTCTJhW+Nq23IPHpGHiLe7JsV2
2XxQVHN994Px4yo/J1P3YYpyhjPBwswC96zZ32mkaEzbKGvMnh59AybfnsJZL7tbVMne9llLolCe
jKcUypPpyAvalnlx9eN/CBcksdrJhufPSQqWCNmrpxNzDlrbm/DS8MOLmwfzT7/fxyjr6YUGLHN0
JaEQBYMWRdirgfDsCXbOT8H7Qphst260dJGxXW258d/ganx/2HW7Lmkd8J7wDYaz0BuBGwTDk7ZY
GrFYiwp69F4keC3aLrGPAx0O+gpCYnapQsm8rvZNsaI5lz+9eXX54uXFXmOg4sgKGoObIwUNvh2j
piFbWYklo7xxMUTf8yLGEXJv9NQD8j6MVP8IIHUATaeQcZyAXbcrmk5JC+WhzcPl4DZefqGmnMfF
dJzOTuLBinqA3N4WHURYyM3Lqx9+fX2B8KPx+ud1M1fumvQtq5YCZ0Ss4AFemgRrneHQ1GvmwYE5
tuc7cuH5FHPY/gdkgUlyJw0AAA==

--Boundary-00=_7Q+q/Ne6N3mCpGc--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
