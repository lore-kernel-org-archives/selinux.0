Subject: Re: [patch] policydb - MLS
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@tcs-sec.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
In-Reply-To: <791924EBDA572C4FA970D4A94AA95DA309E3B5@chaos.tcs.tcs-sec.com>
References: <791924EBDA572C4FA970D4A94AA95DA309E3B5@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1078256871.9775.207.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Mar 2004 14:47:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-03-02 at 14:29, Chad Hanson wrote:
> I have attached a patch to checkpolicy and the kernel to allow MLS to work
> correctly with new conditional policy extensions. The problem is an ordering

- (nit) The first attachment was the entire file, not a patch.
- (nit) Please generate patches in unified format, i.e. diff -u.
- Won't this change break the compatibility code that allows loading of
policy.15 files?  Instead of dropping the bools symtab when loading a
policy.15 file, it will end up dropping the cats symtab with your patch.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
