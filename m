Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s46ECMka032090
 for <selinux@tycho.nsa.gov>; Tue, 6 May 2014 10:12:22 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so2466534lbv.7
 for <selinux@tycho.nsa.gov>; Tue, 06 May 2014 07:12:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <006701cf6934$1d4c4fb0$57e4ef10$@nrl.navy.mil>
References: <006701cf6934$1d4c4fb0$57e4ef10$@nrl.navy.mil>
Date: Tue, 6 May 2014 10:12:21 -0400
Message-ID: <CACLa4psgYGHRjy-NsnmCuo+Naq45a+4tVvbtanQ7zipX=6cWWQ@mail.gmail.com>
Subject: Re: No AVCs written to /var/log/messages
From: Eric Paris <eparis@parisplace.org>
To: kim.lawson-jenkins@nrl.navy.mil
Content-Type: text/plain; charset=UTF-8
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Two possible things.

1) in permissive you only get the same denial one time.  So if you
launch a program and it causes some denials, the second time you
launch it there will be no denials.

2) If they are early in boot, before syslog starts, they might be
lost, or in old machines there was a /var/log/dmesg...

Do you see the denials when you run the dmesg command?

On Tue, May 6, 2014 at 10:04 AM, Kim Lawson-Jenkins
<kim.lawson-jenkins@nrl.navy.mil> wrote:
> Hi,
>
>
>
> I’m working on an embedded system using SELinux.  The audit daemon is not
> running so AVC errors should be written to /var/log/messages.  SELinux is
> running in permissive mode and during a system reboot I see a few AVC errors
> written to a console.  However when I look in /var/log/messages there are no
> AVC errors.  I haven’t seen a similar problem reported in the past.  Does
> anyone have any ideas why AVC errors would not be written to
> /var/log/messages if the audit daemon is not running?  I’ve checked
> syslog.conf and all messages with a priority of warning and above should be
> written to /var/log/messages.
>
>
>
> Kim
>
>
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
