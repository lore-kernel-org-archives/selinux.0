Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0DH7CIi025272
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 12:07:13 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0DH5BPs013408
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 17:05:12 GMT
Date: Thu, 13 Jan 2005 17:17:32 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050113171732.GK17414@lkcl.net>
References: <20050111214818.GE26175@lkcl.net> <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil> <20050112144411.GZ26175@lkcl.net> <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil> <20050112181814.GD26175@lkcl.net> <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil> <20050112182954.GF26175@lkcl.net> <1105565236.23136.12.camel@moss-spartans.epoch.ncsc.mil> <20050112230148.GC11846@lkcl.net> <1105634671.24406.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105634671.24406.59.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 13, 2005 at 11:44:31AM -0500, Stephen Smalley wrote:
> On Wed, 2005-01-12 at 18:01, Luke Kenneth Casson Leighton wrote:
> >  2 ) even if they did chcon -t "F1,F2" foobar, you would still expect
> >      them to be doing that as an "interim" measure whilst they were
> >      testing something _pending_ formal analysis by putting that
> >      into the policy files.
> 
> BTW, idle question:  how do you decide whether to allow setting such
> combinations on a file?  

 i thought that it would be because the "intermediate" stage would have
 generated a filetype called "F1,F2" which may actually only require
 some extensions etc. to simply add "," as an allowed character in the
 file types and the policy compiler.

 and there would therefore be in the policy.conf file lots of things
 like "allow F1,F2 such-and-such".

 i thought that the only tricky bit would be at policy compile-time to
 have to run through the complete list of files on the filesystem (which
 is done by setfiles _anyway) making a distinction between the overlap
 of the regexp associated with F1 and the regexp associated with F2.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
