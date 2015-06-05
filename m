From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v3 6/6] selinux-testsuite: fix compile problems in
 tests/capable_file
Date: Fri, 05 Jun 2015 09:50:39 -0400
Message-ID: <2913924.zT61MQTlQB@sifl>
In-Reply-To: <5571A20B.6080809@tycho.nsa.gov>
References: <20150604205708.19614.64746.stgit@localhost>
 <20150604205830.19614.68299.stgit@localhost> <5571A20B.6080809@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, June 05, 2015 09:20:11 AM Stephen Smalley wrote:
> On 06/04/2015 04:58 PM, Paul Moore wrote:
> > Fix the following warnings:
> > 
> > make[2]: Entering directory
> > '/home/pmoore/sources/selinux-testsuite/selinux_testsuite-upstream/tests/
> > capable_file' cc -g -O0 -Wall -D_GNU_SOURCE    test_lease.c   -o
> > test_lease
> > test_lease.c: In function 'main':
> > test_lease.c:22:3: warning: implicit declaration of function 'open'
> > 
> >    fd = open(argv[1], O_RDONLY, 0);
> >    ^
> > 
> > test_lease.c:29:3: warning: implicit declaration of function 'fcntl'
> > 
> >    rc = fcntl(fd, F_SETLEASE, 0);
> >    ^
> > 
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> for all 6 patches.

Thanks.  I went ahead and applied the patches last night along with the astyle 
patch.

-- 
paul moore
security @ redhat
