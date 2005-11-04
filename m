Message-ID: <36282A1733C57546BE392885C0618592D97717@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Jonathan Kim <jkim@TrustedCS.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov,
   Chad Hanson
	 <chanson@TrustedCS.com>
Subject: RE: [PATCH] libselinux
Date: Fri, 4 Nov 2005 12:32:02 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> Hmm...well, I did merge the patch, as we should do something other than
> just propagating an empty level string back to the caller, and then Ivan
> followed up with a patch that effectively reverts your change but allows
> the entire :level suffix to be omitted regardless of whether MLS is
> enabled or disabled.  So at this point, you can omit the :level suffix
> entirely from a given user entry (in which case it will propagate a NULL
> level and thus fall back to policy users default level), but a :<empty>
> sequence is still going to yield problems.  We should likely handle it
> as an error case immediately.
>

I agree the :<empty> should be handled as an error. Not having the MLS can
be useful, although not the most likely given the framework which will be
put in place, so Ivan's change to fall back if the MLS is not present sounds
good.

-Chad 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
