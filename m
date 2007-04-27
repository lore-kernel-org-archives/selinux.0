Message-ID: <46321FB5.3010301@tycho.nsa.gov>
Date: Fri, 27 Apr 2007 12:07:17 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Dax Kelson <dax@gurulabs.com>, selinux@tycho.nsa.gov,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [PATCH 1/1] libselinux: helpful message when /selinux won't	mount
References: <1177618067.26931.13.camel@mentorng.gurulabs.com> <1177688730.3357.41.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1177688730.3357.41.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> I'm fine with merging this for now, but I think we also likely want to
> introduce a similar error reporting facility into libselinux to match
> what we have in libsemanage and libsepol (e.g. see
> libsepol/include/sepol/debug.h and libsepol/src/debug.[hc]) to allow
> such messages to be handled in various ways by the caller.  What do
> others think?  One difference is that libselinux presently has no notion
> of handles.
> 

libselinux does have the AVC logging callback.

It would be nice if these interfaces were consistent or even shared 
across all three libraries.  The AVC logging callback needs to be 
changed anyway since it doesn't take a type code for passing to the 
audit framework.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
