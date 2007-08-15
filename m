Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7FFTN2N017009
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 11:29:23 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7FFTM9K004875
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 15:29:22 GMT
Message-ID: <46C31BD0.5060200@tresys.com>
Date: Wed, 15 Aug 2007 11:29:20 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: tmiller@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [patch 0/4] libsemanage: genhomedircon replacement
References: <20070815204411.705994826@tresys.com> <1187190639.2674.51.camel@localhost.localdomain>
In-Reply-To: <1187190639.2674.51.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Wed, 2007-08-15 at 16:44 -0400, tmiller@tresys.com wrote:
>> This replaces genhomedircon with equivalent functionality in libsemanage. The
>> homedir_template is also no longer installed, this leaves some unused path
>> functions in libselinux but removing those would break the ABI.
>>
> 
> On a higher level, perhaps we should stop doing per-role home
> directory labeling at all and therefore remove genhomedircon entirely.
> I've been thinking about how to work this on a LDAP based network with
> remote home directories and I think the basic conclusion is that
> role-based labeling will simply not work (especially if we start
> assigning different primary roles to the same user on different systems
> with the same remote home directories).
> 
> I suggest that we rely on either DAC or separate namespaces to separate
> user access to home directories and have one set of types for all home
> directories. On systems where you really want SELinux to do the
> separation you can use user constraints (which could either acheive the
> current role-level separation or user-level separation based on how you
> map your SELinux users).
> 
> (BTW - most of the above was suggested to me by Dan and Steve in private
> concersations).
> 
> Thoughts?

Without genhomedircon how do you expect to be able to label home 
directories with the appropriate MLS levels for the LSPP version of RH?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
