Message-Id: <200509211748.j8LHmnYs012526@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
   <jbrindle@tresys.com>
Subject: RE: [ SEPOL/SEMANAGE ] Boolean record
Date: Wed, 21 Sep 2005 13:48:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <43308255.6080007@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Tuesday, September 20, 2005 5:43 PM
> To: Karl MacMillan
> Cc: 'Stephen Smalley'; selinux@tycho.nsa.gov; jbrindle@tresys.com
> Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
> 
> 
> >2) The ability to move between straight modules and the policy server.
> >
> >The inlined functions don't meet this goal and moving things to libsepol
> >will make 2 impossible.
> >
> >
> I don't understand what's preventing you from reimplementing those
> functions at any point in time, as long as the data structures are
> opaque (which they are). Yes, the functions are inlined, and the callers
> may decide that they'll always be equivalent to the sepol ones, but I
> think at that point the caller is not using the interface properly, and
> we shouldn't care.
> 
> Since there is no policy server right now, and there is a policydb,
> where the same data structures are already implemented, serving pretty
> much the same purpose (encapsulation), it seems easy to just make use of
> those functions. It also seems like you'll need to link to libsepol for
> a long time, to handle the policydb case even after the policy server is
> created.
> 

Just a note - there is a working policy server right now
(sepolicy-server.sf.net has the latest release). That is why these
functions, at the very least, need to be indirected through the
semanage_handle_t function pointers so different versions can be plugged in
for the remote implementation.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> Regardless, I don't care anymore - if you guys want to duplicate all the
> records into semanage, then that's fine with me - I can write a patch
> for it, if that is your decision. I think Steven's arguing for the exact
> opposite of that (unless I misunderstood) - use of sepol records
> directly. I just want some data structure that I can use in my record
> engine, regardless of where it came from - all I need for it is to fill
> out the record_table found in record_file.h.
> 
> Other issues: will you be merging the handle stuff soon? I need the
> handle to implement any kind of error reporting in my code (because
> otherwise I'd just be changing interfaces later). I think I'll likely
> submit a patch with the record engine stuff, and comment out all the
> DEBUG calls to be fixed later.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
