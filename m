Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA05497
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 04:15:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA00245
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 09:13:15 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id JAA00241
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 09:13:14 GMT
Date: Fri, 20 Dec 2002 10:15:39 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: [ISN] Music file flaws could threaten traders
Message-ID: <20021220101539.G26689@lemuria.org>
References: <Pine.LNX.4.44.0212190257480.19905-100000@idle.curiosity.org> <200212192307.20386.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212192307.20386.russell@coker.com.au>; from russell@coker.com.au on Thu, Dec 19, 2002 at 11:07:20PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Dec 19, 2002 at 11:07:20PM +0100, Russell Coker wrote:
> The problem about doing the same for audio/video programs such as players for 
> avi, mp3, and vob files is that their typical use involves downloading files 
> from the net to play immediately so that denying them read access to 
> user_home_t files will give a large decrease in functionality.  I believe 
> that there are two major categories of SE Linux users, those who will never 
> run such A/V programs on Linux, and those who won't use any security software 
> that gets in the way of their entertainment.

My preferred solution would be to handle this much like in old BBS
days. Any file downloaded from the net, no matter how, should be
labeled with a special "untrusted download" type first. It could then
either be relabeled after checking (for virii, content correctness or
whatever) or the player could be run in a domain that allows absolute
minimum access only.

This can be implemented in one of two ways:

a) by modifying any programs downloading files
b) by making downloads only  to a special download directory
   and using file_auto_trans there.
   

The better/easier b) requires a little discipline from the user since
netscape et al will need write access to other directories (e.g. /tmp)
so he _could_ in theory save his stuff there.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
