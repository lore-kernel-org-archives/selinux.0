From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Minor change to getsebool.
Date: Fri, 9 Mar 2007 18:42:34 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
References: <45F035D2.9030307@redhat.com> <1173370754.10467.86.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1173370754.10467.86.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200703091842.36887.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 09 March 2007 03:19, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > getsebool -a will only show booleans that domain can manipulate.
> > Currenly it will report the errrors that it can not read.  We can either
> > add a qualifier to silence these or a new option to get only the list of
> > the ones I can manipulate.
>
> Actually, I'd tend to think we could just silence them by default if
> errno is EACCES.

I think it's good for "getsebool -a" to silently ignore such things.  
But "getsebool foo" should display an error if it can't read foo.

> One other possible change to getsebool would be to make it fully
> equivalent to setsebool, i.e. add a -P option and have it query
> libsemanage to get persistent boolean settings in that case.

Makes sense.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
