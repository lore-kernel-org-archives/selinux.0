Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5MLmsSv029554
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 17:48:55 -0400
Received: by oigb199 with SMTP id b199so90073379oig.3
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 14:48:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9305.1434966107@warthog.procyon.org.uk>
References: <6033.1434651905@warthog.procyon.org.uk> <9833421.4OAA7AQtgN@sifl>
 <9305.1434966107@warthog.procyon.org.uk>
Date: Mon, 22 Jun 2015 17:48:52 -0400
Message-ID: <CAHC9VhT+SCFVwfUZEC9X5m62Y5UTCyd=WYePbJCU9snaeQbdFw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Create a common helper to determine an inode
 label [ver #3]
From: Paul Moore <paul@paul-moore.com>
To: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
 linux-fsdevel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 22, 2015 at 5:41 AM, David Howells <dhowells@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> wrote:
>
>> This patch looks fine to me and I think there is an advantage to merging this
>> regardless of what happens with the "unioning" work so I'm inclined to queue
>> this up now unless you would prefer to resubmit with the union patches?
>
> If you could queue it up now, that'd be great!

All set.  As soon as the merge window closes I'll push it to the
selinux#next branch.

-- 
paul moore
www.paul-moore.com
