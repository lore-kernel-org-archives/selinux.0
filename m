Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G19IE4016939
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 21:09:18 -0400
Received: by lbbyj8 with SMTP id yj8so34880347lbb.0
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 18:09:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55A6E107.3070200@schaufler-ca.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com> <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <55A6E107.3070200@schaufler-ca.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 15 Jul 2015 18:08:56 -0700
Message-ID: <CALCETrVCNQPVr-hg_pqd2J_LeWtRJs3LRsbbE+fifo4sat+FQQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
To: Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 15, 2015 at 3:39 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/15/2015 2:06 PM, Eric W. Biederman wrote:
>> Casey Schaufler <casey@schaufler-ca.com> writes:
>
>> The first step needs to be not trusting those labels and treating such
>> filesystems as filesystems without label support.  I hope that is Seth
>> has implemented.
>
> A filesystem with Smack labels gets mounted in a namespace. The labels
> are ignored. Instead, the filesystem defaults (potentially specified as
> mount options smackfsdef="something", but usually the floor label ("_"))
> are used, giving the user the ability to read everything and (usually)
> change nothing. This is both dangerous (unintended read access to files)
> and pointless (can't make changes).

I don't get it.

If I mount an unprivileged filesystem, then either the contents were
put there *by me*, in which case letting me access them are fine, or
(with Seth's patches and then some) I control the backing store, in
which case I can do whatever I want regardless of what LSM thinks.

So I don't see the problem.  Why would Smack or any other LSM care at
all, unless it wants to prevent me from mounting the fs in the first
place?

--Andy
