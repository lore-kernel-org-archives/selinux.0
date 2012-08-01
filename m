Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q71JuMtB017064
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2012 15:56:22 -0400
Received: by vcbfl17 with SMTP id fl17so8097709vcb.12
        for <selinux@tycho.nsa.gov>; Wed, 01 Aug 2012 12:56:21 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Aug 2012 12:56:21 -0700
Message-ID: <CAFftDdoxRtrSGgNACqjodc8v_o=Cn5q9ETKNFKsf=onapE6zmQ@mail.gmail.com>
Subject: repo commands changing could break mirror scripts
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Guys,

Be aware if your doing mirror's this may break some stuff!

Bill Roberts

On Wednesday, August 1, 2012 10:54:27 AM UTC-7, Jean-Baptiste Queru wrote:
When repo eventually moves to automatically selecting host-specific
projects, it'll have options in repo init to override that behavior.

Tou can already see the syntax in "repo help init" but it hasn't been
hooked up yet. That'd be "repo init -p all".

In theory, we could make "--mirror" imply "-p all" but I'm not sure
that I like such interplay between command-line options.

JBQ

On Wed, Aug 1, 2012 at 10:49 AM, Al Sutton <al@funkyandroid.com> wrote:
> Nice work :).
>
> My only concern would be that I mirror the AOSP repository to a Mac server and then pull to my build machines which are Linux and Mac based, so would the fact I'm mirroring to a Mac server stop me getting the Linux support files?
>
> Al.
> --
> Al Sutton - Funky Android Ltd.
> (www.funkyandroid.com)
>
> T: @alsutton
> G+: http://goo.gl/ymi9b
>
> The views expressed in this email are those of the author and not necessarily those of Funky Android Limited, it's associates, or it's subsidiaries.
>
> On 1 Aug 2012, at 18:36, Jean-Baptiste Queru <jbq@android.com> wrote:
>
>> AOSP is big, and downloading and storing all of it consumes a fair
>> amount of bandwidth and space.
>>
>> We've been investigating ways to make it smaller. One visible part of
>> that work is that the master tree is "only" 6.5GB, while Jelly Bean is
>> about 8.5GB.
>>
>> We're aiming to go further. Today, I'm deploying an experiment that
>> can help shrink things.
>>
>> Repo recently added a feature called "manifest groups" that allows to
>> restrict the list of projects being downloaded.
>>
>> I've set up the manifest for the AOSP master branch to include a few
>> groups. Here are the groups I added:
>>
>> "device": files that are specific to flagship devices but aren't
>> necessary to build a generic platform.
>> "darwin": files that are only necessary when building on a darwin host
>> (i.e. MacOS).
>> "linux": files that are only necessary when building on a linux host.
>> "arm": files that are only necessary when building for ARM targets.
>> "mips": files that are only necessary when building for MIPS targets.
>> "x86": files that are only necessary when building for IA targets.
>>
>> Here's an example, which allows to build the ARM emulator on a linux
>> host. In this case, the download is 3.6GB, which is a significant
>> improvement over a full tree:
>>
>> repo init -u [URI] -g default,-darwin,-device,-x86,-mips
>>
>> The syntax is hopefully self-explanatory. Note that this is only
>> currently supported in the master branch.
>>
>> I'm looking at the possible evolutions:
>>
>> -marking the projects for individual device families (i.e. crespo,
>> tuna, stingray, panda), so that it's possible to download the files
>> for one specific device without getting them all.
>> -marking the projects that are necessary to work on the developer tools.
>> -marking the projects that are necessary to work on CTS.
>>
>> There's also a possibility that repo will eventually know to
>> automatically ignore host-specific projects.
>>
>> Longer-term, we're investigating the possibility of not downloading
>> the entire source history for projects where it's both large and
>> unnecessary.
>>
>> I'm open to feedback and suggestions. Please let me know whether
>> that's useful, whether that works, which of the future directions
>> would be useful... and which future features I've forgotten that'd
>> make life easier.
>>
>> Thanks,
>> JBQ
>>
>> --
>> Jean-Baptiste M. "JBQ" Queru
>> Technical Lead, Android Open Source Project, Google.
>>
>> Questions sent directly to me that have no reason for being private
>> will likely get ignored or forwarded to a public forum with no further
>> warning.
>>
>> --
>> You received this message because you are subscribed to the "Android Building" mailing list.
>> To post to this group, send email to android-building@googlegroups.com
>> To unsubscribe from this group, send email to
>> android-building+unsubscribe@googlegroups.com
>> For more options, visit this group at
>> http://groups.google.com/group/android-building?hl=en
>



-- 
Jean-Baptiste M. "JBQ" Queru
Technical Lead, Android Open Source Project, Google.

Questions sent directly to me that have no reason for being private
will likely get ignored or forwarded to a public forum with no further
warning.

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
