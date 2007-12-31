Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBVGtrDE014562
	for <selinux@tycho.nsa.gov>; Mon, 31 Dec 2007 11:55:53 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBVGtqI8023522
	for <selinux@tycho.nsa.gov>; Mon, 31 Dec 2007 16:55:53 GMT
Received: by py-out-1112.google.com with SMTP id a78so887017pyh.32
        for <selinux@tycho.nsa.gov>; Mon, 31 Dec 2007 08:55:52 -0800 (PST)
Message-ID: <7e0fb38c0712310855k784cb592la583bb84bfaec8f8@mail.gmail.com>
Date: Mon, 31 Dec 2007 11:55:51 -0500
From: "Eric Paris" <eparis@parisplace.org>
To: "Jeremiah Jahn" <jeremiah@goodinassociates.com>
Subject: Re: Kernel panic when using refpolicy
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1198951732.4073.992.camel@bluejay.goodinassociates.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1198951732.4073.992.camel@bluejay.goodinassociates.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix won't appear until 5.2 see:

https://bugzilla.redhat.com/show_bug.cgi?id=223827

I apologize to everyone who is still hitting this problem, I screwed
up on some administrative stuff and didn't get it into 5.1.  You
should be able to find links to 5.2 test kernels to verify it is fixed
in that BZ.

(as a side note RHEL specific questions like this are probably better
suited for fedora-selinux-list or RH bugzilla, but I read them all so
it doesn't really matter)

-Eric

On 12/29/07, Jeremiah Jahn <jeremiah@goodinassociates.com> wrote:
> sorry, to bring this up again, but FYI, it doesn't look like the kernel
> bug got fixed in RHEL5U1. I took the most recent refpolicy and left the
> type set to standard; make load; touch /.autorelabel;reboot; all hell
> broke loose. however, if I set the type=mcs then do the above everything
> is fine. I had to pull the harddrive, and edit the policy config to get
> the system back up.
>
> -jj-
>
>
>
>
> You have the capacity to learn from mistakes. You'll learn a lot today.
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
