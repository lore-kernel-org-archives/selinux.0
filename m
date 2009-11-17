Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAHJQ77L002037
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 14:26:07 -0500
Received: from mail-iw0-f202.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAHJSAjP026877
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 19:28:11 GMT
Received: by iwn40 with SMTP id 40so259635iwn.32
        for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 11:26:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <834B41F71BFB1D4385FC5E62CF526DCE01C59D23@XMBIL123.northgrum.com>
References: <834B41F71BFB1D4385FC5E62CF526DCE01C59D17@XMBIL123.northgrum.com>
	 <834B41F71BFB1D4385FC5E62CF526DCE01C59D23@XMBIL123.northgrum.com>
Date: Tue, 17 Nov 2009 13:26:06 -0600
Message-ID: <cadfc0e40911171126j5ae57d6ela0563638be8a5083@mail.gmail.com>
Subject: Re: Windows-level enforcement in SELinux?
From: Xavier Toth <txtoth@gmail.com>
To: "Dyson, Mark L (IS)" <Mark.Dyson@ngc.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On a system with selinux-policy-mls install you will find a file
/etc/selinux/mls/contexts/x_contexts which will give you an idea about
the labeling of various X object. X objects are label with the level
of the X application process and the mls constraints control
operations like copy/paste you mention which is prohibited.

Ted

On Tue, Nov 17, 2009 at 8:21 AM, Dyson, Mark L (IS) <Mark.Dyson@ngc.com> wrote:
> I’ll narrow the scope of my initial question a bit, here:  can SELinux
> support this sort of operation?  Some online literature seems to suggest
> otherwise but it’s admittedly a few years old.
>
>
>
> Thanks again,
>
> Mark
>
>
>
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Dyson, Mark L (IS)
> Sent: Monday, November 16, 2009 10:09 AM
> To: selinux@tycho.nsa.gov
> Subject: Windows-level enforcement in SELinux?
>
>
>
> Hello,
>
> I’ve been tasked to map out a path for migrating a MLS application from
> Trusted Solaris to SELinux.  I’m sure I’ll have many questions to come, but
> after some initial readings one of my first is:
>
> How does SELinux label individual X-windows in a user session, so that (for
> example) data contained in a high-level security window cannot be copied and
> then pasted into a lower-level security window?
>
> Thanks in advance!
> Mark


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
