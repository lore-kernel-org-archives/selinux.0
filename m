Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6IF5Wia000799
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 11:05:32 -0400
Received: from web51501.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6IF5RuQ015583
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 15:05:27 GMT
Date: Wed, 18 Jul 2007 08:05:01 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [RFC]integrity: SELinux patch
To: James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        sgrubb@redhat.com
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov, zohar@us.ibm.com,
        safford@watson.ibm.com
In-Reply-To: <Line.LNX.4.64.0707171046060.5764@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <604663.1384.qm@web51501.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



>> No, it isn't being audited, but should be.  The question is what type of audit

>> message would be appropriate here.  It could be the normal denied/granted 
>> message, but that would be confusing as this isn't based on a permission or 
>> capability check, but an integrity error.  Any suggestions how to handle this 
>> here and in the other places? 

MRPP places some requirements on intergrity checking. Maybe it tells you more
information about what's required. More info:

http://www.niap-ccevs.org/cc-scheme/pp/pp.cfm?id=PP_OS_ML_MR2.0_V1.91

>If integrity is being enforced, then the final AVC denial should include 
>information that it was because of an integrity failure.

Might ought to be an integrity audit record type rather than avc. This way
aureport can separate it out for its summary report. In
/usr/include/linux/audit.h is this note:

 * 1800 - 1999 future kernel use (maybe integrity labels and related events)

So, we could assign the 1800 block to kernel integrity checking. I think we'd
need information access decision, creation, modification, and deletion of
integrity information/labels. We also probably need the ability to audit by
integrity, too. For a detailed audit discussion, I'd recommend linux-audit mail
list or at least cc'ing it

>I'm not sure that it's useful to have non-enforced integrity, aside from 
>debugging/development use.

Hard to say. You may want to upgrade a machine and not have anything fail due to
integrity checking. I could see it being useful in much the same way that
permissive is for selinux.

>For general use, it should either be enabled or disabled.

What about immutable, too? Changing between enabled/disabled is an auditable
event, too.

-Steve


 
____________________________________________________________________________________
We won't tell. Get more on shows you hate to love 
(and love to hate): Yahoo! TV's Guilty Pleasures list.
http://tv.yahoo.com/collections/265 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
