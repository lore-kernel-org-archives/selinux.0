Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k23DLf6G005386
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 08:21:41 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k23DLc4H027161
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 13:21:39 GMT
Subject: Re: FYI SELinux/AppArmor press
From: Erich Schubert <erich@debian.org>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <440799A1.2090401@tresys.com>
References: <43FF7418.90205@redhat.com>
	 <1141138934.29803.2.camel@wintermute.xmldesign.de>
	 <1141183226.8475.22.camel@localhost.localdomain>
	 <1141222338.2834.33.camel@wintermute.xmldesign.de>
	 <d82d6db50603011259s3fe0e80duca501a9c7925c661@mail.gmail.com>
	 <1141250441.2834.62.camel@wintermute.xmldesign.de>
	 <44065CB2.5080500@tresys.com>
	 <1141296207.17082.12.camel@wintermute.xmldesign.de>
	 <440799A1.2090401@tresys.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 14:21:40 +0100
Message-Id: <1141392100.18820.30.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Joshua, Chad, Hello SELinux list,

What I'd really appreciate would be a security modelling approach which
can be visualized like this:
http://www.mucl.de/~erich/selinux-oop-example.png
It's debatable whether you want e.g. any webserver to write any httpd
logfile.
But this is a true preference question - it's simpler if you have only
one domain for httpd logfiles (and that is fine as long as you have only
one web server running); you could also do a "generic httpd logfile"
which is writeable by all web servers and specialized "disjoint"
logfiles when needed. Or you can require httpd servers to define their
own domain and grant access rights only on that level (labeled "variant
2" in the diagram above).
A language can't solve this question, but it can make it easier to see.

> the reference policy is designed so that modules don't know about types 
> (or any symbol) from other modules. Instead the reference policy tries 
> to abstract them into actions relevant to that module such as 
> apache_read_log. The webalizer module knows it needs to read apache 
> logs, but doesn't need to know how that is implemented. This kind of 
> encapsulation is one of the best benefits of refpolicy IMHO.

I agree that this is a good approach. However, this can still be solved
by inheritance. For example, you could grant webalizer access to
apache_logfiles, which is actually an "abstract" type, realized by two
other types "apache_access_logs" and "apache_error_logs".

> putting labeling with the policy is bad for a few reasons. First the 
> file context files are suppose to be for system initialization only, 

They also are an important reference and documentation thing. In order
to understand policy, it's very useful to see which parts of the system
are supposed to be labeled this way.
On my systems, I basically want all files except (partially) /home
and /tmp
to be labele exactly as given by this "initial" labelling.
Right now, the separation achieved is pretty minimal (well, same file
name except for two letters) but it requires me to work with two files,
even when I'm actually working on one thing (e.g. the apache logfiles)

I definitely prefer having all apache logfile related stuff in one
place, instead of having all the apache domain stuff in apache.te and
apache.if and the files in apache.fc
And this was worse with the old policy, where they were even in separate
directories...

> though they aren't necessarily used that way. Further, different distros 
> (and even different OS's) are going to have different file paths which 
> would require that information to be encoded into the policy instead of 
> letting the enforcement policy be separate from labeling.

Right now I think we'll even have to patch the policy for specific
distros. Patching initial file labeling is not that much more work.
Especially "additional" labels - and that is a common case - can be
treated specially anyway. And we'll probably have some case construct in
there, too.
So from my "debian packaging" standpoint I don't see issues here.

> Not sure things like this fix anything. You would still have to know 
> about something called "amavis_logfile", how is that different from 
> looking at http://serefpolicy.sourceforge.net/api-docs/ and going to the 
> amavis module and seeing the available interfaces (or using SLIDE with 
> autocomplete)

I think the syntax is compacter, which is good. Less to read means
easier to write and to verify. And OOP is targeting this, too, by being
able to define rights on "higher" types and inheriting them here.

> inheritance is great while programming when you can apply repetitive 
> procedures to similar classes. Inheritance with security is not good, 
> however. In an ideal world children would be reducing policy, not 
> applying the same.

SELinux policy writing is _very_ repetitive. Which is bad.
Inheritance in security is good, because you can just write down the
_differences_ between two domains, and that makes them easier to check.
And if you want a complete description of what a domain can do, you can
still flatten them. All you need is a tool that "concatenates" the
access rights. They'll probably even remain nicely grouped "inherited
from class xyz: a,b,c"
so you'll even know where to fix it.

> We also had a couple papers in the symposium proceedings regarding 
> language abstractions and I think there are lots of good ideas being 
> bounced around and now we need to take those and figure out which ones 
> are truly helpful and implement them.

Thats something I don't like too much about the symposium - it looks
like a lot of stuff is/was basically "held back" to present it at the
symposium.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   It's not denial. I'm just selective about the reality I accept.   //\
    Die Freunde nennen sich aufrichtig. Die Feinde sind es: Daher    V_/_
      man ihren Tadel zur Selbsterkenntnis benutzen sollte, als
            eine bittere Arznei.  --- Arthur Schopenhauer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
