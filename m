Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA2JXuZq030712
 for <selinux@tycho.nsa.gov>; Mon, 2 Nov 2015 14:33:56 -0500
Received: by lbbec13 with SMTP id ec13so96204476lbb.0
 for <selinux@tycho.nsa.gov>; Mon, 02 Nov 2015 11:33:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8515151.Nh7tpX5fn1@sifl>
References: <1446398673-886-1-git-send-email-agruenba@redhat.com>
 <1446398673-886-7-git-send-email-agruenba@redhat.com>
 <8515151.Nh7tpX5fn1@sifl>
Date: Mon, 2 Nov 2015 20:33:32 +0100
Message-ID: <CAHc6FU624X=XsLXrNuDmBWqwzNRi7KMKJ2FUOGAQ7EH76-eWFg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] selinux: Revalidate invalid inode security labels
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 2, 2015 at 8:27 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Sunday, November 01, 2015 06:24:32 PM Andreas Gruenbacher wrote:
>> When fetching an inode's security label, check if it is still valid, and
>> try reloading it if it is not. Reloading will fail when we are in RCU
>> context which doesn't allow sleeping, or when we can't find a dentry for
>> the inode.  (Reloading happens via iop->getxattr which takes a dentry
>> parameter.)  When reloading fails, continue using the old, invalid
>> label.
>>
>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Generally I would say that you made enough changes between v4 and v5 that
> Stephen's ACK should have been dropped,

Sorry, my mistake.

> but considering that he suggested the changes I think's it's okay to leave it as-is.
>
> Stephen, I'm reviewing/merging these changes now for the selinux#next-queue,
> speak up if you have want your ACK removed.

Thanks,
Andreas
