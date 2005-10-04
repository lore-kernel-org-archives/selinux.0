Subject: Re: [ SEMANAGE ] Break up interfaces.h, implement parsing helpers
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <433DEB43.1020605@cornell.edu>
References: <433DA069.3090208@cornell.edu>
	 <1128112109.12459.216.camel@moss-spartans.epoch.ncsc.mil>
	 <433DA664.6040600@cornell.edu> <433DD618.1070508@cornell.edu>
	 <433DEB43.1020605@cornell.edu>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 10:54:10 -0400
Message-Id: <1128437650.26285.400.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 21:49 -0400, Ivan Gyurdiev wrote:
> Patch redistributes interfaces.h back into database.h, database_file.h, 
> database_direct.h.
> I promise I'll stop moving functionality around now - I'm very happy 
> with where it's at (for now :)
> 
> Moves parse stuff into parse_utils.[c,h]. Implement parsing helpers that 
> will be used for  the user parser (and others). Testing?
> It used to work (and pass valgrind) back when I was implementing it for 
> libselinux and libsepol. Haven't tested it since then, but nothing's 
> changed. Since nothing's using this code, I thought it'd be okay to 
> merge - even if it has bugs (which it shouldn't). I'll do more testing 
> when I get the rest of the framework set up, so I can read the files.

Merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
