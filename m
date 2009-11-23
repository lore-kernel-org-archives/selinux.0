Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nANEUaAx010274
	for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2009 09:30:36 -0500
Received: from mail-iw0-f186.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nANETWCP016555
	for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2009 14:29:32 GMT
Received: by iwn16 with SMTP id 16so580890iwn.32
        for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2009 06:29:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <23f05c720911230524y68726481q737b6b02d77f1ea9@mail.gmail.com>
References: <23f05c720911230524y68726481q737b6b02d77f1ea9@mail.gmail.com>
Date: Mon, 23 Nov 2009 08:23:16 -0600
Message-ID: <cadfc0e40911230623h2462cf29pc525c2056d5b4ced@mail.gmail.com>
Subject: Re: Confining Applications to Specific Directories
From: Xavier Toth <txtoth@gmail.com>
To: "Timothy L. Watt" <tlwatt@tenacitysolutions.net>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Create a unique type for the directory and the application. In the
applications policy allow it access to only the directory type.
However typically you do need read access to other file types to do
things like load shared libraries.

Ted

On Mon, Nov 23, 2009 at 7:24 AM, Timothy L. Watt
<tlwatt@tenacitysolutions.net> wrote:
> I am looking for a precise guide (how-to) on confining applications to
> specific directories with SELinux; ex. confining a custom application
> to its install directory.
>
> Thanks in advance.  -  Tim
>
> --
> Sent from my mobile device
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
