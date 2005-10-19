Subject: Re: Loading things into policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <435674F9.5070401@cornell.edu>
References: <43559474.1080905@cornell.edu> <43564E03.70500@tresys.com>
	 <435674F9.5070401@cornell.edu>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 13:36:03 -0400
Message-Id: <1129743363.2375.246.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 12:31 -0400, Ivan Gyurdiev wrote:
> I am saying... should I have a single function in sepol to load objects 
> into policy...or multiple ones. Having a single function seems like the 
> way to go, especially since, at the moment we'll only be using one 
> function (since changes rebuild policy).

Yes, this makes sense to me - ignore my first response.
And I would tend to think that we would want the add-or-modify behavior
in all cases other than booleans (interfaces, ports, users), with the
modify-only-if-exists behavior for booleans.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
