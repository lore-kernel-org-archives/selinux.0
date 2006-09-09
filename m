Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k891GDtq007259
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 21:16:13 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k891FPJ8022267
	for <selinux@tycho.nsa.gov>; Sat, 9 Sep 2006 01:15:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: Supporting multiple python versions
Date: Sat, 9 Sep 2006 11:16:03 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <1157729493.31336.14.camel@wintermute.xmldesign.de>
In-Reply-To: <1157729493.31336.14.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200609091116.10256.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 09 September 2006 01:31, Erich Schubert <erich@debian.org> wrote:
> Most linux distributions try to precompile all .py files, to avoid .pyc
> files being created by random processes when ran by root (users won't
> have write permissions there).
> However, if you have two python versions, that still might happen.
>
> Debian therefore has moved the .pyc files to the /var/lib/python-support
> directories, and a helper application that will precompile them for all
> installed python versions (along with building an appropriate search
> path)
>
> However this means that many applications that so far only needed access
> to usr_t will now need (read) access to var_lib_python_t.

One option is to relabel /var/lib/python-support as usr_t.  It's a little 
ugly, but I think that naming types after directories was a mistake anyway 
and this is just the symptom.

Another option is to have a new type python_compiled_t that can be used for 
all distributions.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
