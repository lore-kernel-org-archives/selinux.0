Subject: RE: Category Translation patch for MCS/MLS Policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   Daniel J Walsh <Dan-Walsh@comcast.net>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C0618592B93140@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592B93140@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 08:56:11 -0400
Message-Id: <1124196971.29692.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-15 at 16:35 -0400, Chad Hanson wrote:
> Attached is a patch to dlopen libselinux from procps and call getpidcon.
> This patch is relative to procps-3.2.5-6.3 (from Fedora Updates).

Have you tried running this patch by the upstream procps maintainer?
He may want some of this moved into libproc, and he may want to retain
the legal character checks.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
