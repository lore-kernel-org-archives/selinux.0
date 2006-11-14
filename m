MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: I would like to propose that we add compression to handle	allpolicy files on disk.
Date: Tue, 14 Nov 2006 10:13:46 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C7836@exchange.columbia.tresys.com>
In-Reply-To: <4559D697.4080800@redhat.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
> 

> I am planning on compressing them, and changing the post 
> install to uncompress into a temp dir during install.  That 
> way it will at least be less of a problem.
> 
> That along with elimination of some of the stuff in modules 
> subdirs should save us a lot of space, until we get some 
> consensus on compression of the pp files.
> 

So you are going to compress them *until* we get a consensus on
compressing them? This seems like a bad idea if we are going to try to
have any kind of consistency between selinux distributions (or even
between RH and upstream..)

I think having libsemanage compress files in the store is fine, as
that's a private resource of libsemanage users but having files on the
filesystem that are compressed but has nothing that can read them in the
format they are in on disk is not ideal I don't think..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
