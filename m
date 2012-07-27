Message-ID: <1343396363.17570.13.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Issue with setting booleans in SEManager app
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal =?UTF-8?Q?Ma=C5=A1ek?= <michal.masek@circletech.net>
Cc: selinux@tycho.nsa.gov
Date: Fri, 27 Jul 2012 09:39:23 -0400
In-Reply-To: <50127869.4070605@circletech.net>
References: <50127869.4070605@circletech.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 13:15 +0200, Michal Mašek wrote:
> Hi,
> 
> I am unable to set or unset 'app_ndk' boolean using the SEManager app in
> seandroid-4.1.1 branch (in the master branch everything works fine).
> However I can still set it from command line:
>   adb shell su 0 setsebool app_ndk=1
> 
> The same applies for 'in_qemu' boolean. All other booleans can be set
> just fine. I am running SEAndroid on Galaxy Nexus. Does anyone else have
> this issue?

If you re-sync, this should be fixed now.  I originally didn't bring
over the chown -R support from seandroid to seandroid-4.1.1 because we
thought it was rejected by AOSP, so I had manually added chown
statements for the current set of booleans to init.rc but missed app_ndk
(in_qemu was intentional as it should only normally be set by
init.goldfish.rc when running on the emulator and shouldn't really be
changed by users, which we could enforce by adding a genfscon statement
to label it differently).  However, as the chown -R patch has been
revived, I put the latest version on seandroid-4.1.1 and switched back
to using it.  Note however that it appears that the syntax will be
changing for it based on AOSP comments.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
