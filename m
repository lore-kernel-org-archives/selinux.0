Date: Mon, 9 Oct 2017 12:52:34 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>
In-Reply-To: <1507217234.27146.14.camel@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1710091250460.23916@namei.org>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-10-sds@tycho.nsa.gov>
 <1507217234.27146.14.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [RFC 09/10] selinux: add a selinuxfs interface to
 unshare selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 5 Oct 2017, Stephen Smalley wrote:

> inet_socket test failures are expected due to running in a non-init
> network namespace; they don't work even without unsharing the selinux
> namespace.

Do these results all look as expected?

Test Summary Report
-------------------
fdreceive/test         (Wstat: 0 Tests: 3 Failed: 1)
  Failed test:  3
inherit/test           (Wstat: 0 Tests: 3 Failed: 1)
  Failed test:  1
file/test              (Wstat: 0 Tests: 16 Failed: 1)
  Failed test:  8
bounds/test            (Wstat: 0 Tests: 24 Failed: 5)
  Failed tests:  3, 6, 12, 21, 23
mmap/test              (Wstat: 0 Tests: 46 Failed: 2)
  Failed tests:  9, 13
inet_socket/test       (Wstat: 3584 Tests: 33 Failed: 14)
  Failed tests:  1, 3, 5-6, 8, 16, 18, 20, 22, 25-26, 28
                30, 32
  Non-zero exit status: 14
overlay/test           (Wstat: 3072 Tests: 121 Failed: 12)
  Failed tests:  1, 25, 27, 39-40, 57, 63, 87, 89, 98-99
                116
  Non-zero exit status: 12
Files=51, Tests=485, 28 wallclock secs ( 0.60 usr  0.13 sys +  2.67 cusr  
3.76 csys =  7.16 CPU)
Result: FAIL
Failed 7/51 test programs. 36/485 subtests failed.


-- 
James Morris
<jmorris@namei.org>
