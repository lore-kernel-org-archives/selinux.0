Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAIFJvjo005756
 for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2015 10:20:01 -0500
Received: by obdj3 with SMTP id j3so3246958obd.2
 for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2015 07:19:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151118151335.GD22011@ZenIV.linux.org.uk>
References: <20151117172551.GA108807@ubuntu-hedt>
 <20151117175506.GW22011@ZenIV.linux.org.uk>
 <564B79B1.3040207@gmail.com> <20151117191606.GC108807@ubuntu-hedt>
 <564B941A.2070601@gmail.com> <20151117213255.GE108807@ubuntu-hedt>
 <564C6DD4.6090308@gmail.com> <20151118142238.GB134139@ubuntu-hedt>
 <20151118145818.GC22011@ZenIV.linux.org.uk>
 <20151118150512.GE134139@ubuntu-hedt>
 <20151118151335.GD22011@ZenIV.linux.org.uk>
Date: Wed, 18 Nov 2015 16:19:56 +0100
Message-ID: <CAFLxGvwwhXqVM71m1kEDTZk_YTKGtbJ3gWoXw3wRgcwDiC38Bg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] User namespace mount updates
From: Richard Weinberger <richard.weinberger@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Seth Forshee <seth.forshee@canonical.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-bcache@vger.kernel.org,
 device-mapper development <dm-devel@redhat.com>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>,
 LKML <linux-kernel@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 18, 2015 at 4:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Nov 18, 2015 at 09:05:12AM -0600, Seth Forshee wrote:
>
>> Yes, the host admin. I'm not talking about trusting the admin inside the
>> container at all.
>
> Then why not have the same host admin just plain mount it when setting the
> container up and be done with that?  From the host namespace, before spawning
> the docker instance or whatever framework you are using.  IDGI...

Because hosting companies sell containers as "full virtual machines"
and customers expect to be able mount stuff like disk images they upload.

-- 
Thanks,
//richard
