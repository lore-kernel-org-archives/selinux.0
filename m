Subject: Re: Trouble building Policy-1.16
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Justin Friel <capn_shoe@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20040826161215.2334.qmail@web60002.mail.yahoo.com>
References: <20040826161215.2334.qmail@web60002.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1093537288.9280.177.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 26 Aug 2004 12:21:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-26 at 12:12, Justin Friel wrote:
> I'm using flex 2.5.31 with the patch from deDebian One
> thing I noticed, though was that Fedora creates lex
> with a sysymlinko the flex binary, while the LFLFSook
> suggests you create a wrapper script that calls flex
> with the -l option to run in lex compatibility mode. 
> I recompiled chcheckpolicyith lex as a sysymlinknstead
> of the wrapper script and now "make policy" compiles
> fine.  The question now is, should I permanently ditch
> the lex wrapper, or is the chcheckpolicyource in
> error.

Hmm...I tried rebuilding checkpolicy on Fedora using lex -l rather than
just lex; this did reproduce your warnings, but the resulting
checkpolicy still compiled your policy.conf just fine.  From my reading
of policy_scan.l, :f should not be getting treated as a token, as the
pattern requires at least :f: to match.  So this appears to be a bug in
the scanner produced by your flex, not a bug in checkpolicy itself.

> When I run "make install", however, policy complains
> that I don't have python installed (which I don't). If
> I run "make install" a second time I don't get the
> Python error, but I doubt the policy is installed
> properly.

The policy build is using a python script from policycoreutils
(genhomedircon) to generate the user home directory entries in the
file_contexts configuration.   You can certainly manually hack your
file_contexts configuration instead, or build your policy on a different
machine that does have python available.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
