Subject: Re: [ SEPOL ] Further users cleanup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <435E56CD.9030003@cornell.edu>
References: <435903C2.2050805@cornell.edu>
	 <1129908379.27663.59.camel@moss-spartans.epoch.ncsc.mil>
	 <4359199A.40303@cornell.edu>
	 <1129916287.27663.94.camel@moss-spartans.epoch.ncsc.mil>
	 <1130252431.17609.326.camel@moss-spartans.epoch.ncsc.mil>
	 <435E56CD.9030003@cornell.edu>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 13:02:20 -0400
Message-Id: <1130259740.17609.345.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-25 at 12:01 -0400, Ivan Gyurdiev wrote:
> Stephen Smalley wrote:
> > On Fri, 2005-10-21 at 13:38 -0400, Stephen Smalley wrote:
> >   
> >> Also need to fix this:
> >> $ relinfo.pl src/libsepol.so.1
> >> src/libsepol.so.1: 68 relocations, 61 relative (89%), 94 PLT entries, 60 for local syms (63%), 0 users
> >>
> >> There shouldn't be any for local syms; need to bring over dso.h and
> >> hidden_def/hidden_proto stuff from libselinux.
> >>     
> >
> > Attached patch does this for the sepol_bool functions used internally by
> > libsepol. 
> I'm confused, the bool_record is supposed to be exported out of sepol... 
> it's shared with semanage. That could change, based on the current 
> discussion of sharing records... but I wasn't sure if that's what you 
> intended.

hidden_def/hidden_proto isn't about hiding the symbol from users of the
shared library (that would be done by marking it "hidden", or in the
libsepol case, by omitting it from the map file).
hidden_def/hidden_proto creates an internal reference to the symbol for
use within the library so that intra-library use doesn't require a
relocation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
