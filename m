Subject: Re: Real simple cache that removes most of the lookups in mcstrans
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: russell@coker.com.au, Daniel J Walsh <dwalsh@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <446F8E7C.8010503@gentoo.org>
References: <446AFED3.9010800@redhat.com> <446B3B51.1060703@redhat.com>
	 <446B3E11.6040302@gentoo.org> <200605192333.01639.russell@coker.com.au>
	 <446DCD4C.6000303@gentoo.org>
	 <1148047642.25168.107.camel@moss-spartans.epoch.ncsc.mil>
	 <446F8E7C.8010503@gentoo.org>
Content-Type: text/plain
Date: Mon, 22 May 2006 14:04:38 -0400
Message-Id: <1148321078.24463.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-05-20 at 17:47 -0400, Joshua Brindle wrote:
> Understood, however, if the client is providing a translation service 
> for a user (or other application) it should get notification if that 
> user/app should no longer be able to see the translation, right? The 
> translations are treated like objects in this scheme, unless I'm 
> misunderstanding something.

If the client were providing a translation service for some third party
(as opposed to that third party directly interacting with the
translation daemon), then the client (now a server itself) would be an
object manager in its own right and would need to perform security
checks based on the third party (the client of the client, so to speak).
At which point it is using the AVC itself and has the associated support
for getting notifications of policy reloads.  In the more likely case,
the client is getting data for its own use, and the translation daemon
is checking access based on the client's credentials (which may encode
information about the user and application and even the entire call
chain).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
