Date: Mon, 17 Dec 2001 03:15:31 +0000
From: Dale Amon <amon@vnl.com>
To: SELinux@tycho.nsa.gov
Subject: Re: No consistancy in Make variable names
Message-ID: <20011217031531.GA24643@vnl.com>
References: <20011216032408.GA9250@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011216032408.GA9250@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Dec 16, 2001 at 03:24:08AM +0000, Dale Amon wrote:
> I was going to use DESTDIR for the target root
> and BASEDIR for the location of selinux; I've just
> run into other uses of DESTDIR that will force me
> to start over with a less standard labelling.
> 
> util is the biggest hassle to modify needless to
> say.

I might add that I'm getting close. I've a patch 
that sets all of the makefiles to allow use of
	BUILDDIR
and/or
	SBASEDIR
which default to
	BUILDDIR=
	SBASEDIR=$(BUILDDIR)/usr/local 

I'll have to run down loads of probs yet I'm sure, but
I'm close to getting everything installed relative to
a buildroot rather than /.

I just know there will be a few compiled in paths to
sort out and I'm already suspicious of the USRSBINDIR
setting in MCONFIG but haven't checked what it is doing
yet.

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
