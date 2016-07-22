Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6MFkUDP015479
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 11:46:30 -0400
Received: by mail-oi0-f65.google.com with SMTP id w143so10731130oiw.2
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 08:46:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1468537011-20407-1-git-send-email-danielj@mellanox.com>
References: <1468537011-20407-1-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Jul 2016 11:46:08 -0400
Message-ID: <CAHC9VhRuSSdUEdA65KBbt50fkDAjd+vATagNhXN9dYojNNBFSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] SELinux support for Infiniband RDMA
To: Dan Jurgens <danielj@mellanox.com>
Cc: chrisw@sous-sol.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, dledford@redhat.com,
 sean.hefty@intel.com, hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 14, 2016 at 6:56 PM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> The selinux next tree is missing some patches for IB/core.  This series
> applies cleanly to ib-next, and should apply cleanly to selinux-next once
> the IB patches are merged.

Hi Dan,

Thanks for the updated patchset, I'm taking a look at it today.  I do
have one question, related but independent to your patches: is there a
way to test the LSM controlled portions of the Infiniband stack
without any IB hardware (e.g. is there an IB "loopback" device)?  I'm
asking because we are really trying to make sure we have tests for any
new code/functionality we add to SELinux, and requiring IB hardware to
test the IB access controls would make this difficult.

* https://github.com/SELinuxProject/selinux-testsuite

-Paul

-- 
paul moore
www.paul-moore.com
