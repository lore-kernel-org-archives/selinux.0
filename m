Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Bush, Daniel'" <Daniel.Bush@boeing.com>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: Policy compiler issues.
Date: Thu, 20 May 2004 13:32:33 -0400
Message-ID: <014501c43e90$6f4c2350$4c0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1085070079.521.194.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> 
>> This sounds promising... Could you please direct me to the
>> date range of the messages you're referring to?
> 
> http://marc.theaimsgroup.com/?l=selinux&m=106453351114046&w=2
> http://marc.theaimsgroup.com/?l=selinux&m=105459714906101&w=2
> 
> The binary policy patch tools are out-of-date, and should be obsoleted
> by newer work going on at Tresys to support direct manipulation of
> binary policies.

Steve is correct, the binary patch tool was not maintained, and if I recall
correctly I don't think it supported changing users.  One could certainly hack
together something using that code to work temporarily.

The binary module work Steve indicate is probably a couple of months from
initial release, and will take some time to work out bugs and integration
issues.  Once complete this should make dynamic policy changes easier; for
example we will change our seuser tool to use it so that policy sources are not
needed, nor policy homogeneity across all systems.

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
