Subject: Re: build fixes for selinux-doc-1.18
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andreas Steinmetz <ast@domdv.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112795269.24058.45.camel@moss-spartans.epoch.ncsc.mil>
References: <42512DC5.8060102@domdv.de>
	 <1112645570.7629.183.camel@moss-spartans.epoch.ncsc.mil>
	 <4252D39F.1070203@domdv.de>
	 <1112724337.15041.134.camel@moss-spartans.epoch.ncsc.mil>
	 <4252D7EA.9050500@domdv.de>
	 <1112795269.24058.45.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 09:55:48 -0400
Message-Id: <1112795748.24058.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-06 at 09:47 -0400, Stephen Smalley wrote:
> By "distribution", I mean the Linux distribution you are using, not our
> distribution of selinux-doc ;)
> 
> But I see that patches have been submitted on linux-kernel to change the
> kernel DocBook Makefile to use xmlto rather than db2*.  Do you have
> xmlto in your distro?  See http://marc.theaimsgroup.com/?l=linux-
> kernel&m=111278927418714&w=2.  I haven't tried xmlto yet myself, so I
> don't know what impact this has on the generated output.

Ah, just tried xmlto on one of the reports, and it didn't like it very
much.  Oh well.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
