Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98GpbWt020627
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 12:51:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98Gpa6g002877
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 16:51:36 GMT
Received: from tooheys.dsl.net (tooheys.dsl.net [65.84.81.1])
        by jazzband.ncsc.mil  with ESMTP id h98GpZdq002871 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 16:51:35 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Vikram K'" <vikramatiitkdotacdotin@yahoo.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: A few clarifications - SID, Precondition functions
Date: Wed, 8 Oct 2003 12:51:32 -0400
Message-ID: <004c01c38dbc$6ef51770$8100a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1065620356.8181.110.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, October 08, 2003 9:39 AM,, owner-selinux@tycho.nsa.gov wrote:

> Subject: Re: A few clarifications - SID, Precondition functions
> I think that this is likely the wrong approach.  Rather than creating
> yet another infrastructure within SELinux for loadable policy modules
> (which is really what LSM is for), I'd suggest working on creating a
> real module abstraction in the policy language and
> implementing support
> for policy modules that can be reasonably bounded and can be checked
> for violations of properties of the base policy.  I'd suggest reading
> the following paper as background:
> T. Fraser and L. Badger, _Ensuring Continuity during Dynamic Security
> Policy Reconfiguration in DTE_, Proceedings of the 1998 IEEE
> Symposium on Security and Privacy,
> http://www.computer.org/proceedings/s&p/8386/83860015abs.htm 

As Dave Caplan mentioned in a earlier message, we're currently designing an
enhancement to do policy modules, which we plan to implement once we finish the
conditional policy extensions.

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
