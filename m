Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0HNoD0N009814
	for <selinux@tycho.nsa.gov>; Wed, 17 Jan 2007 18:50:13 -0500
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0HNp66S006025
	for <selinux@tycho.nsa.gov>; Wed, 17 Jan 2007 23:51:07 GMT
Message-ID: <45AEB5DC.9060105@hp.com>
Date: Wed, 17 Jan 2007 18:48:44 -0500
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: polyinstantiation, what should happen?
References: <cadfc0e40701171501j5ebbc57fn6ea9c652fbcc946b@mail.gmail.com>
In-Reply-To: <cadfc0e40701171501j5ebbc57fn6ea9c652fbcc946b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> I'm running the lspp.63 kernel along with the latest pam and newrole
> off of Dan Walsh' people page.
> 
> I've configured polyinstantiation but it doesn't work the way I
> thought it would so either I don't understand or I've got it
> configured wrong. In namespace.conf I've specified that I want context
> to be used for the polyinstantiated instance directories but I only
> getting the user name. Shouldn't the directory name contain the entire
> an context?

Perhaps.  I think the method field specifies when you want to polyinstantiate,
not necessarily what the instance names are, although it makes sense that
the directories would be named using the context and the user name.
I use "level" instead of "context" on my system and I get directory names that
have the full context, including level, plus the user name.  By specifying
"level" but I only get a new instance when I change levels, not when I change
roles.

My namespace.conf looks like this, if you want to give that a try:
/tmp     /tmp/tmp-inst/         level      root,adm
/var/tmp /var/tmp/tmp-inst/     level      root,adm
$HOME    /home/home.inst/       level      root,adm

Do you have any interesting messages in /var/log/secure?  Since you have
the the debug option on your pam_namespace.so lines you should see messages
when it creates an instance directory.

-- ljk

> Also I'm running X so I followed the instructions on the pam_namespace
> man page but wasn't sure whether /etc/pam.d/gdm needed unmnt_remnt as
> su and newrole do?
> 
> Ted


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
