Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GB7ad5006523
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 07:07:36 -0400
Received: from mail-pz0-f44.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GB7Z1l028156
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 11:07:35 GMT
Received: by pzk36 with SMTP id 36so1404009pzk.3
        for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 04:07:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316151755.2364.45.camel@vortex>
References: <CAB04Hprsq9z4qYzO+pTOMYC41ma7d3J7+hrcQ04KSkOQnBEnBQ@mail.gmail.com>
	<1316117256.2202.104.camel@vortex>
	<CAB04Hpr23zFfegf2421-N22350p5arDZ9SjRB4pRjt2Bgx64tg@mail.gmail.com>
	<1316151755.2364.45.camel@vortex>
Date: Fri, 16 Sep 2011 07:07:34 -0400
Message-ID: <CAB04HprGNsUi-U8Ae44pih6uVXEqAbF-EwVQ87RXZeuUF3EyuQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: preserve mode bits and ownership of /tmp
 in seunshare
From: dave w <nullcore@gmail.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 16, 2011 at 1:42 AM, Guido Trentalancia
<guido@trentalancia.com> wrote:

<snip>

> So the question now is: CVE-2011-1011 is dated 20110214, how comes this
> is trying to get sorted out only now for upstream ?
>

Unsure.  I performed a search of activity related to this CVE since
its original posting on 20110214 and found nothing.  I'm fixing this
bug on behalf of a distro (Ubuntu) and thought it prudent to upstream
the changes since nobody else has addressed this CVE.

That said, I also found it surprising that the CVE hadn't been
addressed upstream at all since then.  I thought it could be a result
of the low priority most distros assigned this issue.

>> > In any case, good practice says nothing should ever be allowed to mount
>> > under /tmp with suid/exec flags (use noexec,nosuid options in fstab).
>> >
>> > That said, have you tested the patch already ? Is it effective ?
>> >
>>
>> Yes, the patch has been effective and with it applied, unprivileged
>> users cannot delete files other than their own from /tmp, which is the
>> expected behavior in a directory with the sticky bit set owned by the
>> superuser.
>>
>> > Thanks.
>> >
>> > Guido
>> >
>> >> The seunshare_mount function in sandbox/seunshare.c in seunshare in certain
>> >> Red Hat packages of policycoreutils 2.0.83 and earlier in Red Hat
>> >> Enterprise Linux (RHEL) 6 and earlier, and Fedora 14 and earlier, mounts a
>> >> new directory on top of /tmp without assigning root ownership and the
>> >> sticky bit to this new directory, which allows local users to replace or
>> >> delete arbitrary /tmp files, and consequently cause a denial of service or
>> >> possibly gain privileges, by running a setuid application that relies on
>> >> /tmp, as demonstrated by the ksu application
>
> What happened exactly for upstream since the CVE was initially
> released ?
>
>> >> This patch preserves the mode bits, and thus permissions, and
>> >> ownership of the destination directory of the bind mount performed by
>> >> seunshare.  The permission check in verify_mount() was relaxed for
>> >> directories who originally had the sticky bit set, as root ownership
>> >> is required for these to ensure that unprivileged users cannot unlink
>> >> arbitrary files in the newly bind mounted directory.
>
> Is it the first time ever that you post a patch to try sorting out the
> same issue ?
>
>> >> Thanks,
>> >> David
>
> Thanks, Guido.
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
