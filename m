Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18275
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 10:55:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA05681
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 14:53:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA05677 for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 14:53:35 GMT
Date: Wed, 26 Jun 2002 10:54:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Brad Chapman <jabiru_croc@yahoo.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Configuration issues on a new installation
In-Reply-To: <20020626134354.53630.qmail@web40003.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0206261049110.13228-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 26 Jun 2002, Brad Chapman wrote:

>        No. My base platform is RedHat 6.2 (heavily modified) with the 2.4.18
> kernel (as mentioned previously) and the SELinux utils package dated 1000hrs
> May 31, 2002.

Ok.  The example policy configuration was originally developed based on
RH6.1 and 6.2, and has been subsequently updated for RH7.1 and 7.2.  But
if your platform is heavily modified, it isn't surprising that you are
encountering plenty of audit messages.

Have you verified that all of your system daemons are being placed into
their own domains, as discussed in the README?  If not, then that is a
natural first step.

You can certainly post excerpts from your /var/log/messages or dmesg
output and we can try to help you in updating your policy.  Try to avoid
including lots of redundant audit messages or trivial audit messages that
you already know how to fix.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
