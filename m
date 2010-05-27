Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4R0egLi020901
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 20:40:42 -0400
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4R0g1S0003753
	for <selinux@tycho.nsa.gov>; Thu, 27 May 2010 00:42:01 GMT
Received: by gyg8 with SMTP id 8so4206809gyg.12
        for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 17:40:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinESptHxDYCPSiRJca5_-fK4DsiDwd_KQzQN6gX@mail.gmail.com>
References: <AANLkTinESptHxDYCPSiRJca5_-fK4DsiDwd_KQzQN6gX@mail.gmail.com>
Date: Wed, 26 May 2010 20:40:41 -0400
Message-ID: <AANLkTikXXwLPbfr8sG9YiAsKggZeRVAtU7FUF8Wgk1lg@mail.gmail.com>
Subject: Re: SELinux support in Libc
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Shaz <shazalive@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 26, 2010 at 3:05 AM, Shaz <shazalive@gmail.com> wrote:
> Dear all,
>
> I was building eglibc and saw selinux support flag in it's configure script.
> Any idea what this is used for. Some hints and pointers needed.
>
> SELinux works for me without this support as far as I understand but need to
> get all the goodies that are available. Couln't find anything with a bit of
> googling!

The nscd was instrumented as a userspace object manager a long time
ago at the request of its maintainers.  The original motivation was
when it introduced support for exporting direct access to the mapped
database files to the clients, but general access controls were added
for all of its services at the time.  See the class ncsd definitions
in the access_vectors file and the nscd.if and nscd.te policy files.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
