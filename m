Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA1CrELU022562
 for <selinux@tycho.nsa.gov>; Sun, 1 Nov 2015 07:53:14 -0500
Received: by oiao187 with SMTP id o187so82200001oia.3
 for <selinux@tycho.nsa.gov>; Sun, 01 Nov 2015 04:52:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHc6FU5xuWSXonVwux3cBrqYoMocfocR64wd0Qr55V+3w5CC-Q@mail.gmail.com>
References: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
 <1446079635-22462-7-git-send-email-agruenba@redhat.com>
 <56323980.8040209@tycho.nsa.gov>
 <CAHc6FU5xuWSXonVwux3cBrqYoMocfocR64wd0Qr55V+3w5CC-Q@mail.gmail.com>
Date: Sun, 1 Nov 2015 07:52:51 -0500
Message-ID: <CAHC9VhS2StXpnoA5Q99sFqKqdyTS8WR01e26Vn+eMTtMwckMBA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] selinux: Revalidate invalid inode security labels
From: Paul Moore <paul@paul-moore.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Oct 29, 2015 at 12:52 PM, Andreas Gruenbacher
<agruenba@redhat.com> wrote:
> On Thu, Oct 29, 2015 at 4:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 10/28/2015 08:47 PM, Andreas Gruenbacher wrote:
>>>
>>> When fetching an inode's security label, check if it is still valid, and
>>> try reloading it if it is not. Reloading will fail when we are in RCU
>>> context which doesn't allow sleeping, or when we can't find a dentry for
>>> the inode.  (Reloading happens via iop->getxattr which takes a dentry
>>> parameter.)  When reloading fails, continue using the old, invalid
>>> label.
>>>
>>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>>
>>
>> Could probably use inode_security_novalidate() for all of the SOCK_INODE()
>> cases, right?
>
> I guess, yes.

There is no time like the present.  All the patches look fine to me,
but I think it would be good to add the additional
inode_security_novalidate() calls.  If you want, you can just post a
"8/7" patch with the extra calls added and I'll apply that on top of
the v4 patchset.

-- 
paul moore
www.paul-moore.com
