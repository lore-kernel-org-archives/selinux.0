From: David Howells <dhowells@redhat.com>
In-Reply-To: <200807091847.14347.paul.moore@hp.com>
References: <200807091847.14347.paul.moore@hp.com> <200807091821.46296.paul.moore@hp.com> <20080709161043.24255.62312.stgit@warthog.procyon.org.uk> <8198.1215643142@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: dhowells@redhat.com, sds@tycho.nsa.gov, jmorris@namei.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix a potentially uninitialised variable in SELinux hooks
Date: Thu, 10 Jul 2008 00:12:10 +0100
Message-ID: <8883.1215645130@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore <paul.moore@hp.com> wrote:

> 	ret = selinux_parse_skb_ipv4(...);
> 	if (ret != 0)
> 		addrp = (src ? ...);
> 	else
> 		addrp = NULL;

I guess you mean "*addrp = ..." in that case, otherwise you haven't eliminated
anything.

Personally, I prefer to add extra variables if it makes things clearer, and I
prefer to use gotos for error handling.  It eliminates the else-statements that
you would otherwise introduce, and the goto-label can be used as documentation
of a sort too.  Furthermore, it moves the error handling clearly out of the
main route through the function.  Having said that, I should reorder my patch
to put the parse_error segment last - then I can ditch the okay label and use
break instead of goto.

It comes down to personal preference, I guess.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
