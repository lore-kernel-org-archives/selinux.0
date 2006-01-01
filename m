Subject: Documentation, anyone?
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 01 Jan 2006 17:37:16 +0100
Message-Id: <1136133436.27906.56.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
Recent changes broke lots of stuff on my system.
For example, genhomedircon no longer reads my local.users file...
It seems that this is somehow related to semanage changes...
Which doesn't work for me, and I can't find *any* documentation on it.
So the current SELinux shape is IMHO really bad... no current
documentation, and even those who have working installations (like me)
have no idea how to get the latest stuff working... :-(

I have a user role "netuser" who is allowed to use the network to a
larger extend (e.g. bind to port_t). I'd like to make that the default
role for certain unix accounts...

$ semanage user --add -s netuser_u -R netuser_r erich
['netuser_r']
libsemanage.assert_init: A direct or server connection is needed to use
this function - please call the corresponding connect() method
libsemanage.enter_ro: could not enter read-only section
/usr/sbin/semanage: Seuser lerich already defined

I couldn't find an example for /etc/selinux/seusers, I guessed it looks
like
"lerich:netuser_u" but that didn't work either...

I've also investigated "genhomedircon", and what strikes me as really
bad code is that it keeps on calling an external "grep" on just about
everything.
Loading a file and applying a regexp is really easy in Python, you
know...

To all users of my Debian repository or Debian unstable:
Avoid upgrading for now if you are using extra user roles...

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     We can debug relationships, but it's always good policy to     //\
     consider the people themselves to be features. People get      V_/_
         annoyed when you try to debug them. -- Larry Wall
      Alles verändert sich, sobald man sich selber verändert.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
