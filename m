MIME-Version: 1.0
In-Reply-To: <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
 <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Wed, 12 Apr 2017 15:30:58 +0200
Message-ID: <CAPkE-bX5-Mo9AMPwf6dwBNT9FeWgAShWwKbkiJg3ZZVpt9itLA@mail.gmail.com>
Subject: Re: [PATCH] selinux: add selinux_is_enforced() function
To: Paul Moore <pmoore@redhat.com>, sds@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, william.c.roberts@intel.com, serge@hallyn.com,
 james.l.morris@oracle.com, Eric Paris <eparis@parisplace.org>,
 Paul Moore <paul@paul-moore.com>, Sebastien Buisson <sbuisson@ddn.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-04-12 13:55 GMT+02:00 Paul Moore <pmoore@redhat.com>:
> As currently written this code isn't something we would want to merge
> upstream for two important reasons:
>
> * No clear user of this functionality.  There needs to be a well
> defined user of this functionality in the kernel.

The use case for this new functionality (and the other one) is getting
SELinux information from the Lustre client code in kernel space.
Latest patch can be accessed at:
https://review.whamcloud.com/24421
Actual user is sptlrpc_get_sepol() function in lustre/lustre/ptlrpc/sec.c file.
This code will be pushed to the upstream kernel as soon as it is
landed into Lustre master branch.
