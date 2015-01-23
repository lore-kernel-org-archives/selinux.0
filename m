Message-ID: <1421983803.24914.3.camel@stgolabs.net>
Subject: Re: [PATCH] Selinux/hooks.c: Fix a NULL pointer dereference caused
 by semop()
From: Davidlohr Bueso <dave@stgolabs.net>
To: ethan zhao <ethan.zhao@oracle.com>
Date: Thu, 22 Jan 2015 19:30:03 -0800
In-Reply-To: <54C1AFA2.8040900@oracle.com>
References: <1421745518-18790-1-git-send-email-ethan.zhao@oracle.com>
 <54BE61F0.202@tycho.nsa.gov>
 <CABawtvPrhVWV3bC-=wygqfHJzctvrmd1WxDD1ciuLE7F7-_yaQ@mail.gmail.com>
 <54BF3971.2090003@colorfullife.com>
 <CABawtvO3PdKhmeH_H1v_tQxmgOBQrnLGNayTE1=EbcxJbtwAzQ@mail.gmail.com>
 <CAB9W1A3kabX9qMm56k=FJ1jcL8ou4APqt8teT38oFCiu=g1wNg@mail.gmail.com>
 <54C1AFA2.8040900@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: ethan.kernel@gmail.conm, Manfred Spraul <manfred@colorfullife.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Ethan Zhao <ethan.kernel@gmail.com>,
 selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2015-01-23 at 10:19 +0800, ethan zhao wrote:
> >   If not, what kernel
> > version were you running when you triggered the bug?
>   To be honest, a kernel from distro, but not released, but before we 
> get it clear, we wouldn't public more.

Sheesh, could Oracle be any more (ridiculously) secretive about what the
hell kernel(s) they run... it's like pulling teeth. *sigh*
