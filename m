Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8OIYusJ019602
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 14:34:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8OIU2G6003867
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 18:34:55 GMT
Date: Wed, 24 Sep 2003 16:17:31 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Some minor thoughts on syntax/semantics
Message-ID: <20030924151731.GL21997@vnl.com>
References: <20030923150926.GG21997@vnl.com> <200309242334.55203.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309242334.55203.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 24, 2003 at 11:34:55PM +1000, Russell Coker wrote:
> The current syntax seems intuitive enough to me.  I learnt how to write SE 
> policy by reading the existing policy and playing with it and it never seemed 
> difficult.

The reason I brought it up was that Steve's paper states things
in English exactly the way I did, which means you have to reverse
the second two elements in your mind when reading the descriptions.

I can't say that I really see anything about the language that is
object oriented per-se, it looks like a very simple declarative
configuration language to me. C++ it ain't. (thank god) :-)

Just some thoughts after coming back to it after over a year
and a half...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
