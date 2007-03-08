Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <45F038C5.4070003@tycho.nsa.gov>
References: <45EC0D21.2070706@kaigai.gr.jp>  <45EC2C10.6050603@kaigai.gr.jp>
	 <1173284267.10747.9.camel@sgc>  <45F010A4.4020201@kaigai.gr.jp>
	 <1173360830.10467.29.camel@moss-spartans.epoch.ncsc.mil>
	 <45F022A0.3020105@kaigai.gr.jp>
	 <1173366058.10467.67.camel@moss-spartans.epoch.ncsc.mil>
	 <45F02A09.5060301@tresys.com>  <45F02A80.5050708@tresys.com>
	 <1173367847.10467.72.camel@moss-spartans.epoch.ncsc.mil>
	 <45F038C5.4070003@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 15:23:56 -0500
Message-Id: <1173385436.3241.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 11:24 -0500, Eamon Walsh wrote:
> Stephen Smalley wrote:
> 
> > There are already string_to_security_class() and string_to_av_perm()
> > functions provided by libselinux, although they should likely have
> > properly namespaced versions (selinux_ prefix).
> 
> If we're talking about the API in this area: I had a request for 
> security_class_to_string and av_perm_to_string functions, I believe from 
> KaiGai.  The patch in the below e-mail adds them; this could be applied 
> as an independent patch.
> 
> http://marc.theaimsgroup.com/?l=selinux&m=116486019626891&w=2

Ok, so we could:
- introduce new versions of the existing string_to_* functions with a
security_ or selinux_ prefix for namespace cleanliness,
- merge that patch, using the same convention for naming (either as is
with security_ or replacing with selinux_,
- have KaiGai rewrite his code to use these functions to map class and
permission strings to policy values during startup of SEPostgreSQL,
generating lookup tables for later use by the actual permission checks
(where the lookup tables would map internal indices private to
SEPostgreSQL to the policy-defined values obtained from libselinux).
The tables would need to be revalidated and potentially refreshed upon a
policy reload, which could be done from an AVC callback.

Then SEPostgreSQL no longer needs to be compile-time bound to specific
policy values for its classes and permissions.

Same could be done for XSELinux, right?

Then when we have the dynamic discovery mechanism implemented, it can
just be used by those libselinux functions internally, with no further
change to the object managers.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
