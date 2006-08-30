Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7UNIAXe009264
	for <selinux@tycho.nsa.gov>; Wed, 30 Aug 2006 19:18:10 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7UNHoDP014950
	for <selinux@tycho.nsa.gov>; Wed, 30 Aug 2006 23:17:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Klaus Weidner <klaus@atsec.com>
Subject: Re: type transitioning script race condition?
Date: Thu, 31 Aug 2006 09:18:00 +1000
Cc: selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
References: <20060830223937.GB12307@w-m-p.com>
In-Reply-To: <20060830223937.GB12307@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608310918.03263.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 31 August 2006 08:39, Klaus Weidner <klaus@atsec.com> wrote:
> This sounds as if it suffers from the well known race condition that
> makes setuid shell scripts a bad idea - is there any protection in place
> to prevent users from exploiting the race condition to run code of their
> own choice in the new domain?

Correct.  As long as the script is run in a domain that has less privileges 
than the calling code this isn't a problem.  If running a script causes a 
transition to a more privileged domain then that's a policy bug.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
