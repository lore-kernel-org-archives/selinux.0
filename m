Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8JNOtsJ001326
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2003 19:24:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8JNNDd0005229
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2003 23:23:13 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8JNNCVY005224
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2003 23:23:12 GMT
Date: Fri, 19 Sep 2003 16:41:23 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Boot time avc messages
Message-ID: <20030919154123.GF22480@vnl.com>
References: <20030915214153.GE8988@vnl.com> <200309172014.59503.russell@coker.com.au> <20030917123747.GF8988@vnl.com> <200309172245.18594.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309172245.18594.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 17, 2003 at 10:45:18PM +1000, Russell Coker wrote:
> It will work on any recent policy tree of mine or of a NSA tree with the 
> patches and revisions I have recently posted to the list.
> I am not sure of what is in Colin's tree at the moment.

Okay, I merged it, although I had to comment out the crond_log_t
dependance since that type isn't here.

Still loads of messages from syslog-ng. I wonder if I'm the
first user of this policy who actually uses the full capability
of remote logging with syslog-ng? I'm going to see if I can
figure out how much of the error output is related to that.
I know at least the one complaining about port=999 is due
to that.

Colin seems to have left out newrules.pl from his packages,
or else it's in one I don't know about.


 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
