Subject: Re: C++ reserved word 'class' used in selinux/avc.h with patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>,
        John Wiseman <john.wiseman@L-3Com.com>
In-Reply-To: <1158583382.8680.36.camel@twoface.columbia.tresys.com>
References: <67358AB2-DB43-4555-9E0A-77180679B0FC@nall.com>
	 <1158583382.8680.36.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 18 Sep 2006 12:40:24 -0400
Message-Id: <1158597624.18951.237.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-18 at 08:43 -0400, Joshua Brindle wrote:
> On Fri, 2006-09-15 at 18:08 -0500, Joe Nall wrote:
> > John Wiseman noticed that 'class', a reserved word in C++, is used  
> > in /usr/include/selinux/avc.h.
> > 
> > Save the following code as test.cc and compile
> > 
> > #include <selinux/avc.h>
> > 
> > int
> > main (int, char **)
> >      {
> >      }
> > 
> > results are
> > 
> > cc test.cc
> > /usr/include/selinux/avc.h:123: error: expected identifier before ‘,’  
> > token
> > /usr/include/selinux/avc.h:124: error: two or more data types in  
> > declaration of ‘parameter’
> > 
> > Fix:
> > 
> > --- avc.h.orig  2006-09-15 12:48:44.000000000 -0500
> > +++ avc.h       2006-09-15 12:49:02.000000000 -0500
> > @@ -120,7 +120,7 @@ extern "C" {
> >                  void (*func_log) (const char *fmt, ...);
> >                  /* store a string representation of auditdata  
> > (corresponding
> >                     to the given security class) into msgbuf. */
> > -               void (*func_audit) (void *auditdata, security_class_t  
> > class,
> > +               void (*func_audit) (void *auditdata, security_class_t  
> > cls,
> >                                      char *msgbuf, size_t msgbufsize);
> >          };
> > 
> > 
> 
> Acked-By: Joshua Brindle <jbrindle@tresys.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

P.S.  C++ considered harmful.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
