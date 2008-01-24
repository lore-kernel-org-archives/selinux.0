Subject: Re: audit2allow patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1201200983.21288.95.camel@moss-spartans.epoch.ncsc.mil>
References: <4797BE33.1070504@redhat.com>
	 <1201199853.21288.78.camel@moss-spartans.epoch.ncsc.mil>
	 <1201200983.21288.95.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 14:30:31 -0500
Message-Id: <1201203031.21288.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-24 at 13:56 -0500, Stephen Smalley wrote:
> On Thu, 2008-01-24 at 13:37 -0500, Stephen Smalley wrote:
> > On Wed, 2008-01-23 at 17:22 -0500, Daniel J Walsh wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > Fan through pychecker and cleaned up some bugs.
> > > 
> > > Also added booleans description from policy.xml file
> > > 
> > > -----BEGIN PGP SIGNATURE-----
> > > Version: GnuPG v1.4.8 (GNU/Linux)
> > > Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> > > 
> > > iEYEARECAAYFAkeXvjMACgkQrlYvE4MpobOsgwCfbTTJxThRmfUw5LHQGhsG99vj
> > > rtwAoMTo1ms2h6dOQXmrtLpHrwB1Ec5Z
> > > =mNcO
> > > -----END PGP SIGNATURE-----
> > > plain text document attachment (audit2allow.patch)
> > > --- nsapolicycoreutils/audit2allow/audit2allow	2008-01-23 16:47:07.000000000 -0500
> > > +++ policycoreutils-2.0.37/audit2allow/audit2allow	2008-01-23 17:15:21.000000000 -0500
> > > @@ -19,7 +19,6 @@
> > >  #
> > >  
> > >  import sys
> > > -import tempfile
> > >  
> > >  import sepolgen.audit as audit
> > >  import sepolgen.policygen as policygen
> > > @@ -153,9 +152,9 @@
> > >  
> > >      def __process_input(self):
> > >          if self.__options.type:
> > > -            filter = audit.TypeFilter(self.__options.type)
> > > -            self.__avs = self.__parser.to_access(filter)
> > > -            self.__selinux_errs = self.__parser.to_role(filter)
> > > +            avcfilter = audit.TypeFilter(self.__options.type)
> > > +            self.__avs = self.__parser.to_access(avcfilter)
> > > +            self.__selinux_errs = self.__parser.to_role(avcfilter)
> > >          else:
> > >              self.__avs = self.__parser.to_access()
> > >              self.__selinux_errs = self.__parser.to_role()
> > > @@ -221,13 +220,14 @@
> > >      def __output_audit2why(self):
> > >              import selinux
> > >              import selinux.audit2why as audit2why
> > > +            import seobject
> > >              audit2why.init("%s.%s" % (selinux.selinux_binary_policy_path(), selinux.security_policyvers()))
> > >              for i in self.__parser.avc_msgs:
> > >                  rc, bools = audit2why.analyze(i.scontext.to_string(), i.tcontext.to_string(), i.tclass, i.accesses)
> > >                  if rc >= 0:
> > >                      print "%s\n\tWas caused by:" % i.message
> > >                  if rc == audit2why.NOPOLICY:
> > > -                    raise "Must call policy_init first"
> > > +                    raise RuntimeError("Must call policy_init first")
> > >                  if rc == audit2why.BADTCON:
> > >                      print "Invalid Target Context %s\n" % i.tcontext
> > >                      continue
> > > @@ -241,7 +241,7 @@
> > >                      print "Invalid permission %s\n" % i.accesses
> > >                      continue
> > >                  if rc == audit2why. BADCOMPUTE:
> > > -                    raise "Error during access vector computation"
> > > +                    raise RuntimeError("Error during access vector computation")
> > >                  if rc == audit2why.ALLOW:
> > >                      print "\t\tUnknown - would be allowed by active policy\n",
> > >                      print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
> > > @@ -251,12 +251,14 @@
> > >                      if len(bools) > 1:
> > >                          print "\tOne of the following booleans was set incorrectly."
> > >                          for b in bools:
> > > -                            print "\n\tBoolean %s is %d. Allow access by executing:" % (b[0], not b[1])
> > > -                            print "\t# setsebool -P %s %d"  % (b[0], b[1])
> > > +                            print "\n\tBoolean %s is %d." % (b[0], not b[1])
> > 
> > Here is you have "not b[1]".
> > 
> > > +                            print "\tDescription:\n\t%s\n"  % seobject.boolean_desc(b[0])
> > > +                            print "\tAllow access by executing:\n\t# setsebool -P %s %d"  % (b[0], b[1])
> > >                      else:
> > > -                        print "\tThe boolean %s was set incorrectly.  Allow access by executing:" % bools[0][0]
> > > -                        print "\t# setsebool -P %s %d\n"  % (bools[0][0], bools[0][1])
> > > -
> > > +                        print "\tThe boolean %s set incorrectly. " % (bools[0][0])
> > > +                        print "\n\tBoolean %s is %d." % (bools[0][0], bools[0][1])
> > 
> > Here you have "bools[0][1]".
> > 
> > Should that be negated too (looks like it - I get the wrong output in
> > running it on sample avc messages)?  But what's the point of even doing
> > that if we are just displaying the negation of what we are going to tell
> > them to pass to setsebool, and since we've already told them it is
> > wrong?
> 
> I'm just going to drop the "Boolean is ..." lines out altogether, since
> the rest of the message tells them it is incorrect, what it means and
> what command to execute.

Merged with that change and slight rewording of the messages for the
other audit2why cases, hopefully to be clearer.  We still need to do
more work to make the other audit2why cases useful to end users, e.g.
audit2why needs to figure out precisely what type attribute would have
helped with a given policy constraint failure (and ideally audit2allow
could then generate the typeattribute rule or look for a matching
interface), and we ought to be able to generate role allow rules easily
enough.

> > 
> > > +                        print "\tDescription:\n\t%s\n"  % seobject.boolean_desc(bools[0][0])
> > > +                        print "\tAllow access by executing:\n\t# setsebool -P %s %d"  % (bools[0][0], bools[0][1])
> > >                      continue
> > >  
> > >                  if rc == audit2why.TERULE:
> > > --- nsapolicycoreutils/semanage/seobject.py	2007-12-10 21:42:27.000000000 -0500
> > > +++ policycoreutils-2.0.37/semanage/seobject.py	2008-01-23 17:13:45.000000000 -0500
> > > @@ -117,6 +117,12 @@
> > >         #print _("Failed to translate booleans.\n%s") % e
> > >         pass
> > >  
> > > +def boolean_desc(boolean):
> > > +       if boolean in booleans_dict:
> > > +              return _(booleans_dict[boolean][2])
> > > +       else:
> > > +              return boolean
> > > +
> > >  def validate_level(raw):
> > >  	sensitivity = "s[0-9]*"
> > >  	category = "c[0-9]*"
> > > @@ -1456,10 +1462,7 @@
> > >  		return ddict
> > >  			
> > >          def get_desc(self, boolean):
> > > -               if boolean in booleans_dict:
> > > -                      return _(booleans_dict[boolean][2])
> > > -               else:
> > > -                      return boolean
> > > +               return boolean_desc(boolean)
> > >  
> > >          def get_category(self, boolean):
> > >                 if boolean in booleans_dict:
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
