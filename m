Subject: Re: build fixes for selinux-doc-1.18
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andreas Steinmetz <ast@domdv.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4252D39F.1070203@domdv.de>
References: <42512DC5.8060102@domdv.de>
	 <1112645570.7629.183.camel@moss-spartans.epoch.ncsc.mil>
	 <4252D39F.1070203@domdv.de>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 14:05:37 -0400
Message-Id: <1112724337.15041.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-05 at 20:06 +0200, Andreas Steinmetz wrote:
> Stephen Smalley wrote:
> > Hmmm...well, db2html appears to create a separate directory for the
> > output files, and copies stylesheet images into it as well.  The use of
> > db2html was patterned after its use in the kernel
> > Documentation/DocBook/Makefile.  Hence, I'm hesitant to merge the latter
> > change without further justification.
> 
> I see. Would you accept a patch that uses db2html if available and
> docbook2html otherwise? If so I can come up with this probably on
> thursday, maybe friday.

Wouldn't it just be easier to add db2html to the distribution?  It
appears to be a trivial script (not quite as trivial as docbook2html,
but still quite simple), and the kernel DocBook Makefile seems to rely
on it without anyone complaining about that.  Falling back to
docbook2html yields a different result (i.e. no separate directory for
the output), so it wouldn't work anyway for the spec file.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
