Subject: Re: SELinux userpace compile errors
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <1239132391.29028.35.camel@localhost.localdomain>
References: <dd18b0c30904071217x740a809fve1ad3f9fbba140e5@mail.gmail.com>
	 <1239132391.29028.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 07 Apr 2009 15:40:57 -0400
Message-Id: <1239133257.29028.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-07 at 15:26 -0400, Stephen Smalley wrote:
> On Tue, 2009-04-07 at 12:17 -0700, Justin Mattock wrote:
> > compiling the userspace tools
> > I'm receiving some errors:
> > (the first is just a simple "make" instead of "sudo make")
> 
> The default top-level target is 'install'.  So you either need to do it
> as root or specify DESTDIR=/path/to/root for a writable tree.
> 
> > the second seems to maybe be with the gcc
> > (which is 4.5.0)
> > 
> > 
> > 
> > policy_define.c: In function 'set_types':
> > policy_define.c:1304: error: offset '3' outside bounds of constant string
> > policy_define.c:1316: error: offset '3' outside bounds of constant string
> > policy_define.c:1328: error: offset '3' outside bounds of constant string
> 
> Bug in gcc, already known to gcc folks.

Reference:
http://gcc.gnu.org/ml/gcc-patches/2009-03/msg01645.html

Who knew that strcmp() was so complex?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
