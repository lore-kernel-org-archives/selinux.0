Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02145
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 17:25:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0LMPaI08146
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 22:25:36 GMT
Received: from unicorn.lemuria.org (b069097.adsl.hansenet.de [62.109.69.97])
        by jazzband.ncsc.mil  with ESMTP id h0LMPZf08140 for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 22:25:35 GMT
Date: Tue, 21 Jan 2003 23:20:23 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: Apache/mysql policy status ?
Message-ID: <20030121232022.D24908@lemuria.org>
References: <200301211848.NAA02352@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301211848.NAA02352@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Jan 21, 2003 at 01:48:43PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jan 21, 2003 at 01:48:43PM -0500, Stephen D. Smalley wrote:
> As I recall, we were still waiting final forms of patches for merging
> from you.  Your last message about the mysql policy appears to have
> been http://marc.theaimsgroup.com/?l=selinux&m=103598879429279&w=2,
> where you posted full files for comments and said that you would
> followup with a patch after further testing.  

Hm, it may have been lost in general chaos (my company is restructuring
itself. I still hope they come to the "structure" part soon).


> I don't recall seeing
> any comments or a followup patch.  Since it was a major rewrite of
> Russell's original domain, I was also looking for an ACK from him.

After Russells comment - I will post my last state here and we can
discuss the differences between the two policies.


> With regard to the Apache policy diff, I think it might have been
> dropped accidentally.  Sorry.  Was the final form of that patch
> contained in http://marc.theaimsgroup.com/?l=selinux&m=103555821217807&w=2?
> Note to Wayne:  Please make sure that the apache diff (but not the
> SubVersion diff) is in the queue of policy patches for review. 

Then again, I was just starting on a total rewrite anyway. I have some
interesting things that I've done for virtual hosting right now, and
I've always wanted to seperate stuff further (e.g. the CGI and suexec
rules).


What was it with the subversion policy? I tried getting some comments
from the subversion dev team, but they never replied to my message.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
