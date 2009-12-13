Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBDIAunJ030345
	for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 13:10:56 -0500
Received: from mail-pw0-f55.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBDIDGev018170
	for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 18:13:17 GMT
Received: by pwj2 with SMTP id 2so1514688pwj.34
        for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 10:10:53 -0800 (PST)
Message-ID: <4B252E41.6070501@gmail.com>
Date: Sun, 13 Dec 2009 10:11:13 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: avc's generated causes the system to freeze up
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com> <1260722550.2858.13.camel@tesla.lan>
In-Reply-To: <1260722550.2858.13.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/09 08:42, Guido Trentalancia wrote:
> Justin,
>
> your question seems more of an audit question.
>
> Why don't you use audit2allow to sort this out from a SELinux point of
> view instead than trying to shut up audit ?
>
> Audit2allow can generate custom rules for you from the analysis of your
> audit log messages. The rules can then be compiled into a custom policy
> module, that you can install with semodule.
>
>

I can easily create an allow rule with audit2allow.

The issue is not creating an allow rule,
but having Xorg.0.log spammed with a denial
causing the system to freeze up, until
the avc is done doing with whatever it's doing
(in this case logging many denials of the same one).

hence the reason for wondering if theres a mechanism that could
be put in place like prinkt_ratelimit for
Xorg.0.log this way I don't get spammed with a denial.

Justin P. Mattock





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
