Message-ID: <4252D39F.1070203@domdv.de>
Date: Tue, 05 Apr 2005 20:06:23 +0200
From: Andreas Steinmetz <ast@domdv.de>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: build fixes for selinux-doc-1.18
References: <42512DC5.8060102@domdv.de> <1112645570.7629.183.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1112645570.7629.183.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Hmmm...well, db2html appears to create a separate directory for the
> output files, and copies stylesheet images into it as well.  The use of
> db2html was patterned after its use in the kernel
> Documentation/DocBook/Makefile.  Hence, I'm hesitant to merge the latter
> change without further justification.

I see. Would you accept a patch that uses db2html if available and
docbook2html otherwise? If so I can come up with this probably on
thursday, maybe friday.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
