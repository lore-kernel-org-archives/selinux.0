Subject: Re: XP as a base for NetTop
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: "Dr. Eugene D. Myers" <edm@tycho.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <40B67F41.6020309@snu.edu>
References: <BCDBA110.10B6A%edm@tycho.ncsc.mil>  <40B67F41.6020309@snu.edu>
Content-Type: text/plain
Message-Id: <1086111584.13325.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Jun 2004 13:39:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-27 at 19:52, Joshua Brindle wrote:
> on the slide entitled seperation it says that ACL's are used to protect 
> the disk files so that rogue apps in a vm can't affect other vm's, 
> additionally each vm's disk file is encrypted so that only the 'level' 
> user can access it.
> 
> Obviously both of these things can be done with (SE)Linux but it appears 
>   they thought about this already.

ACLs are a poor substitute for MAC, e.g. see
http://marc.theaimsgroup.com/?l=selinux&m=104508693312829&w=2

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
