Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k09MtPXf004748
	for <selinux@tycho.nsa.gov>; Mon, 9 Jan 2006 17:55:25 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k09MsIHd023192
	for <selinux@tycho.nsa.gov>; Mon, 9 Jan 2006 22:54:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: file contexts patch for performance
Date: Tue, 10 Jan 2006 09:55:00 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200601082141.14437.russell@coker.com.au> <43C2D2FF.8050104@redhat.com>
In-Reply-To: <43C2D2FF.8050104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601100955.16641.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 10 January 2006 08:17, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> > The attached patch applies against selinux-policy-targeted-2.1.7-3.  The
> > main part of the patch is to change "/foo(/.*)?/whatever" to
> > "/foo/(.*/)?whatever"
>
> "/foo(/.*)?/whatever" does not match  "/foo/(.*/)?
> Naimly /foo will not be labeled.

"/foo(/.*)?/whatever" is exactly equivalent to "/foo/(.*/)?whatever" and 
neither of them labels /foo!

I changed "/foo(/.*)?" to a pair of specifications "/foo -d" and "/foo/.*".  
This does not exactly match by regex terms but does give the same result 
based on our assumed knowledge of the SE Linux system (IE that the regex 
"/usr(/.*)?" is used to label a directory named "/usr" and all files and 
directories underneath it).  If someone's system had /usr being a sym-link to 
somewhere else then the result would be different, however a system with /usr 
being a sym-link of type usr_t would not work very well as many domains would 
be denied usr_t:lnk_file access and there's also the issue of correctly 
labelling the actual location of the files.

This problem of /usr being a symlink is why I advocate LVM for use on SE Linux 
systems.  When using LVM you tend to resize file systems rather than doing 
crazy things with sym-links when you run out of space.  Resized file systems 
work well with SE Linux while sym-linking trees of files around the place 
does not.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
