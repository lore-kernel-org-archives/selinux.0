Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3RJkYRb000653
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 15:46:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3RJkRYW021357
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 19:46:27 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
        by jazzband.ncsc.mil  with ESMTP id i3RJkQBf021281 for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 19:46:26 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Russell Coker'" <russell@coker.com.au>
Cc: "'Selinux'" <selinux@tycho.nsa.gov>
Subject: RE: /etc/passwd labeling issues
Date: Tue, 27 Apr 2004 15:46:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <1083080493.24445.117.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <20040427194604.B6FFD3A405A@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I would recommend using the wrapper because it can be generic in case of
other issues like this, at least until the main problem is solved.

Ed

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil] 
Sent: Tuesday, April 27, 2004 11:42 AM
To: Russell Coker
Cc: Ed Street; Selinux
Subject: Re: /etc/passwd labeling issues

On Mon, 2004-04-26 at 23:25, Russell Coker wrote:
> On Tue, 27 Apr 2004 08:44, "Ed Street" <edstreet@street-tek.com> wrote:
> > So we have 2 choices for our debian users.  A) Change the password,
change
> 
> No, we have only one realistic choice.  To fix PAM and make it work
correctly 
> as it does in Fedora.

Or use the wrapper-based approach of the older SELinux, i.e. spasswd and
friends.

As I recall, Fedora includes more than just a modified pam for this
purpose; it also required modifications to libuser, shadow-utils, and
components of util-linux to preserve contexts on /etc/passwd and
/etc/shadow.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.667 / Virus Database: 429 - Release Date: 4/23/2004
 

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.670 / Virus Database: 432 - Release Date: 4/27/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
