Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UDDanU014409
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 09:13:36 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UDDYiN012641
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:13:35 GMT
To: russell@coker.com.au
Cc: bug-coreutils@gnu.org, selinux@tycho.nsa.gov
Subject: Re: SELinux for upstream coreutils, finally (RFC: does mkdir need -Z?)
From: Jim Meyering <jim@meyering.net>
In-Reply-To: <200703302237.35950.russell@coker.com.au> (Russell Coker's message of "Fri\, 30 Mar 2007 23\:37\:30 +1100")
References: <87tzw3x9mo.fsf@rho.meyering.net>
	<200703302237.35950.russell@coker.com.au>
Date: Fri, 30 Mar 2007 15:13:03 +0200
Message-ID: <87odmayiw0.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> wrote:
> On Friday 30 March 2007 21:18, Jim Meyering <jim@meyering.net> wrote:
>> Regarding the --context=C (-Z C) option that is now accepted by
>> mkdir, mknod, mkfifo, and install, I am inclined to
>
> Currently mkdir, mknod, and mkfifo support a -m option to set the mode.
> Install has options to also set the owner and group.

Hi Russell,

Thanks for the quick feedback.
As implied here,

    http://www.redhat.com/archives/fedora-list/2006-August/msg02264.html

I agree that one should be able to get the effect you want.  However,
adding a -Z option to each and every affected program is not the only way.

What did you think of the proposal (in the link above) for

    fscon CTX mkdir /new/directory

IMHO, it's not so much less "user friendly" than this equivalent:

    mkdir -C CTX /new/directory

I would prefer not to add new options in so many programs when a
less-invasive approach is possible.

> I think that all programs which set the uid and gid of a file should also be
> able to set the SE Linux context.
>
> It also seems reasonable that a program which can create a file with
> particular permissions should also be permitted to create it with a
> particular context.

I was hoping for feedback on whether the proposed alternative (using
fscon and maybe runcon proxies) looked viable from a usability standpoint.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
