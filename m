Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael LeMay <lemaymd@lemaymd.com>
Cc: Valdis.Kletnieks@vt.edu, David Howells <dhowells@redhat.com>,
        Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <447F0093.3090601@lemaymd.com>
References: <1149161971.524.283.camel@moss-spartans.epoch.ncsc.mil>
	 <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil>
	 <11225.1149156553@warthog.cambridge.redhat.com>
	 <14858.1149164860@warthog.cambridge.redhat.com>
	 <1149171695.524.360.camel@moss-spartans.epoch.ncsc.mil>
	 <200606011452.k51Eqdl5003497@turing-police.cc.vt.edu>
	 <447F0093.3090601@lemaymd.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 11:17:18 -0400
Message-Id: <1149175038.524.387.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-01 at 10:58 -0400, Michael LeMay wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > On Thu, 01 Jun 2006 10:21:35 EDT, Stephen Smalley said:
> >
> >   
> >> Ok, given these considerations, I think we should just drop the unlink
> >> check for now, and proceed with the rest of the patch (modulo
> >> CodingStyle issues).
> >>     
> >
> > Should we put a note in Documentation/keys.txt to that effect?
> >
> >   
> I wonder if it would be best to leave that out of the documentation for 
> now, since it isn't mentioned anywhere else and hasn't been discussed 
> until now...

Yes, I don't think we need to document it unless/until we implement such
a check.  We can add a small section to keys.txt that explains that
SELinux labels keys based on the allocating task security context (and
then amend that to note /proc/self/attr/keycreate when it is supported)
and applies a parallel permission check for each normal key permission
check between the acting task security context and the key security
context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
