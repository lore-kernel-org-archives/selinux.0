Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8BMl8a1001989
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 18:47:08 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8BMkfQP019836
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 22:46:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Supporting multiple python versions
Date: Tue, 12 Sep 2006 08:46:57 +1000
Cc: Erich Schubert <erich@debian.org>, SE Linux <selinux@tycho.nsa.gov>
References: <1157729493.31336.14.camel@wintermute.xmldesign.de> <200609091116.10256.russell@coker.com.au> <1157983761.26420.46.camel@sgc>
In-Reply-To: <1157983761.26420.46.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609120847.04256.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 12 September 2006 00:09, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> > One option is to relabel /var/lib/python-support as usr_t.  It's a little
> > ugly, but I think that naming types after directories was a mistake
> > anyway and this is just the symptom.
>
> I agree on types like python_var_lib_t, but not something like usr_t
> where the contents are so varied.

I think that Erich is on the right track here.  python_var_lib_t is not a good 
name as Fedora will use it for files under /usr.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
