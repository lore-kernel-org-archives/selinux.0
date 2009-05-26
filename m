Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4QILFYg022523
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 14:21:15 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4QILQ4n014368
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 18:21:27 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id n4QIKkbE017746
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 14:20:46 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id n4QIKkQI017744
	for selinux@tycho.nsa.gov; Tue, 26 May 2009 14:20:46 -0400
Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4QHJ2Hf009220
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 13:19:02 -0400
Received: from qw-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4QHIu5p015296
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 17:18:57 GMT
Received: by qw-out-1920.google.com with SMTP id 5so779999qwf.30
        for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 10:18:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A1C0BC7.2@redhat.com>
References: <4A1C0BC7.2@redhat.com>
Date: Tue, 26 May 2009 10:12:42 -0700
Message-ID: <dd18b0c30905261012wa397008wef0a4388d6ee1e58@mail.gmail.com>
Subject: Re: Introducing SELinux Sanbox
From: Justin Mattock <justinmattock@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 26, 2009 at 8:33 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> For those who do not ordinarily read my blog.
>
> http://danwalsh.livejournal.com/28545.html
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>

hey, nice article.
What are your thoughts about
flashplayer?
I myself enjoy watching T.V. through flash,
although seeing all of the avc's generated does scare me a bit.
even though the avc's are just {read, geattr, search, open}
(looked into gnash, but compiling that from source requires quit a bit)

If only flash could be as simple as watching T.V. through mplayer,
which generates far less avc's.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
