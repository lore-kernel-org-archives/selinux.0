Subject: Re: SELinux project
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: kamal <kamalnee@iitk.ac.in>
Cc: SELinux@tycho.nsa.gov, Trent Jaeger <jaegert@us.ibm.com>
In-Reply-To: <3F62E726.60700@iitk.ac.in>
References: <3F62E726.60700@iitk.ac.in>
Content-Type: text/plain
Message-Id: <1063629744.13311.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Sep 2003 08:42:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-09-13 at 05:45, kamal wrote:
> We are two final year under-graduate students in Computer Science. We 
> are doing our year long project in the field of Linux security. We have 
> studied SELinux and various access control models.  As a first step, we 
> are thinking of implementing Biba integrity model in SELinux, along the 
> lines of MLS implementation. Because we are new in the field, we want to 
> have your views on how useful it will be, and maybe some guidelines too.
> Thanks.

Since TE provides a more general integrity mechanism, I don't see it as
overly useful to implement a Biba integrity model for SELinux.  It is
likely more useful to work on policy analysis tools for the TE
configuration that can check it against specified higher level policy
constraints, including Biba-style constraints, and identify violations
of those constraints.  Trent Jaeger has done some work in this area, so
I've cc'd him.  See http://www.usenix.org/events/sec03/tech/jaeger.html
for a published paper on his work.

Rather than building a new tool from scratch, you might want to consider
building extensions to existing open source tools, such as the Tresys
tools, available from http://www.tresys.com/selinux.  I think that they
are working on improved information flow analysis capabilities, so that
would help in such work.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
