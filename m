Subject: Re: [PATCH] checkpolicy - nodecon ordering
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <36282A1733C57546BE392885C06185924D8EEF@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185924D8EEF@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1099332199.21386.160.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 13:03:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-29 at 10:07, Chad Hanson wrote:
> I have created a patch which orders nodecon rules from most specific to
> least specific.  We think this functionality can be useful for ease of
> administration and to protect against accidental misconfiguration.
> 
> I couldn't find any mention of this topic being brought up before, so I am
> interested in opinions on this subject.

Good idea, but I don't think that the patch is correct.  Should be
sorting based on the number of bits set in each mask, not their integer
value, as the simple value may not reflect the actual specificity.  Code
could also be simplified a bit, e.g. setting of newc->next doesn't need
to be conditional.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
