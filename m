Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0F7rLpb023952
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 02:53:21 -0500
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0F7sDpg008771
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 07:54:13 GMT
From: Jim Meyering <jim@meyering.net>
To: James Antill <jantill@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
In-Reply-To: <1168838197.25232.9.camel@code.and.org> (James Antill's message
	of "Mon, 15 Jan 2007 00:16:37 -0500")
References: <45A7D773.8040800@redhat.com>
	<1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	<1168632626.13080.212.camel@code.and.org>
	<1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
	<1168636513.13080.227.camel@code.and.org>
	<873b6ffdi6.fsf@rho.meyering.net>
	<1168838197.25232.9.camel@code.and.org>
Date: Mon, 15 Jan 2007 08:54:11 +0100
Message-ID: <8764b8bu8s.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill <jantill@redhat.com> wrote:
> On Sat, 2007-01-13 at 11:05 +0100, Jim Meyering wrote:
>
>> Isn't that fsetfilecon call useful, since your example must
>> also handle an existing destination file?
>
>  Ahh, I see. I'd somehow missed the if check before the ifdef, or not
> parsed what it meant.
>
>  Note that this does mean that:
>
> % echo me > uid
> % sudo touch ouid_r ouid_w
> % sudo chmod o+w ouid_w
> % cp -a uid ouid_r
> cp: cannot create regular file `ouid_r': Permission denied
> zsh: 25994 exit 1     cp -a uid ouid_r
> % cp -a uid ouid_w
> zsh: 25995 exit 1     cp -a uid ouid_w

Thanks for the example.  I'll make that into a regression test.
I need a lot more of those for the SELinux-related changes.

That demonstrates two problems in the Red Hat version of cp.
Your first copy failed (as expected), because open-unreadable fails,
The second failed (#1: but with no diagnostic!) due to failure
to propagate the security context to the destination.  But imho, #2:
cp -a must not try to apply any security context to the destination.

Over the weekend I nearly completed my own merge, and tried that.
The latter "cp -a" still fails, but here because it fails to propagate
the time stamps to a file not owned by me:

  $ cp -a uid ouid_r
  cp: cannot create regular file `ouid_r': Permission denied
  [Exit 1]
  $ cp -a uid ouid_w
  cp: preserving times for `ouid_w': Operation not permitted
  [Exit 1]

With a little luck, I'll check it in and push today.

>> This is a good opportunity to ask about an old note I made:
>>   - is it worthwhile to check for getfscreatecon failure?
>>     The documentation says it can fail, but not how.
>>     Even it's truly a "can't happen" condition now, that might change.
>
>  IIRC it:
>
>  open's /proc/self/task/$$/attr/fscreate
>  reads the data
>  malloc's the correct length for the result and copies.
>
> ...either of these three operations can fail.

Thanks.  I added code to detect the failures and to give diagnostics.

>  So any ideas on how to make cp do the right thing in all cases ?:)

Can you give more examples of how it doesn't work?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
