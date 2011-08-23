Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7NDiWVl029638
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 09:44:33 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7NDiWpd028039
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 13:44:33 GMT
Message-ID: <4E53AEC0.7040009@tresys.com>
Date: Tue, 23 Aug 2011 09:44:32 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: HarryCiao <harrytaurus2002@hotmail.com>
CC: <refpolicy@oss1.tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] My patchset to test "Separating tunables from booleans"
References: <SNT139-W51733746CAFD339C4E9177AB2E0@phx.gbl>
In-Reply-To: <SNT139-W51733746CAFD339C4E9177AB2E0@phx.gbl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/23/11 06:27, HarryCiao wrote:
> This is the refpolicy patchset to test along with new toolchain feature
> of separating tunables from booleans, generally speaking a "tunable"
> keyword is introduced and made use of by tunable_policy(), whereas a new
> boolean_policy() macro would make use of the "bool" keyword.
> 
> tunable is indeed a boolean, except that the COND_BOOL_FLAGS_TUNABLE bit
> would be set in the newly added member of flags in the cond_bool_datum_t
> structure.
> 
> Once the new toolchain feature is welcomed and merged, we could change
> refpolicy to shrink policy.X size significantly.
> 
> Any comments or suggestions as for how to better this new toolchain
> feature are greatly welcomed.

To make sure I understand correctly, a tunable block will have the same
token in the raw policy as runtime conditional blocks?  e.g.

tunable foo false;
if (foo) {
 ....
}

If tunable blocks use the same token, I think Refpolicy would just drop
the tunable_policy() macro.

There are no examples of this in Refpolicy, but can you mix Booleans and
tunables in an expression? e.g.

tunable foo true;
boolean bar true;
if (foo || bar) {
....
}

I'd say its not a requirement, I'm just trying to make sure I understand
the features.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
