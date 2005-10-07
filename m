Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1128700907.1450.50.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <434699D7.9040307@cornell.edu>
	 <1128700907.1450.50.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 12:05:53 -0400
Message-Id: <1128701153.1450.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 12:01 -0400, Stephen Smalley wrote:
> checkpolicy doesn't require changes, other than the updating of the
> header file locations to continue using the include/sepol/policydb/*.h
> ones (already done in my working copy), and adjusting for the
> elimination of a global sepol_set_policyvers() (also already done in my
> working copy).  I'm not trying to enable checkpolicy to use the static
> libsepol.  

Sorry, s/static/shared/ above.

> I only want to allow libsemanage (and thus its users) to use
> the shared libsepol, so that semodule* no longer require the static
> libsepol and any new libsemanage-based programs likewise don't require
> it.  Fairly pointless to make libsemanage a shared lib if it depends on
> a static lib as a backend.  I might also convert audit2why.  Nothing in
> policycoreutils should really depend on the static libsepol, IMHO.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
