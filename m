Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <4346FB32.6020805@cornell.edu>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1128719862.1450.119.camel@moss-spartans.epoch.ncsc.mil>
	 <4346FB32.6020805@cornell.edu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 08:32:17 -0400
Message-Id: <1129033937.3308.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 18:48 -0400, Ivan Gyurdiev wrote:
> Hmm, that's true... we should separate the handle.
> Are there any other uses for a handle, besides debugging settings?

Not for libsepol, I think.  So it likely could replace the verbose,
error_buf, and error_buf_size arguments for the sepol_link_packages,
sepol_link_modules, and sepol_expand_module interfaces.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
