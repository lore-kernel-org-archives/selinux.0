Message-ID: <41F6D30D.9070904@trustedcs.com>
Date: Tue, 25 Jan 2005 17:15:25 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [patch] enhanced MLS support
References: <41EC4682.8050807@trustedcs.com>
In-Reply-To: <41EC4682.8050807@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have new patches that incorporates feedback that I have received (and some 
things that I noticed).  There is some code cleanup, and some bugfixes that 
never made their way into the the MLS code before.  The most noticeable change 
is the addition of the "-l" option to newrole to allow changing of levels. These 
are also against the latest CVS tree form SourceForge.

The new patches (and a diff between the original and latest) are here:

http://dgoeddel.home.insightbb.com/kern-0125.patch
http://dgoeddel.home.insightbb.com/usr-0125.patch
http://dgoeddel.home.insightbb.com/0117to0125.patch

Note that the mounting issue pointed out by Stephen is not addressed by this 
patch.  I figured that would best be addressed separately because it is not 
specific to these changes.

Thanks.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
