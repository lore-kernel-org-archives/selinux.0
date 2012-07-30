Message-ID: <1343670226.2346.117.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] add read permission over dev_type to appdomain on
 android_cts enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 30 Jul 2012 13:43:46 -0400
In-Reply-To: <CAO-4OdF9eOgwpF6_Jg_izcY-cqijrQjQEMDU1_7+Pf5vb3L1Tg@mail.gmail.com>
References: <1343428827-6808-1-git-send-email-hqjiang1988@gmail.com>
	 <1343650449.2346.0.camel@moss-pluto.epoch.ncsc.mil>
	 <CAO-4OdF9eOgwpF6_Jg_izcY-cqijrQjQEMDU1_7+Pf5vb3L1Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-30 at 10:33 -0700, Haiqing Jiang wrote:
> The denial information is shown as below:
> 
> 
> <5>[ 2219.393524] type=1400 audit(1342221801.398:17): avc:  denied
>  { read } for  pid=2687 comm="ationTestRunner" name="mtdblock0"
> dev=tmpfs ino=2562 scontext=u:r:untrusted_app:s0:c38
> tcontext=u:object_r:block_device:s0 tclass=lnk_file
> 
> <5>[ 2219.399566] type=1400 audit(1342221801.406:18): avc:  denied
> { read } for  pid=2687 comm="ationTestRunner" name="radio" dev=tmpfs
> ino=2527 scontext=u:r:untrusted_app:s0:c38
> tcontext=u:object_r:radio_device:s0 tclass=lnk_file

So you should only allow read for dev_type:lnk_file, not read access to
all devices.

> <5>[ 2005.011016] type=1400 audit(1342224760.046:32): avc:  denied
> { read } for  pid=7264 comm="onCtsTestRunner" name="events" dev=tmpfs
> ino=2902 scontext=u:r:untrusted_app:s0:c38
> tcontext=u:object_r:log_device:s0 tclass=chr_file

So you should just allow this one for reading logcat output:
allow appdomain log_device:chr_file read;

But you should definitely not allow reading arbitrary devices; you don't
want apps reading raw block devices (shouldn't be possible anyway due to
DAC controls, but in case of DAC privilege escalation via setuid
binary).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
