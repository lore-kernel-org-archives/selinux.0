Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11FEE53015959
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 10:14:14 -0500 (EST)
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j11FC6rV006246
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 15:12:06 GMT
Message-ID: <41FF9C1C.9050101@tresys.com>
Date: Tue, 01 Feb 2005 10:11:24 -0500
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: ivg2@cornell.edu, selinux@tycho.nsa.gov,
   selinuxdev <selinux-dev@tresys.com>
Subject: Re: Policy format: apostrophe in comments
References: <1107210569.1928.8.camel@cobra.ivg2.net> <1107260084.26936.32.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107260084.26936.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2005-01-31 at 17:29, Ivan Gyurdiev wrote:
> 
>>What about this bug? It complains about not being able to use
>>apostrophe in the policy config. Any chance this will be fixed,
>>or should I leave it alone? I ask because I was confused
>>what was wrong with my policy when adding apostr. comments. 
>>
>>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=146553
> 
> 
> Yes, that has bothered me as well; it is a curious property of m4 that
> it interprets quotes even within comments.  

I thought this as well.  I discovered, with some help from Gary Vaughan at 
gnu.org, that what I thought was a comment was actually embedded in a 
quoted string.  For example:

define(`only_trans',`
#
# Allow the user's process to transition.
#
allow $1 $3:process transition;
')

The comment is actually _in_ the quoted string, so the apostrophe in the 
comment matches the end delimeter of the string and problems occur.  It 
should really be written as:

define(`only_trans',
#
# Allow the user's process to transition.
#
`
allow $1 $3:process transition;
')

> An option would be to use
> the m4 changequote builtin to change the start-quote and end-quote
> delimiters, but that would require rewriting all actual uses of the
> existing quote characters in the existing policy to use the new
> delimiters.  

Changing the quote delimeter was the suggestion I received from Gary, but 
you are always going to end up vulnerable because of what someone puts into 
what they believe is a comment line.

Obviously not my highest priority, but I'd be willing to
> consider patches that make such a change.
>   

David

-- 
__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
