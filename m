Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VBVPrT011346
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 07:31:25 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VBVP5m019096
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 11:31:25 GMT
Subject: Re: banning copying of binaries (e.g. mozilla etc).
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040830222355.GI31497@lkcl.net>
References: <20040830222355.GI31497@lkcl.net>
Content-Type: text/plain
Message-Id: <1093951787.8517.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 31 Aug 2004 07:29:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-30 at 18:23, Luke Kenneth Casson Leighton wrote:
> okay, got a weird issue where i am curious as to whether selinux could
> help.
> 
> imagine that ipt_owner has been successfully hacked up (hacked as in
> the literal and true meaning of the word not the one the press associate
> with it) to support program names (or as a last resort inodes) as part
> of the checking / filtering rules.
>
> i.e. like fireflier's rather buggy userspace support for allowing
> e.g. mozilla to do port 80 and port 445 but NOT any other program,
> only done properly and in the kernel.

SELinux already allows you to control port binding and socket IPC based
on the domain, which can encode information about the program as well as
the caller.  Why do you need additional state and mechanism?

> now imagine that someone bypasses these rules by simply copying the
> binary.
> 
> in this way, they would be able to at the very least bypass "DENY"
> rules.

You mean "deny program FOO the ability to do X"?  That seems pointless;
you want to define the set of approved programs, not the set of denied
programs, as people can alway construct new programs outside of any
blacklist.

> my question is, therefore, is there an easy way to ban users from
> copying binaries, whilst still allowing users to run them?

The policy can certainly prohibit a given domain from executing anything
it can create/write.  But I still don't see what you are trying to
achieve.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
