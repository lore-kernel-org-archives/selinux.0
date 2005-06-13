Subject: Re: Question about integration of IPsec with SELinux?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Park Lee <parklee_sel@yahoo.com>, Casey Schaufler <casey@schaufler-ca.com>,
   Valdis.Kletnieks@vt.edu, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050612114421.GA31033@lkcl.net>
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com>
	 <20050612021611.94597.qmail@web51501.mail.yahoo.com>
	 <20050612114421.GA31033@lkcl.net>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 08:37:10 -0400
Message-Id: <1118666230.24565.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-06-12 at 12:44 +0100, Luke Kenneth Casson Leighton wrote:
>  btw i should also raise - again - the wisdom of only utilising
>  a 32-bit security descriptor in a networked environment.
> 
>  only 32-bit means that if you want to merge or join two secure
>  environments together, well.... you basically can't: you have a clash
>  of 32-bit SIDs.
> 
>  with NT / VAX-VMS style security descriptors (comprising 4of 32-bit
>  "SIDs" for a domain and a 32-bit "RID" - relative ID) you can at least
>  start creating inter-domain trust relationships.

As is clearly noted in all SELinux documentation, SIDs are purely non-
global (node-local) and non-persistent handles to security contexts.
And as of Linux 2.6, they are furthermore kernel-private (or in the case
of the userspace AVC, application-private).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
