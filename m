Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4HM5ERb027517
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 18:05:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4HM2oB2007123
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 22:02:50 GMT
Received: from hafnium.btinternet.com (hafnium.btinternet.com [194.73.73.121])
	by jazzswing.ncsc.mil  with ESMTP id i4HM2nwi007117
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 22:02:49 GMT
Date: Mon, 17 May 2004 22:02:32 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux
Message-ID: <20040517220232.GX9378@lkcl.net>
References: <20040515232606.GA9378@lkcl.net> <200405180510.40047.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405180510.40047.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 05:10:40AM +1000, Russell Coker wrote:

> Of course we can do this on a per-application basis.  If there is some 
> application for which we can't get the current patches included but for which 
> changes such as you suggest would be accepted then we should definitely do it 
> for that app.
 

> Of course that doesn't require changing libselinux, we could just call dlsym() 
> for every function we want to use.  

ah, you then need to check every pointer to every function
for not being NULL.

it'd be aesthetically better to cut/paste sel-> in front of every
function used rather than have if (fn != NULL) ...

plus you have to check for the success of each dlsym() rather
than just the one.

you can just search for calls to is_selinux_enabled()  and
add the code to do one dlsym() at that point, in fact you
could probably get away with adding a small macro into
libselinux.h that'd do the hard work.


> > p.s. please ask me for clarifications if needed or even for
> > patches rather than go "uhn?  weirdo, weird language, can't
> > even touch a shift key, don't talk to him".  i _want_ selinux
> > to be adapted mainstream by debian, quickly, so talk to me.
> 
> The main thing that is needed for better SE Linux support in Debian is to have 
> more people working on it.  Doing this sort of thing properly requires that 
> most than one person work on it.
 
 count me as a wobbly "in" :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
