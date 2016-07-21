Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6L7PgC2022579
 for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2016 03:25:43 -0400
Received: by mail-lf0-f50.google.com with SMTP id f93so54017720lfi.2
 for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2016 00:25:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160720125201.GA52079@ubuntu-hedt>
References: <1461699396-33000-1-git-send-email-seth.forshee@canonical.com>
 <1461699396-33000-19-git-send-email-seth.forshee@canonical.com>
 <CA+2rt426_pshAauQizcxkfAq16vmEpB4sJ4genW_ucosH3j=zQ@mail.gmail.com>
 <20160720125201.GA52079@ubuntu-hedt>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 21 Jul 2016 09:25:17 +0200
Message-ID: <CAOssrKfJrQuf_exBVGtn-EBOBnRhhNWe+2P=VkEqtp3qmGYiFA@mail.gmail.com>
Subject: Re: [PATCH v4 18/21] fuse: Add support for pid namespaces
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Sheng Yang <sheng@yasker.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
 Miklos Szeredi <miklos@szeredi.hu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 cgroups@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Wed, Jul 20, 2016 at 2:52 PM, Seth Forshee
<seth.forshee@canonical.com> wrote:

> It sounds like we need to remove the restriction on accessing the
> filesystem from a different pid namespace. I don't think this poses a
> security problem. However there's no pid mapping that is usable by the
> userspace fuse process, so what do we put in the fuse request? Probably
> the only candidates are 0 and 0xffffffff.
>
> So a question for the fuse developers - is one value or the other
> preferrable for fuse_in_header.pid when the pid cannot be mapped, and is
> this going to cause problems for any fuse filesystems? I suspect that
> few filesystems actually look at the pid anyway, and already for a
> filesystem mounted in a pid namespace the values being given to
> userspace won't be correct for the namespace of the fuse process.

pid = 0 sounds good.

The pid from the request is used for example to get the auxiliary
group list by libfuse (fuse_req_getgroups()).   That's not used by all
filesystems and it will return an error in case it can't find the proc
entry (which it won't for pid == 0).

It would be nice if we could transfer the group list through the
userspace/kernel protocol, since then it wouldn't depend on proc and
on being in the same pid namespace.  But that's another story.

Thanks,
Miklos
