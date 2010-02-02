Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1265129920.3003.28.camel@tesla.lan>
References: <1265120566.3003.5.camel@tesla.lan>
	 <1265129074.3114.20.camel@moss-pluto.epoch.ncsc.mil>
	 <1265129920.3003.28.camel@tesla.lan>
Content-Type: text/plain
Date: Tue, 02 Feb 2010 12:34:04 -0500
Message-Id: <1265132044.3114.31.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-02 at 17:58 +0100, Guido Trentalancia wrote:
> Hello again !
> 
> On Tue, 2010-02-02 at 11:44 -0500, Stephen Smalley wrote:
> > On Tue, 2010-02-02 at 15:22 +0100, Guido Trentalancia wrote:
> > Patch mangled by your mail client, probably because you signed it.
> > Read and follow the instructions in Documentation/email-clients.txt, or
> > switch to another client.  In the case of Evolution, for example, you
> > set the paragraph style to Preformat and then use Insert->Text File to
> > insert the patch into the message.  To test, email it to yourself, save
> > the email message and try applying it.
> 
> That's really odd. I have followed the advice in
> Documentation/email-clients.txt which you quoted... I don't know what
> else to do. Perhaps, I can send the final version as an attachment to
> the list and then you can forward that to the kernel mailing list ?

You can't digitally sign the message w/o causing the inlined patch to be
encoded.  So don't digitally sign patch postings.

> That's what I did, but then checkpatch.pl was complaining about the {}
> block with a single statement (in disagreement with CodingStyle, so it's
> an inconsistency in the script with respect to the guidelines). I can do
> that easily, but then we'll get a warning !

That's ok.  checkpatch is just advisory; it still falls to a person to
make the final judgment.

> Please let me know about the oops for ebitmap_destroy(). Do you think it
> is due to the initial SID issue rather than to calling mls_destroy() for
> a standard policy ? I wasn't saving that for a separate patch, it's just
> that we did not discuss that further...

I'd rather track down the cause and see if we can allow
mls_context_destroy() to be unconditionally safe.  In fact, I'm tempted
to drop the mls_enabled tests from all of those inline functions and
just ensure that the fields are always properly initialized and thus the
functions will just evaluate properly even in the non-MLS case.

Chris is correct btw - the kernel has no notions of "standard", or
"MCS".  It only knows about MLS-enabled vs MLS-disabled.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
