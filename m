Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7VG2i97006129
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 12:02:44 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7VG2OSk006192
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 16:02:25 GMT
Date: Thu, 31 Aug 2006 11:02:22 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Joshua Brindle <method@gentoo.org>, russell@coker.com.au,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
Subject: Re: type transitioning script race condition?
Message-ID: <20060831160222.GD12307@w-m-p.com>
References: <20060830223937.GB12307@w-m-p.com> <200608310918.03263.russell@coker.com.au> <44F6539E.7090800@gentoo.org> <1157030632.3106.7.camel@localhost.localdomain> <1157032383.24429.90.camel@twoface.columbia.tresys.com> <1157038164.14623.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157038164.14623.6.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 31, 2006 at 11:29:24AM -0400, Karl MacMillan wrote:
> Sorry - started one message and sent another. If you embed the script
> (as a string) and interpreter in the C wrapper you can avoid the race.

Yes, the important thing is to ensure that raising the privileges and
picking the thing to execute is a single operation.

> In practice - for the scripts we are discussing - if you have sufficient
> privilege to modify the script or the environment to take advantage of
> the race condition you likely have a more direct attack vector. So the
> environment cleansing seems more important to me.

You don't need to modify the script or have special privileges to exploit
the race condition. A possible example looks like this:

- create link to executable (the link can be one of the path components),
  for example:

	ln -s /usr/sbin /tmp/hack

- execute /tmp/hack/semanage

- kernel looks at label of /tmp/hack/semanage, gets the label of
  /usr/sbin/semanage

- kernel decides to do a domain transition, suid, whatever

- kernel executes: /usr/bin/python /tmp/hack/semanage

- attacker redirects /tmp/hack to /tmp/malicious/ which contains a
  different semanage script

- python opens /tmp/hack/semanage which now resolves to
  /tmp/malicious/semanage

(As an aside, I think in this specific case the AppArmor approach of
making the security decisions based on the path name is actually safer
than using the file label. Time for a flame war about "label based
security considered harmful"? ;-)  But the real solution is to avoid the
race in the first place.)

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
