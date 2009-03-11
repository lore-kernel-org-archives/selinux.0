Subject: Re: Help with python seobject.loginRecords
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <49B823CD.3090409@redhat.com>
References: <1BF3FC9F-9D76-4CF5-B67E-DFE8216038FA@nall.com>
	 <49B8126B.9060501@redhat.com>
	 <F1007BB4-8898-4A05-B09A-4FB1EF8519A2@nall.com>
	 <49B823CD.3090409@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 17:00:17 -0400
Message-Id: <1236805217.14649.89.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-03-11 at 16:49 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Joe Nall wrote:
> > 
> > On Mar 11, 2009, at 2:35 PM, Daniel J Walsh wrote:
> > 
> >> On 03/11/2009 12:15 PM, Joe Nall wrote:
> >>> I need to add login mappings in python firstboot modules during system
> >>> configuration. In my first module a simple:
> >>>
> >>> seobject.loginRecords().add(username, "siterep_u",
> >>> "SystemLow-SystemHigh")
> >>>
> >>> works. In subsequent modules, I get an exception:
> >>>
> >>> libsemanage.enter_rw: this operation requires a transaction
> >>> libsemanage.enter_rw: could not enter read-write section
> >>> Traceback (most recent call last):
> >>> File "./t", line 6, in <module>
> >>> seobject.loginRecords().add("test3", "sysadm_u", "SystemLow-SystemHigh")
> >>> File "/usr/lib64/python2.5/site-packages/seobject.py", line 442, in add
> >>> raise error
> >>> ValueError: Could not add login mapping for test3
> >>>
> >>> What is the right way to do this?
> >>>
> >>> joe
> >>>
> >>>
> >>> -- 
> >>> This message was distributed to subscribers of the selinux mailing list.
> >>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> >>> with
> >>> the words "unsubscribe selinux" without quotes as the message.
> >> Probably an MLS issue.  firtstboot is running in a context that is not
> >> allowed to lock/manage selinux.
> > 
> > I'm installing in permissive and switching to enforcing after firstboot.
> > You are correct that firstboot_t doesn't have the policy for all the
> > stuff I'm trying to do yet.
> > 
> >> You probably should exec semanage rather then calling seobject so you
> >> could do a transition and not have to give a huge app like first boot
> >> the ability to manage security policy.
> > 
> > That is what is installing right now. I would still like an
> > explanation/code snippet of correct usage for future use
> > 
> > joe
> > 
> > 
> This works on F10 Targeted policy
> 
> # python -c "import seobject; seobject.loginRecords().add("pwalsh",
> "staff_u", "s0")
> # python -c 'import seobject; seobject.loginRecords().delete("pwalsh")'
> 
> Could it be a translation problem?

Try running multiple calls within the same python interpreter.
I think seobject.py isn't using libsemanage correctly.  For example, in
add(), you do:
                       self.begin()
                        self.__add(name, sename, serange)
                        self.commit()
but begin() only ever invokes semanage_begin_transaction() the very
first time:
       def begin(self):
               if self.transaction:
                      return
               rc = semanage_begin_transaction(self.sh)

So after the first commit(), you'll start failing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
