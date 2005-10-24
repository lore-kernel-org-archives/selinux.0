Subject: Re: [ SEPOL ] Context interface cleanup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <435CF3F5.9040504@cornell.edu>
References: <43595049.2@cornell.edu>  <4359547D.3050001@cornell.edu>
	 <1130158079.17609.13.camel@moss-spartans.epoch.ncsc.mil>
	 <435CF3F5.9040504@cornell.edu>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 10:47:08 -0400
Message-Id: <1130165228.17609.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-24 at 10:47 -0400, Ivan Gyurdiev wrote:
> >
> > Note that libselinux provides context_* interfaces for context string
> > manipulation by security-aware applications (man context_new).
> >   
> 
> Hmm... so many ways to represent a context!

Yes, the libselinux interfaces were the original ones (those interfaces
even predate the SELinux API overhaul for Linux 2.6).  

> Should I be going the other way instead (i.e., leave sepol_ctx_struct 
> alone (but still do the other changes - move to internal header, 
> etc..)). Then in the future move context_* -> sepol_ctx_struct ?

No, I think what you have done is fine (well, still looking at the
patches), as long as these are purely libsepol internal functions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
