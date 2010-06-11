Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5BJQ0k6015839
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2010 15:26:00 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o5BJPBC7016965
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2010 19:25:11 GMT
Subject: Re: Minor fixup of checkmodule man page.
From: Steve Lawrence <slawrence@tresys.com>
Reply-To: slawrence@tresys.com
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4BDF0BBA.1040307@redhat.com>
References: <4BDF0BBA.1040307@redhat.com>
Content-Type: text/plain
Date: Fri, 11 Jun 2010 15:25:58 -0400
Message-Id: <1276284358.6342.101.camel@gorgon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-05-03 at 13:45 -0400, Daniel J Walsh wrote:
> Quality Engineering is going through all commands on the system looking
> for mismatches between man page/usage and actual code.
> 
> It found that checkmodule had a -d option that is unused and undocumented -h

Reviewed-by: Steve Lawrence <slawrence@tresys.com>

I'd just add the long --help option to the man page for completeness:

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index a25f25c..54680e3 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -25,7 +25,7 @@ the module package into the module store and load the resulting policy.
 Read an existing binary policy module file rather than a source policy
 module file.  This option is a development/debugging aid.
 .TP
-.B \-h
+.B \-h,\-\-help
 Print usage.
 .TP
 .B \-m


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
