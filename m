Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t09D6pwp031859
 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2015 08:06:51 -0500
Received: by mail-we0-f170.google.com with SMTP id w61so7787208wes.1
 for <selinux@tycho.nsa.gov>; Fri, 09 Jan 2015 05:06:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2354586.80TRdrKbtf@sifl>
References: <20150108190822.GB4365@codemonkey.org.uk> <3227891.DhTeT4XeAv@sifl>
 <2354586.80TRdrKbtf@sifl>
Date: Fri, 9 Jan 2015 08:06:49 -0500
Message-ID: <CAB9W1A2nTN2DJ699BXL_r_aXCk-O9-KrTLSi731isQWpPUmkwg@mail.gmail.com>
Subject: Re: noisy selinux messages on tmpfs mount.
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Paul Moore <pmoore@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Dave Jones <davej@codemonkey.org.uk>, Stephen Smalley <sds@epoch.ncsc.mil>,
 James Morris <james.l.morris@oracle.com>, selinux <selinux@tycho.nsa.gov>,
 Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We already reduced that message to KERN_DEBUG.  Is that not sufficient?

On Thu, Jan 8, 2015 at 2:39 PM, Paul Moore <pmoore@redhat.com> wrote:
> On Thursday, January 08, 2015 02:34:57 PM Paul Moore wrote:
>> On Thursday, January 08, 2015 02:08:22 PM Dave Jones wrote:
>> > systemd has started mounting a tmpfs in /run/user/<uid> every time a
>> > session begins.  So after ssh'ing into a box a number of times, dmesg
>> > looks like this..
>> >
>> > [...] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
>> > [...] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
>>
>> {snip}
>>
>> > What's a good solution to stopping this spew ? printk_once doesn't seem
>> > like a good fit, in case someone is doing different labelling behaviours
>> > between mounts.
>> >
>> > Could we only print it if the mount is being done with non-default
>> > behaviour perhaps?
>>
>> I'm very curious to hear Stephen's opinion on the issue, but I wonder how
>> much this would honestly impact us if we removed this message in the case
>> where we mount the filesystem with a known labeling behavior.
>
> [NOTE: adding the SELinux list to the CC line.]
>
> --
> paul moore
> security @ redhat
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
