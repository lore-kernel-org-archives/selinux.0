Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9T4Urk0025421
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 00:30:53 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9T4U6F5023819
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 04:30:07 GMT
Received: by wx-out-0506.google.com with SMTP id i26so1193406wxd
        for <selinux@tycho.nsa.gov>; Sat, 28 Oct 2006 21:30:54 -0700 (PDT)
Subject: Re: New to SELinux -- any suggestions?
From: Michael Graffam <michael.graffam@gmail.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610291432.01272.russell@coker.com.au>
References: <1162086080.2566.16.camel@endless>
	 <200610291432.01272.russell@coker.com.au>
Content-Type: text/plain
Date: Sun, 29 Oct 2006 00:30:12 -0400
Message-Id: <1162096212.15530.22.camel@endless>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-10-29 at 13:31 +1000, Russell Coker wrote:
> On Sunday 29 October 2006 12:41, Michael Graffam <michael.graffam@gmail.com> 
> wrote:
> > chcon -t uncontained_execmem_exec_t /usr/bin/sbcl
> > (and /usr/local/bin/lisp)
> 
> Incidentally why are you running it from /usr/local/bin?  Why don't you use an 
> RPM package of it?  If there is no RPM available have you considered building 
> your own and submitting it to Extras?

As I suspected, a quick Google of 'fedora cmucl' indicates that there
is, indeed, an RPM of CMUCL. I myself run it from /usr/local/bin because
I built it from source, along with some modifications for my particular
application. I've carried this tree along with me for some time, and I'm
kind of sentimental about it now :)

> The problem here is your idea of "removing the permission".  Chcon does not 
> add or remove permissions, it merely changes the labels of files.  What the 
> label means is determined by the policy.
> 
> So if you want to change a file back to it's default context you can 
> use "restorecon", in this case "restorecon -F -R -v /usr/local /usr/bin" 
> should do what you want.

Thank you for the help. Can one AND/OR the contexts? Based on the above,
it would seem to me that if an executable violated two points of policy
it wouldn't be possible to 'bless' it -- since I'm sure this isn't the
case, I'm wondering how I might apply multiple contexts. Or am I still
out in left field here?

> Another option is to know what the original context was (maybe by examining 
> the file with "ls -Z" before changing it in the first place).  In this case I 
> know that the bin directories have type bin_t, so the following would work:
> chcon -t bin_t /usr/bin/sbcl /usr/local/bin/lisp

Whooo.. new ls fields too! Man, I feel like a kid again! This is
great! :) Having been using GNU/Linux for so long, I almost forgot how
fun it is to learn new stuff about it!

-M


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
