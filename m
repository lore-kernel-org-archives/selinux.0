Message-ID: <1342010691.29461.22.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: external/strace build breakage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 11 Jul 2012 08:44:51 -0400
In-Reply-To: <CAFftDdrwpSDqaPVVpiHDFYrvBK-f-MkaVHcUU5Z+x6=GLqnO=w@mail.gmail.com>
References: 
	<CAFftDdrwpSDqaPVVpiHDFYrvBK-f-MkaVHcUU5Z+x6=GLqnO=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-10 at 15:57 -0700, William Roberts wrote:
> I got a build breakage when building SE Android master. It stems from
> external/strace and it is on branch aosp/master spewing error: #if
> with no expression.
> 
> 
> You can apply this patch to fix it:
> 
> 
> git fetch https://android.googlesource.com/platform/external/strace
> refs/changes/91/38991/1 && git cherry-pick FETCH_HEAD
> 
> 
> https://android-review.googlesource.com/#/c/38991/
> 
> 
> I don't think this the "best" fix as their is
> another similar patch submitted to the project, but it works for now.
> I think that macro should be assigned a 1 or 0 vs defined/not defined.

I'm not experiencing any build breakage; wondering if this is toolchain
specific.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
