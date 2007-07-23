Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6NIS5kp002975
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 14:28:05 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6NIS46V000753
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 18:28:04 GMT
Subject: Re: [patch 0/1] Add user object to libpolicyrep
From: Mark Goldman <mgoldman@tresys.com>
To: selinux@tycho.nsa.gov
Cc: jbrindle@tresys.com
In-Reply-To: <20070723173440.880072184@tresys.com>
References: <20070723173440.880072184@tresys.com>
Content-Type: text/plain
Date: Mon, 23 Jul 2007 14:28:00 -0400
Message-Id: <1185215280.5887.15.camel@tresys-winxppro>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-07-23 at 13:34 -0400, mgoldman@tresys.com wrote:
> Added User object to libpolicyrep.
> 
> Signed-off-by: Joshua Brindle
> 
>  include/policyrep/policy.hpp |    1 
>  include/policyrep/user.hpp   |   46 ++++++++++++++++++++++
>  src/policy_parse.y           |    8 +++
>  src/user.cpp                 |   89 +++++++++++++++++++++++++++++++++++++++++++
>  tests/example.te             |    4 +
>  tests/libpolicyrep-test.cpp  |    4 +
>  6 files changed, 152 insertions(+)

Note: This patch does not contain MLS support for users.  This support
will be in a forthcoming MLS patch.

-Mark Goldman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
