Subject: Re: Move python bindings into semanageswig_python.i
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43F1C84C.5030800@cornell.edu>
References: <43E26F62.7010400@cornell.edu> <43F1B827.401@cornell.edu>
	 <43F1C84C.5030800@cornell.edu>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 14:01:28 -0500
Message-Id: <1139943688.14253.281.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-14 at 07:08 -0500, Ivan Gyurdiev wrote:
> Ivan Gyurdiev wrote:
> > Attached is a resync of this patch against current genhomedircon.
> Now move python stuff into semanageswig_python.i. Trim #include list to 
> semanage/semanage.h, which is sufficient. Actually, I doubt that's 
> needed at all, since swig seems to prototype all wrapped functions itself.
> 
> I define "python stuff" as any typemaps, which are overriding the normal 
> SWIG-generated output with custom code - things that re-direct pointers 
> to output, as well as list-to-array conversions. There should be no need 
> to override swig in the language independent .i file. Also move the lone 
> char_by_idx function. Other by_idx functions should be kept out, because 
> they might not be needed in other languages. In fact, I should look at 
> char_by_idx too, it's probably not needed.
> 
> Patch requires resync-ed pylist patch above, as well as the small 
> free-leak patch I sent earlier.
> It doesn't attempt to make the Makefile language independent - it just 
> renames the current .i file being used (it's already hardcoded to use 
> -python anyways).

Merged as of libsemanage 1.5.24 as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
