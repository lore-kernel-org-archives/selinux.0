Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7DKRZZj023917
 for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2014 16:27:35 -0400
Received: by mail-la0-f42.google.com with SMTP id pv20so233003lab.29
 for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2014 13:27:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140813123021.GX18016@ZenIV.linux.org.uk>
References: <1407929653-27228-1-git-send-email-shivnandan.k@samsung.com>
 <20140813123021.GX18016@ZenIV.linux.org.uk>
Date: Wed, 13 Aug 2014 16:27:39 -0400
Message-ID: <CACLa4pvQSA4yJTMRjh2=f8ws6pHRGp1LAFWVLDPpxsiouqGPww@mail.gmail.com>
Subject: Re: [PATCH] Security: List corruption occured during file system
 automation test
From: Eric Paris <eparis@parisplace.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: SE-Linux <selinux@tycho.nsa.gov>, ashish.kalra@samsung.com,
 shivnandan.k@samsung.com, vidushi.koul@samsung.com,
 James Morris <james.l.morris@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 shiv.jnumca08@gmail.com, narendra.m1@samsung.com, cpgs@samsung.com,
 rajat.suri@samsung.com, Stephen Smalley <sds@tycho.nsa.gov>,
 mohammad.a2@samsung.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Do you have a backtrace?

On Wed, Aug 13, 2014 at 8:30 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Aug 13, 2014 at 05:04:13PM +0530, shivnandan.k@samsung.com wrote:
>> From: Shivnandan Kumar <shivnandan.k@samsung.com>
>>
>> List element was freed by  inode_free_security and then it uses rcu
>> element to point inode_free_rcu, since it inside a union so it
>> shares memory, sb_finish_set_opts now also try to free list element,
>
> How in hell does it find that element?
