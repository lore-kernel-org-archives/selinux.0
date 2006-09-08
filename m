Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88FVgr7022724
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 11:31:42 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88FUuA0028739
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 15:30:56 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id E9F38C4C090
	for <selinux@tycho.nsa.gov>; Fri,  8 Sep 2006 17:31:40 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 13934-01 for <selinux@tycho.nsa.gov>;
	Fri, 8 Sep 2006 17:31:39 +0200 (CEST)
Received: from wintermute.xmldesign.de (p549A4E46.dip.t-dialin.net [84.154.78.70])
	by legolas.drinsama.de (Postfix) with ESMTP id 6E7ADC4C08C
	for <selinux@tycho.nsa.gov>; Fri,  8 Sep 2006 17:31:38 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id 8ED24234057
	for <selinux@tycho.nsa.gov>; Fri,  8 Sep 2006 17:31:34 +0200 (CEST)
Subject: Supporting multiple python versions
From: Erich Schubert <erich@debian.org>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 08 Sep 2006 17:31:33 +0200
Message-Id: <1157729493.31336.14.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
Supporting multiple python versions is far from easy, as you might not
be aware of...

Python, when it encounters a .py file via "import", will try to compile
this file into a .pyc file residing in the same directory.
If it encounters an incompatible .pyc file, it will try to delete and
replace it. And of course different python versions may require
different .pyc files.

Most linux distributions try to precompile all .py files, to avoid .pyc
files being created by random processes when ran by root (users won't
have write permissions there).
However, if you have two python versions, that still might happen.

Debian therefore has moved the .pyc files to the /var/lib/python-support
directories, and a helper application that will precompile them for all
installed python versions (along with building an appropriate search
path)

However this means that many applications that so far only needed access
to usr_t will now need (read) access to var_lib_python_t.

Since these files are supposedly not secret, I'd be fine with allowing
any application access to them. They need a python interpreter running
to use them anyway, and python will want to read the .py file (which is
symlinked to the original one in /usr).

So what is the proper way of giving access to this type to "just about
every" domain? Or should we add an interface and try to find out which
domains need it?
I mean - bind doesn't need it. Samba shouldn't (except when someone
writes a password changing backend in python maybe). Apache probably
when mod_python is used...

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   It's not denial. I'm just selective about the reality I accept.   //\
      Mathematik ist die Kunst, verschiedene Dinge mit demselben     V_/_
                 Namen zu belegen. --- Henri Poincaré



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
