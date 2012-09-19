Message-ID: <1348058438.4107.12.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid 4.1.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 19 Sep 2012 08:40:38 -0400
In-Reply-To: <CAKi3PupU9CDa-DaNBn2_yaskdF4pAqOYKBFdcz=s+bG2XM0NVA@mail.gmail.com>
References: 
	<CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	 <1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PupU9CDa-DaNBn2_yaskdF4pAqOYKBFdcz=s+bG2XM0NVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-09-19 at 10:25 +0200, Alexandra Test wrote:
> Yes, I did. 
> I downloaded the proprietary files from the google and extract other
> proprietary files from the original android version.
> so it is still not possible to use the camera, right?
> 
> About the wifi, the problem is that it finds the network but when it
> tries to connect, it never succeeds.
> What do you suggest to do? built it again?

Hmm...might want to look at your dmesg and logcat output.
Anyway, your issues don't sound like they are specific to SE Android, so
you should really search the regular android discussion groups, e.g.
android-building, for answers and if unable to find an answer, post
questions there.  But first make sure that the same issue occurs if you
use a vanilla AOSP build without the SE Android modifications.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
