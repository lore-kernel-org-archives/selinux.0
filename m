Date: Sun, 16 Dec 2001 03:24:08 +0000
From: Dale Amon <amon@vnl.com>
To: SELinux@tycho.nsa.gov
Subject: No consistancy in Make variable names
Message-ID: <20011216032408.GA9250@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to modify the Makefile's for building
to a target build directory and/or an install time
selected destination, ie /usr vs /usr/local.

The biggest difficulty I'm having is a lack of
consistancy in labeling. DESTDIR means one thing
in one of the makefiles and something entirely
different in another.

It really would be a good idea to clean up this
nomenclature.

I was going to use DESTDIR for the target root
and BASEDIR for the location of selinux; I've just
run into other uses of DESTDIR that will force me
to start over with a less standard labelling.

util is the biggest hassle to modify needless to
say.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
