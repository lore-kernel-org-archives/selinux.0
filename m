Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11088
	for <selinux@tycho.nsa.gov>; Sat, 29 Jun 2002 11:47:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA19895
	for <selinux@tycho.nsa.gov>; Sat, 29 Jun 2002 15:45:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA19891 for <selinux@tycho.nsa.gov>; Sat, 29 Jun 2002 15:45:44 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Clint Byrum <cbyrum@spamaps.org>
Subject: Re: SE Linux patch
Date: Sat, 29 Jun 2002 11:47:22 -0400
References: <1025294267.3367.22.camel@lancelot>
In-Reply-To: <1025294267.3367.22.camel@lancelot>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020629154722.6AF03106@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Jun 2002 15:57, you wrote:
> I think there is a tiny bit wrong with the current patches. I was using
> your page for directions on setting it up, so I thought I'd pass this
> along to you. If there is a better mailing list for this type of thing,
> let me know.

I have CC'd this to the SE Linux mailing list, hope that's OK.

> While running in dev mode, I was receiving TONS of these:
>
> Jun 28 02:30:32 ids1 kernel: avc:  denied  { read } for  pid=157
> exe=/sbin/klogd path=/kmsg dev=00:03 ino=4113
> scontext=system_u:system_r:klogd_t
> tcontext=system_u:system_r:tcp_socket_t tclass=file
>
> First problem: path=/kmsg .. should obviously be /proc/kmsg. I think
> avd_d_path() in avc.c is stripping this. No time to figure that one
> out...
>
> /proc/kmsg should not have a type of tcp_socket_t.

True, I think that the latest kernel patch is required to match the latest 
packages as it adds a type for "igmp" in the middle of the list.  I have just 
uploaded that patch package to Debian.

> I noticed that in /etc/selinux/initial_sid_context, the first 16 items
> were this:
[...]
> And a stat /proc/kmsg did in fact give a context of
> system_u:system_r:tcp_socket_t, but a SID of 16. In the code 16 is
> supposed to be PROC_KMSG.. so what gives? well the problem seems to be
> that igmp_packet is missing from these files:
[...]
> This caused everything to be off by one. The patch is below(sorry if its
> not in the right format. Works with -p1 for sure). Once I made this
> change things started working as promised.
>
> I'm wondering, how can this have been missed to this point?

Your analysis is correct, your patch is good.  The problem was the kernel not 
matching the policy (this will be a pain for upgrades), maybe we should have 
a new policy version for this...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
