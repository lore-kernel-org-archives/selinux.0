Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA01261
	for <selinux@tycho.nsa.gov>; Thu, 18 Jul 2002 19:33:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA11539
	for <selinux@tycho.nsa.gov>; Thu, 18 Jul 2002 23:32:57 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id XAA11535
	for <selinux@tycho.nsa.gov>; Thu, 18 Jul 2002 23:32:56 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Shaun Savage'" <savages@pcez.com>,
        "'Ryan Bergauer'" <privateryan@mindspring.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: tripwire
Date: Thu, 18 Jul 2002 19:33:36 -0400
Message-ID: <004101c22eb3$89b37b60$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3D37341D.9030208@pcez.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Stupid question.  If it just needs permission to read files then why is
it running as root?

Ed

=> -----Original Message-----
=> From: owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov] On
=> Behalf Of Shaun Savage
=> Sent: Thursday, July 18, 2002 5:33 PM
=> To: Ryan Bergauer
=> Cc: selinux@tycho.nsa.gov
=> Subject: Re: tripwire
=> 
=> 
=> ***[07/18/2002 7:32:41 PM] PGP Signature Status: unknown
=> ***[07/18/2002 7:32:41 PM] Hash: SHA1
=> ***[07/18/2002 7:32:41 PM] Signer: Unknown
=> ***[07/18/2002 7:32:41 PM] Signer Key ID:0xEA73F975
=> ***[07/18/2002 7:32:41 PM] Signed: 07/18/2002 5:33:14 PM
=> ***[07/18/2002 7:32:41 PM] Verified: 07/18/2002 7:32:41 PM
=> ***[07/18/2002 7:32:41 PM] BEGIN PGP VERIFIED MESSAGE ***
=> 
=> When I created a Tripwire TE rules I had to match the tripwrire rules
=> with the SELinux rules.  I gave tripwire READ access to what is
needed.
=> ~  It is the run as root,  it does not need sysadm access becaues it
does
=> not change the policies, tripwire just reads directories and files
(data)
=> 
=> I reloaded my system and my archiver is down so I can't send you my
=> rules.
=> 
=> Shaun
=> 
=> 
=> 
=> Ryan Bergauer wrote:
=> 
=> | <!-- /* Style Definitions */ p.MsoNormal, li.MsoNormal,
div.MsoNormal
=> | {mso-style-parent:""; margin:0in; margin-bottom:.0001pt;
=> | mso-pagination:widow-orphan; font-size:12.0pt; font-family:"Times
New
=> | Roman"; mso-fareast-font-family:"Times New Roman";} a:link,
=> | span.MsoHyperlink {color:blue; text-decoration:underline;
=> | text-underline:single;} a:visited, span.MsoHyperlinkFollowed
=> | {color:purple; text-decoration:underline; text-underline:single;}
=> | span.EmailStyle17 {mso-style-type:personal-compose;
=> | mso-style-noshow:yes; mso-ansi-font-size:10.0pt;
=> | mso-bidi-font-size:10.0pt; font-family:Arial;
=> | mso-ascii-font-family:Arial; mso-hansi-font-family:Arial;
=> | mso-bidi-font-family:Arial; color:windowtext;} span.SpellE
=> | {mso-style-name:""; mso-spl-e:yes;} span.GramE {mso-style-name:"";
=> | mso-gram-e:yes;} @page Section1 {size:8.5in 11.0in; margin:1.0in
=> | 1.25in 1.0in 1.25in; mso-header-margin:.5in;
mso-footer-margin:.5in;
=> | mso-paper-source:0;} div.Section1 {page:Section1;} -->
=> |
=> | I just installed Tripwire on my SELinux play box. I have no problem
=> | doing an integrity check when Im logged in as root and newroled
into
=> | sysadm_r. However, the default system cron job for integrity
checking
=> | fails miserably because system_crond_t isnt granted the
permissions
=> | necessary to check and sign most files on my system (and with good
=> | reason.) My first thought was to create a domain just for Tripwire,
=> | but unfortunately, the fact that Tripwire needs access to just
about
=> | every file type on the disk results in a domain that not only would
=> | take quite some time to create, but would also require a fair
degree
=> | of maintenance. Creating a cron job run by a user also appears out
of
=> | the question, since my sysadm has no root access, and root runs
=> | user_crond_t cron jobs by default (which I feel would be wise to
keep
=> | that way.)
=> |
=> |
=> |
=> | Either Im overlooking something (very likely) or Im going to have
to
=> | suck it up and write that Tripwire domain. Any suggestions? If the
=> | Tripwire domain is the answer, are there any good ways to give it a
=> | large number of privileges very quickly?
=> |
=> |
=> |
=> | Thanks in advance  you guys are a huge help! I appreciate you
bearing
=> | with those of us still getting used to this&
=> |
=> | -Ryan
=> |
=> 
=> 
=> ***[07/18/2002 7:32:41 PM] END PGP VERIFIED MESSAGE ***
=> 
=> 
=> 
=> --
=> You have received this message because you are subscribed to the
selinux
=> list.
=> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
=> with
=> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
