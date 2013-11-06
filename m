MIME-Version: 1.0
In-Reply-To: <20131104151648.312ac51e@soldur.bigon.be>
References: <1383434030-5853-1-git-send-email-bigon@debian.org>
	<52779C9A.4050306@tycho.nsa.gov>
	<52779EB0.1020700@tycho.nsa.gov>
	<5277A835.9000804@redhat.com>
	<20131104151648.312ac51e@soldur.bigon.be>
Date: Wed, 6 Nov 2013 16:40:52 +0100
Message-ID: <CAPzO=NyXAKskkzesaoxVeEZVOunUOtKMtCSkA8-GveXLkwZj8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Explicitly link libselinux against -lpthread
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Laurent Bigonville <bigon@debian.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 4, 2013 at 3:16 PM, Laurent Bigonville <bigon@debian.org> wrote:
>> Yes we originally added the link for pthread_atfork, but have
>> replaced that with a GCC Equivalebt __selinux_atfork.
>>
>> Laurent, does debian not work without -lpthread?  Gcc guys did  not
>> want to require all apps that use libselinux to compile against
>> lpthread.
>
> I think it's the upgrade from a version of libselinux that was linking
> against -lpthread (2.1.13) to a version that doesn't that caused the
> problem (well this is my wild uninformed guess).
>
> The Debian bug
> is at: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=728529
>
> This could probably be fixed in debian by rebuilding all the reverse
> dependencies of libselinux, but that will also affect Gentoo too (added
> Sven in CC), or the downstreams should carry the patch.
>
> I'm a bit lost with these pthread issues :/

Without linking to libpthread (bugs
https://bugs.gentoo.org/show_bug.cgi?id=473714 and
https://bugs.gentoo.org/show_bug.cgi?id=476866) we couldn't build some
of the tools that support SELinux (i.e. link with libselinux) whereas,
if we disable SELinux support, they do build properly (busybox is the
one most often found as it is used for our initramfs building so
generally one of the packages that is immediately seen - others might
exist like cryptsetup and such).

If another fix or approach solves this I'm too fine with this. It is
just something I know less about on how to proceed (not my cup of tea,
so to speak).

Wkr,
  Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
