Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t95IdDLb023047
 for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2015 14:39:13 -0400
Received: by lbos8 with SMTP id s8so63163593lbo.0
 for <selinux@tycho.nsa.gov>; Mon, 05 Oct 2015 11:39:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5612C056.50303@schaufler-ca.com>
References: <1443986381-14412-1-git-send-email-agruenba@redhat.com>
 <1443986381-14412-2-git-send-email-agruenba@redhat.com>
 <5612C056.50303@schaufler-ca.com>
Date: Mon, 5 Oct 2015 20:39:10 +0200
Message-ID: <CAHc6FU7pcZ56HZ_ktDpQeCk9BFUrFen+Znp90HK3xgjtRVWUfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] security: Add hook to invalidate inode security
 labels
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christoph Hellwig <hch@infradead.org>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 5, 2015 at 8:24 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/4/2015 12:19 PM, Andreas Gruenbacher wrote:
>> Add a hook to invalidate an inode's security label when the cached
>> information becomes invalid.
>
> Where is this used?

See the next patch in this patch queue, gfs2.

> If I need to do the same for Smack or any other module, how would I know that
> it works right?

I haven't looked at Smack but if it does the same thing as SELinux,
then label updates on one gfs2 nod ein a cluster won't become visible
on other nodes without this fix, and with this fix they will.

Andreas
