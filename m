Message-ID: <4B101DAC.5080801@manicmethod.com>
Date: Fri, 27 Nov 2009 13:42:52 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux@tycho.nsa.gov
Subject: Re: [PATCH] Support for long-options in policycoreutils and checkpolicy
 (Ticket #1 [1672486])
References: <1257206276.24413.26.camel@tesla.lan>	 <4B07537B.7070204@tycho.nsa.gov> <1258841039.3002.214.camel@tesla.lan>
In-Reply-To: <1258841039.3002.214.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Guido Trentalancia wrote:
> Dear Eamon,
>
> here are the two "maintenance" patches that I did post earlier this
> month (along with the new manual pages). They are intended to close
> Ticket #1 [1672486] that I found open on Tresys pages
> (http://userspace.selinuxproject.org/trac/ticket/1).
>
> I do apologize for not putting the keyword "[PATCH]" in the original
> message.
>
> Here is a summary of what has been changed for policycoreutils:
>
> - introduced proper handling of -h, -V options and their respective long
> formats --help and --version to all binaries that are produced from C
> code. The same issue is not tackled for Python-based tools (e.g.
> semanage);
> - relative manual pages have also been updated accordingly.
>
> And here is what has been changed for checkpolicy/checkmodule:
>
> - introduced proper handling of -h, -V and the long formats --help and
> --version to all binaries (checkpolicy/checkmodule);
> - introduced the handling of long options for some of the other
> available options;
> - manual pages have also been updated accordingly (and a few
> undocumented options have been documented).
>
> One of the original two patches (the one against policycoreutils) did
> not compile cleanly anymore against the current HEAD of SELinux, so I
> have created an updated one, which is the one attached here.
>
> It's just a matter of some really minor issues, but I hope it helps, at
> least the ticket can now be closed...
>
> Kind regards,
>
> Guido
>


Thank you for doing this. Unfortunately it looks like your mail client 
decided to base64 encode the attachment.

It is always best to use git to generate patch emails, please see:
http://andrewprice.me.uk/weblog/entry/generating-patch-emails-with-git


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
