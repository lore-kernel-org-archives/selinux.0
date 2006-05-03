Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k43L1Pg6008009
	for <selinux@tycho.nsa.gov>; Wed, 3 May 2006 17:01:25 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k43L1Htb003060
	for <selinux@tycho.nsa.gov>; Wed, 3 May 2006 21:01:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@namei.org>
Subject: Re: Making MCS mandatory
Date: Thu, 4 May 2006 07:01:12 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
References: <200605032230.30757.russell@coker.com.au> <Pine.LNX.4.64.0605030928460.16976@d.namei>
In-Reply-To: <Pine.LNX.4.64.0605030928460.16976@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605040701.17509.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 03 May 2006 23:29, James Morris <jmorris@namei.org> wrote:
> On Wed, 3 May 2006, Russell Coker wrote:
> > I have implemented a change to the MCS policy to make it mandatory.  So
> > far in my own tests it does what it is supposed to do.  I would like to
> > get some feedback from people on this list before putting it in to
> > rawhide, it's the most significant change to MCS since it's inception...
>
> It seems ok, but I don't understand the requirements for the change.

Firstly having all processes run with a low level of s0 such that all files 
are created with no categories by default is not adequate, particularly with 
no MCS controls on directories.  I believe that using other low level values 
is necessary for correct MCS functionality.

Once we accept the need for a low level for serious use (which will mean less 
than 10% of users at a rough guess) it logically follows that it is desirable 
to have the low level not be lowered arbitrarily.

Dan has just suggested an issue with this change, it requires changes to home 
directory labeling to give the home directory the correct low level, 
otherwise the user won't be able to write to their .bashrc etc.  Incidentally 
this is also a MLS issue which demonstrates a benefit for MMCS in terms of 
MLS development.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
