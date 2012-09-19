Message-ID: <1348061544.4107.25.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: level
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 19 Sep 2012 09:32:24 -0400
In-Reply-To: <CAFftDdoGiXnOk9qYMvbvzFH=L4muVsNYi1OBGDNmL2x1-D6tDg@mail.gmail.com>
References: 
	<CAFftDdoGiXnOk9qYMvbvzFH=L4muVsNYi1OBGDNmL2x1-D6tDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-09-18 at 16:09 -0700, William Roberts wrote:
> In seapp_contexts when I try to set the level to s0:c56 it works, but
> if I do s0:c1, it does not, any ideas?

This worked for me:
$ cd external/sepolicy
$ grep browser seapp_contexts 
user=app_* seinfo=release name=com.android.browser domain=browser_app type=platform_app_data_file level=s0:c1

$ adb shell su 0 ps -Z | grep browser
u:r:browser_app:s0:c1          u0_a3     1284  127   com.android.browser

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
