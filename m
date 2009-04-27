Subject: Re: is it possible to use type_transition with every class?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <744BEBDD-41C4-4AAD-97C2-DEF07A6A49CA@gmail.com>
References: <744BEBDD-41C4-4AAD-97C2-DEF07A6A49CA@gmail.com>
Content-Type: text/plain
Date: Mon, 27 Apr 2009 08:34:12 -0400
Message-Id: <1240835652.18249.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-04-24 at 14:16 +0200, Sebastian Pfaff wrote:
> hello,
> 
> is it possible to use a type_transition with every (object) class, or  
> are there some limitations?
> 
> So far i only used domain and file transitions.

They are only used when there is both a subject and a related object
from which the new subject or object might inherit attributes.  At
present, only for processes (domains), files, and msgs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
