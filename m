Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75EHLAe015704
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:17:21 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m75EHKSF018426
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 14:17:20 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1334560fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 05 Aug 2008 07:17:19 -0700 (PDT)
Message-ID: <cadfc0e40808050717j6a042fedle997df133400456@mail.gmail.com>
Date: Tue, 5 Aug 2008 09:17:19 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Dennis Wronka" <linuxweb@gmx.net>
Subject: Re: Question about newrole
Cc: "SELinux Mailing List" <selinux@tycho.nsa.gov>
In-Reply-To: <200808052155.18105.linuxweb@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200808052155.18105.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 5, 2008 at 8:55 AM, Dennis Wronka <linuxweb@gmx.net> wrote:
> Hi folks,
>
> I'd like to ask about a problem I am experiencing with newrole.
> When I use newrole in permissive-mode I have no problems changing the role.
> Also I don't get any audit-messages.
> But when I switch to enforcing-mode I cannot use newrole, it keeps telling
> me "incorrect password for root", although it clearly is correct.
> I suspect a problem in interaction between newrole and unix_chkpwd, but am not
> entirely sure about it.
>
> Problem is that I don't get any audits from SELinux, only errors in auth.log
> from unix_chkpwd:
> check_pass; user unknown
> password check failer for user (root)
>
> I am working with the latest reference-policy, adjusted here and there to fit
> the needs of my distro.
>
> Thanks for any suggestions.
>
> Dennis
>

You can try using `semodule -DB` to turn off the dontaudits and see if
you get any AVCs then.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
