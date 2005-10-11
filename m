Subject: Re: [ SEMANAGE ] Replace semanage debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <434BC8F2.8040502@cornell.edu>
References: <434B62B8.4080309@cornell.edu>
	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
	 <434BC8F2.8040502@cornell.edu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 10:24:50 -0400
Message-Id: <1129040690.3308.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 10:15 -0400, Ivan Gyurdiev wrote:
> > OTOH, __func__ is not known to older versions of gcc, and we already
> > build with -D_GNU_SOURCE.  
> >   
> How much older? From the gcc webpage, I see it supported for 3.0+.
> IMHO we should compile against a standard, not against a compiler..

info gcc says:

`__FUNCTION__' is another name for `__func__'.  Older versions of GCC
recognize only this name.  However, it is not standardized.  For
maximum portability, we recommend you use `__func__', but provide a
fallback definition with the preprocessor:

     #if __STDC_VERSION__ < 199901L
     # if __GNUC__ >= 2
     #  define __func__ __FUNCTION__
     # else
     #  define __func__ "<unknown>"
     # endif
     #endif

In any event, we have been using gcc and glibc specific extensions in
our code for some time, and I don't expect that to change.

> By the way, does the printf family require such a memory allocation?

I don't believe so, at least not in the common case.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
