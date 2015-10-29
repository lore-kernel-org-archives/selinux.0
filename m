Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9TGqDLK010268
 for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2015 12:52:21 -0400
Received: by lfbn126 with SMTP id n126so21509033lfb.2
 for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2015 09:52:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56323980.8040209@tycho.nsa.gov>
References: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
 <1446079635-22462-7-git-send-email-agruenba@redhat.com>
 <56323980.8040209@tycho.nsa.gov>
Date: Thu, 29 Oct 2015 17:52:12 +0100
Message-ID: <CAHc6FU5xuWSXonVwux3cBrqYoMocfocR64wd0Qr55V+3w5CC-Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] selinux: Revalidate invalid inode security labels
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Oct 29, 2015 at 4:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/28/2015 08:47 PM, Andreas Gruenbacher wrote:
>>
>> When fetching an inode's security label, check if it is still valid, and
>> try reloading it if it is not. Reloading will fail when we are in RCU
>> context which doesn't allow sleeping, or when we can't find a dentry for
>> the inode.  (Reloading happens via iop->getxattr which takes a dentry
>> parameter.)  When reloading fails, continue using the old, invalid
>> label.
>>
>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
>
> Could probably use inode_security_novalidate() for all of the SOCK_INODE()
> cases, right?

I guess, yes.

>  Otherwise,
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks,
Andreas
