Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01354
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 07:17:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA09252
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 11:15:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA09248 for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 11:15:35 GMT
Date: Mon, 24 Jun 2002 07:16:24 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: vishwakarma singh <vsingh014@yahoo.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: role allow rules
In-Reply-To: <20020621213017.D4F7156@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206240702320.10386-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 21 Jun 2002 17:20, Vishwakarma Singh [inferred] wrote:

>   I like to know whenever a role changes , how the
> ROLE ALLOW RULES  mentioned in the rbac policy
> configuration file  are checked , whether the role
> change is allowed  or not .
>              I also want to know difference between a
> role transition rule and a role allow rule . If there
> are role transition rules , why there is need of role
> allow rules .

Role allow rules specify authorized transitions between roles based on the
pair of roles.  These rules are checked for the process transition
permission.  As noted in Section 4.3.2 of the Configuring the SELinux
Policy report, role allow rules serve little purpose in the example policy
configuration, since most pairings of roles need to be authorized to
support normal transitions among daemons and user processes.  The example
policy configuration uses the constraints configuration to limit role
transitions to certain TE domains that are associated with processes such
as login and newrole.

Role allow rules are used in computing access decisions.  Role transition
rules are used in computing labeling decisions (and are deprecated, as
noted in Section 4.3.3).  See Section 2.1 (Flask Concepts) for an
explanation of access decisions vs. labeling decisions.  Labeling
decisions must be authorized by corresponding access decisions; we do not
implicitly grant the permissions associated with a labeling decision.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
