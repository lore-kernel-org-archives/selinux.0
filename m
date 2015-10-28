Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9SBnYop017240
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 07:49:35 -0400
Received: by lbbwb3 with SMTP id wb3so3635493lbb.1
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 04:48:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <562FA8ED.7020704@tycho.nsa.gov>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
 <1445894128-6765-4-git-send-email-agruenba@redhat.com>
 <562FA8ED.7020704@tycho.nsa.gov>
Date: Wed, 28 Oct 2015 12:48:55 +0100
Message-ID: <CAHc6FU5w6Znxs=xa6TPgG0QJkAsx3=AwUn4KXNAiHMDQ1PsV2A@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] selinux: Get rid of file_path_has_perm
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 27, 2015 at 5:40 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/26/2015 05:15 PM, Andreas Gruenbacher wrote:
>>
>> Use path_has_perm directly instead.
>
>
> This reverts:
>
> commit 13f8e9810bff12d01807b6f92329111f45218235
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Jun 13 23:37:55 2013 +0100
>
>     SELinux: Institute file_path_has_perm()
>
>     Create a file_path_has_perm() function that is like path_has_perm() but
>     instead takes a file struct that is the source of both the path and the
>     inode (rather than getting the inode from the dentry in the path).  This
>     is then used where appropriate.
>
>     This will be useful for situations like unionmount where it will be
>     possible to have an apparently-negative dentry (eg. a fallthrough) that
> is
>     open with the file struct pointing to an inode on the lower fs.
>
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> which I think David was intending to use as part of his SELinux/overlayfs
> support.

Okay. As long as overlayfs support in SELinux is in half-finished
state, let's leave this alone.

Thanks,
Andreas
