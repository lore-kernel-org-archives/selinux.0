Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7OEv3Ob007361
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 10:57:03 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7OEkJDj023648
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 14:46:41 GMT
Message-ID: <430C88C5.5050306@trustedcs.com>
Date: Wed, 24 Aug 2005 09:48:37 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com>	 <1124807226.7874.52.camel@moss-spartans.epoch.ncsc.mil>	 <430B3A7B.6020208@redhat.com> <1124809493.7874.75.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124809493.7874.75.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2005-08-23 at 11:02 -0400, Daniel J Walsh wrote:
>>>Do we truly need to allow whitespace in the (translated) MLS field?
>>>That change to context_new originated in the TCS patch, but I'd prefer
>>>to avoid it if possible.
>>> 
>>
>>I have no problem with not allowing spaces in translated name.  We could 
>>come up with a third field, in the translation, Printable Name or some 
>>such, but that could come later...
> 
> I'm just concerned about parsing code having to distinguish normal
> whitespace field separators (e.g. in ps or ls output) from internal
> separators within a label.  If we allow whitespace within the context,
> we essentially have to start printing them all as quoted strings in all
> the utilities, as well as passing them that way as arguments.

Our MITRE based translator really like the whitespace...  I agree that the
whitespace is a pain, but we have been using this for quite a while and have
not run into problems with any utilities that I am aware of.  My biggest gripe
is having to quote arguments to commands when a context has whitespace...
How about we allow for it, and let those who choose to use whitespace
(unfortunately our translation scheme) deal with the repercussions :)

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
