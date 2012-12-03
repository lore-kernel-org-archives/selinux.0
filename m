Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB3HGBG8004830
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2012 12:16:11 -0500
Received: by mail-lb0-f181.google.com with SMTP id ge1so2613546lbb.12
        for <selinux@tycho.nsa.gov>; Mon, 03 Dec 2012 09:16:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1353417930-7707-1-git-send-email-guillem@debian.org>
References: <1353417930-7707-1-git-send-email-guillem@debian.org>
Date: Mon, 3 Dec 2012 12:16:09 -0500
Message-ID: <CACLa4pt4rRsdJGU6nhkmydKTbs+rsj=Tj-x=92-fDLVdU9Zhxg@mail.gmail.com>
Subject: Re: [PATCH 0/4] libselinux: Man pages cleanups and updates
From: Eric Paris <eparis@parisplace.org>
To: Guillem Jover <guillem@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I do not see patch 2/4.  Can you resend?

On Tue, Nov 20, 2012 at 8:25 AM, Guillem Jover <guillem@debian.org> wrote:
> Hi!
>
> While going through the SELinux documentation to improve its support
> in dpkg, I found some issues in the man pages. Here's some patches
> addressing them.
>
> I'm not sure the typo fix in “libselinux: Fix typo in man page” is
> entirely correct, being non-native an all. The formatting fixes bring
> the man pages closer in line with the linux-man project's style; I
> didn't split that one into smaller changes, because it didn't seem
> worth it though.
>
> Regards,
> Guillem
>
> Guillem Jover (4):
>   libselinux: Fix program synopsis and function prototypes in man pages
>   libselinux: Fix man pages formatting
>   libselinux: Fix typo in man page
>   libselinux: Add references and man page links to _raw function
>     variants
> --
> 1.8.0
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
