Subject: Re: Maguro SE Manager app crash
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAFftDdqRJ1huU5EmY6idK_FC+=2jfW4QhsOkr2yz=oLsnVXMpw@mail.gmail.com>
References: 
	 <CAFftDdo1Cn9SWXNkkPPQ+_NH73zy+aENCPRdTA-nmpDgQBAfkg@mail.gmail.com>
	 <CAFftDdqRJ1huU5EmY6idK_FC+=2jfW4QhsOkr2yz=oLsnVXMpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 21 Mar 2012 09:14:12 -0400
Message-ID: <1332335652.27512.13.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-03-20 at 18:40 -0700, William Roberts wrote:
> Alright I found the problem (it was my mistake), the manifest file
> changes included adding a path to device/samsung/tuna which caused my
> prebuilt kernel file to overwritten with the default kernel which
> doesn't have se linux enabled in the config. Is their any particular
> reason we don't make tuna's kernel a selinux enabled kernel and commit
> that back to the branch? I know it's not hard to set
> TARGET_PREBUILT_KERNEL or just cp zImage to kernel, just wondering
> what the communities feelings on that are.

Hmm..still shouldn't crash the app; we'll look into that.

For crespo and wingray, we modified the LOCAL_KERNEL and
LOCAL_WIFI_MODULE definitions to point into the appropriate kernel
source tree (e.g. kernel/samsung/arch/arm/boot/zImage) rather than using
the prebuilt kernel.  I'll do that for tuna as well.  You'll still have
to build the SE-enabled tuna kernel from source before building AOSP,
but the build process will then automatically pick up the right kernel
rather than the prebuilt one by default.  I suppose we could replace the
prebuilt one, but we don't generally distribute binaries, just source
code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
