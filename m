From: Paul Moore <paul.moore@hp.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Fix a potentially uninitialised variable in SELinux hooks
Date: Wed, 9 Jul 2008 21:23:40 -0400
Cc: sds@tycho.nsa.gov, jmorris@namei.org, selinux@tycho.nsa.gov
References: <200807091847.14347.paul.moore@hp.com> <8198.1215643142@redhat.com> <8883.1215645130@redhat.com>
In-Reply-To: <8883.1215645130@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807092123.40667.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 July 2008 7:12:10 pm David Howells wrote:
> Paul Moore <paul.moore@hp.com> wrote:
> > 	ret = selinux_parse_skb_ipv4(...);
> > 	if (ret != 0)
> > 		addrp = (src ? ...);
> > 	else
> > 		addrp = NULL;
>
> I guess you mean "*addrp = ..." in that case, otherwise you haven't
> eliminated anything.

Yes, I did.  Too much pseudo in my pseudo-code I guess.

> Personally, I prefer to add extra variables if it makes things
> clearer, and I prefer to use gotos for error handling.  It eliminates
> the else-statements that you would otherwise introduce, and the
> goto-label can be used as documentation of a sort too.  Furthermore,
> it moves the error handling clearly out of the main route through the
> function.  Having said that, I should reorder my patch to put the
> parse_error segment last - then I can ditch the okay label and use
> break instead of goto.
>
> It comes down to personal preference, I guess.

Doesn't it always :)

I don't think it makes a huge difference either way, and since you are 
the one fixing the problem I'll let you decide.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
