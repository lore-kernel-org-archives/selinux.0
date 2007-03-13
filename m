Subject: Re: Confirmation about task_has_security in selinuxfs.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20070313102950.92335.qmail@web86905.mail.ukl.yahoo.com>
References: <20070313102950.92335.qmail@web86905.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 07:54:48 -0400
Message-Id: <1173786888.2738.173.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-13 at 10:29 +0000, JanuGerman wrote:
> Hi All,
> 
> I wanted to confirm that the function
> "task_has_security" is the one which interacts with
> the Security Server for access decisions? and the
> variable "tsec" is the one which stores and conveys
> the ultimate access decision by the SELinux Security
> Server.
> 
> According to documentation, the SELinux FileSystem
> interacts with the Security Server, which further
> checks the possiblity of a decision stored in the
> Access Vector Cache.
> 
> 
> If Not, kindly guide me for the location responsible
> for the interaction with the security server. 

The security server interface is defined in
security/selinux/include/security.h, and implemented in
security/selinux/ss/services.c (the ss/ subdirectory contains all of the
security server code).  The selinuxfs implementation in
security/selinux/selinuxfs.c uses those interfaces to get security
decisions.  Also, the selinuxfs implementation performs permission
checks to control what processes can use its interfaces, and those
checks are performed using task_has_security, which calls the AVC, which
uses a cached decision if present or calls the security server on a
cache miss.  tsec is just a pointer to the task's security state; it
isn't an access decision.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
