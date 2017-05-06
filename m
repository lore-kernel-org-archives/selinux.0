Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v46G7fri009630
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 12:07:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id w138so2838151oiw.3
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 09:07:36 -0700 (PDT)
Subject: Re: Why does Python want to read /proc/meminfo
To: dieter <dieter@handshake.de>
References: <72df5e72-55ac-5696-ceb6-f50f98a35ea5@gmail.com>
 <87tw4yfs82.fsf@handshake.de>
Cc: python-list@python.org, selinux <selinux@tycho.nsa.gov>
From: Ian Pilcher <arequipeno@gmail.com>
Message-ID: <8b1d353c-7f98-5522-4f42-906a7082d47a@gmail.com>
Date: Sat, 6 May 2017 11:07:34 -0500
MIME-Version: 1.0
In-Reply-To: <87tw4yfs82.fsf@handshake.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/06/2017 12:51 AM, dieter wrote:
> Personally, I doubt that you will find a reference.
> Instead, I assume that the reference comes from the C runtime library.
> It might hepl optimize memory management to know about "meminfo" details.

You're right.  Seems that it's glibc's qsort().

So it seems that any service written in Python (or any other program
that uses qsort) needs to be given read access to most of /proc or deal
with the (unspecified) consequences of not allowing qsort() to determine
the amount of memory in the system.

Delightful.

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
