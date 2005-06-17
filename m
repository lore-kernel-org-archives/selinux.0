Subject: Re: mail_client_macros.te
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1118973361.21694.5.camel@localhost.localdomain>
References: <200506170827.59180.russell@coker.com.au>
	 <1118963954.19768.2.camel@localhost.localdomain>
	 <200506171132.07632.russell@coker.com.au>
	 <1118973361.21694.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 07:33:46 -0400
Message-Id: <1119008026.12524.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-16 at 21:56 -0400, Ivan Gyurdiev wrote:
> On Fri, 2005-06-17 at 11:32 +1000, Russell Coker wrote:
> > Do you think we should change the policy to move all port type definitions to 
> > types/network.te and have all ports labeled unconditionally?
> 
> I think so... at least most of them.

Concur.   I think that was discussed earlier - it lets us properly
restrict name_bind for the well-defined ports even when that service
isn't on the machine (without requiring the full domain for the service
to also be present), as well to define proper policy over name_connect
on the client side.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
