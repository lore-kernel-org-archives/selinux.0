Message-ID: <45DF0F4D.7090104@mentalrootkit.com>
Date: Fri, 23 Feb 2007 10:59:09 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [RFC] Drop setlocaldefs support from trunk (2.x series)
References: <1172162502.14363.446.camel@moss-spartans.epoch.ncsc.mil>	 <45DE10D4.3030107@mentalrootkit.com> <1172237335.19041.17.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172237335.19041.17.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-02-22 at 16:53 -0500, Karl MacMillan wrote:
>> Stephen Smalley wrote:
>>> Hi,
>>>
>>> With the migration to libsemanage and managed policy, the setlocaldefs
>>> support in libselinux and underlying support in libsepol for parsing
>>> local booleans and users files is obsolete in modern SELinux
>>> distributions.  Ideally, I'd like to drop it out entirely from the trunk
>>> (2.x series), while preserving it on the stable branch (1.x series).
>>> Specifically, this would mean:
>>> - Removing setlocaldefs support from libselinux,
>>> - Removing sepol_genusers and sepol_genbools and their internal logic
>>> from libsepol, including the legacy config file parsers there.
>>> sepol_genbools_array() would remain due to its use for preserving
>>> actives booleans upon policy reload, but it doesn't require the config
>>> file parser.
>>>
>> That's fine with me, though I question whether the config parsers might 
>> not be better in libsepol than in libsemanage.
> 
> Here we are talking about config parsers for the local booleans file and
> local user definitions, all of which now live in libsemanage and are
> private to it.  Not config parsers for the base policy per se.
> 

My thinking was that future versions of that file might be binary or in 
a subset of the policy language to avoid special parsers. In that case, 
the code to read those files would likely already be in libsepol. We can 
worry about that if it ever comes about though.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
