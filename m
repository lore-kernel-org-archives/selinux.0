Subject: Re: Threaded applications and "execmem" privilege
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <1133191110.5276.17.camel@wintermute.xmldesign.de>
References: <1132504528.12651.21.camel@wintermute.xmldesign.de>
	 <1132672653.28079.10.camel@wintermute.xmldesign.de>
	 <1133188277.348.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1133191110.5276.17.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 10:36:55 -0500
Message-Id: <1133192215.348.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-28 at 16:18 +0100, Erich Schubert wrote:
> Okay, that probably means that most apps (maybe not java and x.org, but
> I don't have these on my selinux boxes anyway) should work just fine.
> And others probably too, since IIRC i386 doesn't enforce that anyway...
> But I'll switch to the patch you posted.

I'd suggest just using a newer upstream glibc altogether if possible.
There are a number of diffs to that file in the cvs.

> I don't have this "execstack -q" application. Seems to be
> Redhat-specific.

Provided by the prelink package in Fedora.  Looks like Jakub Jelinek of
Red Hat is the upstream maintainer of prelink.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
