Subject: Re: [SEMANAGE] Fix up hidden definitions again...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43CE2D21.4050409@cornell.edu>
References: <43CE2D21.4050409@cornell.edu>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 11:15:37 -0500
Message-Id: <1137600937.8926.161.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged 8 patches as of libsemanage 1.5.15:
cache management
bugfix for clear
remove apply_local
only do read locking in direct case
cache error path memory leak fix
auto-generated file header
pywrap test update
hidden defs update

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
