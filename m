Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o12GwiFO026005
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 11:58:44 -0500
Received: from authsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o12GwlXo008112
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 16:58:47 GMT
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1265129074.3114.20.camel@moss-pluto.epoch.ncsc.mil>
References: <1265120566.3003.5.camel@tesla.lan>
	 <1265129074.3114.20.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 Feb 2010 17:58:40 +0100
Message-Id: <1265129920.3003.28.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again !

On Tue, 2010-02-02 at 11:44 -0500, Stephen Smalley wrote:
> On Tue, 2010-02-02 at 15:22 +0100, Guido Trentalancia wrote:
> Patch mangled by your mail client, probably because you signed it.
> Read and follow the instructions in Documentation/email-clients.txt, or
> switch to another client.  In the case of Evolution, for example, you
> set the paragraph style to Preformat and then use Insert->Text File to
> insert the patch into the message.  To test, email it to yourself, save
> the email message and try applying it.

That's really odd. I have followed the advice in
Documentation/email-clients.txt which you quoted... I don't know what
else to do. Perhaps, I can send the final version as an attachment to
the list and then you can forward that to the kernel mailing list ?

> You want a "---" line before the diffstat output so that it doesn't get
> included in the git log.

That's fine. I'll add such a line between the description and the
diffstat output.

> Did you give up on addressing the initial SID issue or are you saving
> that for a later, separate patch?
> 
> Technically, security_mls_enabled() does not return True or False; it
> returns 1 or 0.

Yes, of course, I was just following your style since the next function
comments "boolean" (read "integer to be interpreted as a boolean").
However I have now changed the comment.

> Your if (args->oldp->mls_enabled...)else if...else block is hard to read
> with the comment placement.  I'd move them within the conditional block
> and use { } for all three clauses for ease of reading.

That's what I did, but then checkpatch.pl was complaining about the {}
block with a single statement (in disagreement with CodingStyle, so it's
an inconsistency in the script with respect to the guidelines). I can do
that easily, but then we'll get a warning !

Please let me know about the oops for ebitmap_destroy(). Do you think it
is due to the initial SID issue rather than to calling mls_destroy() for
a standard policy ? I wasn't saving that for a separate patch, it's just
that we did not discuss that further...

Regards,

Guido



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
