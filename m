Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MJE8UU029813
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 15:14:08 -0400
Received: by mail-lf0-f67.google.com with SMTP id h4so6224497lfj.3
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 12:14:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1705221033550.3502@namei.org>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
 <alpine.LRH.2.20.1705221033550.3502@namei.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 May 2017 15:14:02 -0400
Message-ID: <CAHC9VhQbLmdzQDyeY=j4M=hw-arSmft68ri08Pu1cxpCaFPGpA@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] SELinux support for Infiniband RDMA
To: James Morris <jmorris@namei.org>, Dan Jurgens <danielj@mellanox.com>
Cc: chrisw@sous-sol.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, dledford@redhat.com,
 sean.hefty@intel.com, hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, May 21, 2017 at 8:35 PM, James Morris <jmorris@namei.org> wrote:
> On Fri, 19 May 2017, Dan Jurgens wrote:
>
>> From: Daniel Jurgens <danielj@mellanox.com>
>
> What kind of testing has this code had?  It's relatively complex and as a
> security feature, it especially needs to be well-tested.

Check the relevant threads on the SELinux list as well as Daniel's
response.  Aside from the usual developer unit testing, we've gone
through multiple rounds of reviews and have gotten ACKs from the IB
folks.  Daniel is currently working on adding tests to the
selinux-testsuite (see the SELinux list for the patches) and I merged
this to the selinux/next branch last week so we could get as much
exposure as possible before the next merge window (linux-next has
already caught two things).  I did let Daniel know that inclusion in
the next pull request is contingent on the tests being in place (as
well as the userspace, policy, etc.).

I think we are in a good spot right now with this patchset, especially
considering we are only at -rc2 and still have several weeks before
the next merge window opens.

-- 
paul moore
www.paul-moore.com
