Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CMpPIi020143
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 17:51:25 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CMnO8I001920
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 22:49:24 GMT
Date: Wed, 12 Jan 2005 23:01:48 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050112230148.GC11846@lkcl.net>
References: <20050110232312.GI6967@lkcl.net> <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil> <20050111214818.GE26175@lkcl.net> <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil> <20050112144411.GZ26175@lkcl.net> <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil> <20050112181814.GD26175@lkcl.net> <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil> <20050112182954.GF26175@lkcl.net> <1105565236.23136.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105565236.23136.12.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 12, 2005 at 04:27:16PM -0500, Stephen Smalley wrote:

> single security equivalence class for analysis purposes.  Think:  policy
> says allow P1 F1:file read; allow P2 F2:file write;, policy analysis
> says that there is no allowed information flow from P2 to P1, but
> someone does a chcon -t F1,F2 foobar and now P2 can write to foobar and
> P1 can read from it, so information flow is now possible. 

 yep - and the policy analysis tools would need to understand the
 new format.

 1) if someone does a "chcon -t F2 foobar" all bets would be off as
    far as static analysis is concerned.

 2 ) even if they did chcon -t "F1,F2" foobar, you would still expect
     them to be doing that as an "interim" measure whilst they were
     testing something _pending_ formal analysis by putting that
     into the policy files.

 ... and once they did that, i would rationally expect the
 analysis tools to be able to cope, to "combine" 
 allow P1 F1:file read; allow P2 F2:file write; into some sort of
 pseudo-thing ... mmm... mmm...

 *thinks*...

 the analysis would need the macro-munging approach _anyway_ in
 order to "grok" the new syntax - an intermediate preprocessing
 stage that "notices" multiple-file-applications (including
 possibly expanding regexps!)  and ending up with something
 like this:

 filetype Files_with_F1_and_F2_applied_t;

 allow P1 F1:file read;
 allow P1 Files_with_F1_and_F2_applied_t:file read;
 allow P2 F2:file write;
 allow P2 Files_with_F1_and_F2_applied_t:file write;

 it'd be yeurk - but doable, i think.

 l.
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
