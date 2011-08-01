Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p71HDdUg026335
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 13:13:39 -0400
Received: from smtp188.iad.emailsrvr.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p71HDcOo024681
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 17:13:38 GMT
Subject: Re: chown affecting type_transition?
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Joe Nall <joe@nall.com>
In-Reply-To: <CAFPpqQEYmrYQWDS8t0Y2DcF3jXoyO=2f929jNuvFKyXjNG=OhQ@mail.gmail.com>
Date: Mon, 1 Aug 2011 12:13:37 -0500
Cc: SELinux <selinux@tycho.nsa.gov>
Message-Id: <3DADE489-D7CA-4181-B6BA-8E8AB33E2119@nall.com>
References: <CAFPpqQEYmrYQWDS8t0Y2DcF3jXoyO=2f929jNuvFKyXjNG=OhQ@mail.gmail.com>
To: Ted Toth <txtoth@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 1, 2011, at 10:32 AM, Ted Toth wrote:

> I'm writing policy for some scripts. Script 'a' runs script 'b' and they
> each have their own entry file and domain type. There is a type transition
> for a_t through b_exec_t to b_t in the policy. However the transition
> doesn't happen. Script 'a' does a chown on script 'b' prior to running it.
> If I remove the chown the transition does happen as expected. Can chown
> somehow affect the file label? 'ls -Z' doesn't show any change.

Does the transition occur if b is already chowned? Could you have a DAC issue after the chown?

joe




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
