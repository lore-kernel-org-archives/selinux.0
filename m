Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3QMjMRb024670
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2004 18:45:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3QMhBW3011185
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2004 22:43:11 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
	by jazzswing.ncsc.mil  with ESMTP id i3QMh7Ix011168
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2004 22:43:11 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: <russell@coker.com.au>
Cc: "Selinux" <selinux@tycho.nsa.gov>
Subject: RE: /etc/passwd labeling issues
Date: Mon, 26 Apr 2004 18:44:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <200404261303.34755.russell@coker.com.au>
Message-Id: <20040426224500.7F3B83A4053@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

So we have 2 choices for our debian users.  A) Change the password, change
to permissive mode, relabel /etc/passwd and switch back to enforcement mode.
B) disallow all system users from changing passwords, adding users or
modifying existing users Or C) the policy change that I pasted and run the
risk of /etc/shadow being read by almost every domain.  In either case a
rogue daemon may compromise the system.  Ideally the bug needs to be fixed
but for the time being it's the less of the 3 evils.  

Perhaps there's a line we could add to stop the /etc/shadow issue and not
use the file_type_auto_trans macro.

Ed

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Sunday, April 25, 2004 11:04 PM
To: Ed Street
Cc: selinux@tycho.nsa.gov
Subject: Re: /etc/passwd labeling issues

On Mon, 26 Apr 2004 02:39, "Ed Street" <edstreet@street-tek.com> wrote:
> As for the labeling issue for /etc/passwd I noticed in passwd.te this line
>
>
>
> file_type_auto_trans($1_t, etc_t, shadow_t, file)

If you don't have that then the new /etc/shadow file (with a complete copy
of 
all /etc/shadow data) will briefly have the type etc_t and be readable by 
almost every domain.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.667 / Virus Database: 429 - Release Date: 4/23/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
