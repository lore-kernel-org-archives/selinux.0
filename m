Subject: Re: Problems with MCS/Targeted policy update.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <430F5EB7.4000308@redhat.com>
References: <430C776B.4060309@redhat.com>  <430F5EB7.4000308@redhat.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 14:27:40 -0400
Message-Id: <1125080860.8692.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 14:25 -0400, Daniel J Walsh wrote:
> Patch to use raw functions.

Why?  It is a bug somewhere else if they need to use getfilecon_raw here
when they are using matchpathcon() and setfilecon() otherwise.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
