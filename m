Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u51Ll8qv022486
 for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2016 17:47:08 -0400
Received: by mail-vk0-f49.google.com with SMTP id a6so46282139vkg.3
 for <selinux@tycho.nsa.gov>; Wed, 01 Jun 2016 14:46:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7e716b38-f59b-eff3-152a-4f005b45abd9@tycho.nsa.gov>
References: <1464616742-29271-1-git-send-email-agruenba@redhat.com>
 <1464616742-29271-2-git-send-email-agruenba@redhat.com>
 <2748270d-1c74-b5c8-c9f2-85d898c065e1@tycho.nsa.gov>
 <CAHc6FU7z5bo44radMsKcadxqqhEqRpbfGGeUtR+CohJBMUfzKg@mail.gmail.com>
 <7e716b38-f59b-eff3-152a-4f005b45abd9@tycho.nsa.gov>
Date: Wed, 1 Jun 2016 23:46:44 +0200
Message-ID: <CAHc6FU67zwdQ6zEjNuDZZpjOsXRYWB0AEWV4orssvgZNpusv-A@mail.gmail.com>
Subject: Re: [RFC 1/2] selinux: Stop looking up dentries from inodes
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jun 1, 2016 at 3:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 05/31/2016 11:22 AM, Andreas Gruenbacher wrote:
>> With that fixed, could you possibly put this change to test?
>
> Falls over during boot in generic_getxattr(), which still needs a
> non-NULL dentry in the work.selinux branch.

dentry->d_sb needs to be changed to inode->i_sb there.

> Is there a reason that this being done separately from work.xattr?

I don't know how much work.xattr will shift still (and what I can
still add there), and this change is unrelated, at least so far.

> Also, if we aren't going to call d_find_alias() there, we can likely
> also drop the dget() and dput().

Ah, yes. I'll remove those, thanks.

Andreas
