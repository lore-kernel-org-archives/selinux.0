Subject: Re: [ SEPOL ] Further users cleanup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <435E6AD9.2090105@cornell.edu>
References: <435903C2.2050805@cornell.edu>
	 <1129908379.27663.59.camel@moss-spartans.epoch.ncsc.mil>
	 <4359199A.40303@cornell.edu>
	 <1129916287.27663.94.camel@moss-spartans.epoch.ncsc.mil>
	 <1130252431.17609.326.camel@moss-spartans.epoch.ncsc.mil>
	 <435E56CD.9030003@cornell.edu>
	 <1130259740.17609.345.camel@moss-spartans.epoch.ncsc.mil>
	 <435E6AD9.2090105@cornell.edu>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 13:25:21 -0400
Message-Id: <1130261121.17609.369.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-25 at 13:26 -0400, Ivan Gyurdiev wrote:
> >> I'm confused, the bool_record is supposed to be exported out of sepol... 
> >> it's shared with semanage. That could change, based on the current 
> >> discussion of sharing records... but I wasn't sure if that's what you 
> >> intended.
> >>     
> >
> > hidden_def/hidden_proto isn't about hiding the symbol from users of the
> > shared library (that would be done by marking it "hidden", or in the
> > libsepol case, by omitting it from the map file).
> > hidden_def/hidden_proto creates an internal reference to the symbol for
> > use within the library so that intra-library use doesn't require a
> > relocation.
> >   
> You only need this for booleans?

No, I need it for all functions used within the library that are also
exported to users of the shared library.  The patch was just to get you
started.  Not a high priority, mind you, just something we want to do as
a cleanup.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
